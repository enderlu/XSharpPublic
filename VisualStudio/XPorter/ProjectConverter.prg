// Application : XPorter
// XPorter.prg , Created : 28-9-2016   15:02
// User : robert

USING System.Collections.Generic
USING System.Xml                           
DEFINE EXTENSION := "xsproj"  AS STRING

	
CLASS ProjectConverter
	PROTECT oDoc 	AS XmlDocument  
	PROTECT nGroup  AS LONG
	PROTECT cSchema AS STRING  
	PROTECT cGuid   AS STRING
	PROTECT cPath	AS STRING   
	PROTECT oProgress AS IProgress         
	PROTECT lVulcanRtWritten AS LOGIC
	PROTECT oProjectNode as XmlElement
	PROTECT lHasProjectExtensions as LOGIC
	PROPERTY Guid AS STRING GET cGuid
	CONSTRUCTOR(oProg AS IProgress)
		cSchema := "http://schemas.microsoft.com/developer/msbuild/2003"
		nGroup  := 0
        cGuid   := System.Guid.NewGuid().ToString("B"):ToUpper()
        lVulcanRtWritten := FALSE
        SELF:oProgress := oProg
        
METHOD ConvertProjectFile(cSource AS STRING, cTarget AS STRING) AS LOGIC      
	oProgress:WriteLine("Creating ... "+System.IO.Path.GetFileName(cTarget))
	cPath := System.IO.Path.GetDirectoryName(cSource)+"\"
	IF ! SELF:LoadFile(cSource)
		RETURN FALSE
	ENDIF                            
	SELF:WalkNode(oDoc)   
	if (!lHasProjectExtensions )
		VAR oExt := oDoc:CreateElement("ProjectExtensions",cSchema)
		VAR oCap := oDoc:CreateElement("ProjectCapabilities",cSchema)
		oExt:AppendChild(oCap)
		oCap:AppendChild(oDoc:CreateElement("ProjectConfigurationsDeclaredAsItems",cSchema))
		oProjectNode:AppendChild(oExt)
	ENDIF
	SELF:SaveFile(cTarget)
	RETURN TRUE	

  METHOD Save2String() AS STRING STRICT 
      LOCAL cString         AS STRING
      LOCAL oWriter             AS System.Xml.XmlTextWriter
      LOCAL oStringWriter       AS System.IO.StringWriter
      cString := oDoc:OuterXml
      oStringWriter := System.IO.StringWriter{}
      oWriter     := System.Xml.XmlTextWriter{oStringWriter}
      oWriter:Formatting := System.Xml.Formatting.Indented
      oDoc:WriteTo(oWriter)
      cString := oStringWriter:ToString()
      RETURN cString
   
   METHOD SaveFile(strFileName AS STRING) AS LOGIC STRICT 
      LOCAL lRet        AS LOGIC
      LOCAL oTargetFile  AS System.IO.StreamWriter
      lRet := FALSE
      IF oDoc:HasChildNodes
         oTargetFile := System.IO.StreamWriter{strFileName, FALSE}
         oTargetFile:Write( SELF:Save2String() )
         oTargetFile:Close()
         lRet := TRUE
      ENDIF
      RETURN lRet


METHOD CloneNode(oNode AS XmlNode) AS XmlNode
	LOCAL oResult AS XmlNode
	oResult := oNode:CloneNode(FALSE)   
	oResult:InnerText := oNode:InnerText
	RETURN oResult                      

METHOD UpdateNode(oParent AS XmlNode, oElement AS XmlElement) AS VOID
	LOCAL oChild AS XmlElement
	LOCAL oAttribute AS XmlAttribute
	IF aDelete:Contains(oElement:Name:ToLower())
		// remove the node
		oParent:RemoveChild(oElement)     
	ELSEIF aRename:ContainsKey(oElement:Name)    
		// Renaming Nodes is not supported. Create a new node and 
		// Copy its attributes and children
		// and then replace the existing node
		oChild := oDoc:CreateElement(aRename[oElement:Name],cSchema)
		DO WHILE oElement:HasAttributes
			oChild:SetAttributeNode(oElement:RemoveAttributeNode(oElement:Attributes[0]))
		ENDDO              
		DO WHILE oElement:HasChildNodes
			oChild:AppendChild(oElement:FirstChild)
		ENDDO
		oParent:ReplaceChild(oChild, oElement)				
	ELSE    
		// Some nodes that require special processing
		SWITCH oElement:Name:ToLower()
		CASE "compile"    
		CASE "none"    
		CASE "vobinary"
		CASE "nativeresource"
			VAR cItem := oElement:GetAttribute("Include")
			cItem := cPath+cItem
			VAR oChild1 := oElement:FirstChild
			IF oChild1 != NULL .and. oChild1:Name:ToLowerInvariant() == "dependentupon"
				VAR  cInnerText := oChild1:InnerText
				IF cInnerText:Contains("\")
					// check to see if parent node is in the same folder as the child node.
					if System.IO.File.Exists(cItem) .and. System.IO.File.Exists(cPath+cInnerText)
						if System.IO.Path.GetFullPath(cItem) == System.IO.Path.GetFullPath(cPath+cInnerText)
							// paths are equal, only write filename
							cInnerText := System.IO.Path.GetFileName(cInnerText)
							oChild1:InnerText := cInnerText
						ENDIF
					endif
				ENDIF
			ENDIF

		CASE "import"               
			// change import 
			oAttribute := (XmlAttribute) oElement:Attributes:GetNamedItem("Project")
			IF oAttribute:Value:ToLower():Contains("vulcan.net")
				oAttribute:Value := "$(XSharpProjectExtensionsPath)XSharp.props"
			ENDIF
		CASE "projectguid"   
			// new guid
			oElement:InnerText := cGuid
		CASE "projecttypeguids"   
			// WPF project
			// our WPF ProjectFactory
			// Generic WPF project 
			// Our project factory
			oElement:InnerText := "{5ADB76EC-7017-476A-A8E0-25D4202FFCF0};{60DC8134-EBA5-43B8-BCC9-BB4BC16C2548};{AA6C8D78-22FF-423A-9C7C-5F2393824E04}" 
		CASE "projectreference"
			// update extension in project references 
			oAttribute := (XmlAttribute) oElement:Attributes:GetNamedItem("Include")
			IF oAttribute != NULL
				oAttribute:Value := oAttribute:Value:Replace(".vnproj", "."+EXTENSION)
			ENDIF
		CASE "propertygroup"
			// Only insert code inside the first propertygroup
			IF ++nGroup == 1
				LOCAL oImport AS XmlNode
				// Add Import
				oImport := oDoc:CreateElement("Import",cSchema)
				oAttribute := oDoc:CreateAttribute("Project")
				oAttribute:Value := "$(MSBuildExtensionsPath)\XSharp\XSharp.Default.props"
				oImport:Attributes:Append(oAttribute)
				oParent:InsertBefore(oImport, oElement)
				// Add propertygroup before Import with Label="Globals" and child <XSharpProjectExtensionsPath>
				oChild := oDoc:CreateElement( "PlatformTarget", cSchema)
				oChild:InnerText := "x86"
				oElement:InsertBefore(oChild,oElement:FirstChild)
				oChild := oDoc:CreateElement( "Dialect", cSchema)
				oChild:InnerText := "Vulcan"
				oElement:InsertBefore(oChild,oElement:FirstChild)
				oChild := oDoc:CreateElement( "XSharpProjectExtensionsPath", cSchema)
				oChild:InnerText := "$(MSBuildExtensionsPath)\XSharp\"
				oElement:InsertBefore(oChild, oElement:FirstChild )
	
				LOCAL lHasCondition := FALSE AS LOGIC
				IF oElement:HasAttributes    
					lHasCondition := (oElement:Attributes:GetNamedItem("Condition") != NULL)
				ENDIF
				IF ! lHasCondition
					oChild := oDoc:CreateElement("Platform", cSchema)
					oAttribute := oDoc:CreateAttribute("Condition")
					oAttribute:Value := " '$(Platform)' == '' "
					oChild:Attributes:Append(oAttribute)
					oChild:InnerText := "AnyCPU"
					oElement:PrependChild(oChild)
				ENDIF
			ELSE
				// ALl other project groups.
				// Adjust the condition when needed
				VAR oCondition := (XMLAttribute) oElement:Attributes:GetNamedItem("Condition") 
				// <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|AnyCPU'" Label="Configuration">
				IF oCondition != NULL
					VAR  cInnerText := oCondition:InnerText
					if ! cInnerText:ToLower():Contains("platform")
						if cInnerText:ToLower():Contains("release")
							oCondition:InnerText := "'$(Configuration)|$(Platform)'=='Release|AnyCPU'"
						else
							oCondition:InnerText := "'$(Configuration)|$(Platform)'=='Debug|AnyCPU'"
						endif
					ENDIF
				ENDIF
			ENDIF
		CASE "projectextensions"
			// add <ProjectCapabilities><ProjectConfigurationsDeclaredAsItems /></ProjectCapabilities>
			oChild := oDoc:CreateElement("ProjectCapabilities",cSchema)
			oChild:AppendChild(oDoc:CreateElement("ProjectConfigurationsDeclaredAsItems",cSchema))
			oElement:AppendChild(oChild)
			lHasProjectExtensions := TRUE
		CASE "project"
			// Only for main project node, not for project node inside projectreference
			if (oParent is XMLDocument)
				// Import the schema
				SELF:oProjectNode := oElement
				oChild := oDoc:CreateElement("Import", cSchema)
				oAttribute := oDoc:CreateAttribute("Project")
				oAttribute:Value := "$(XSharpProjectExtensionsPath)XSharp.targets"
				oChild:Attributes:Append(oAttribute)   
				oElement:AppendChild(oChild)  
			ENDIF
		CASE "reference"                               
			// Add VulcanRT assemblies after 1st reference
			IF !SELF:lVulcanRtWritten
				oChild := oDoc:CreateElement("Reference",cSchema)    
				oAttribute := oDoc:CreateAttribute("Include")
				oAttribute:Value := "VulcanRT"
				oChild:Attributes:Append(oAttribute)   
				VAR oSub := oDoc:CreateElement("Name",cSchema)
				oSub:InnerText := "VulcanRT"
				oChild:AppendChild(oSub)                         
				oSub := oDoc:CreateElement("AssemblyName",cSchema)
				oSub:InnerText := "VulcanRT.DLL"
				oChild:AppendChild(oSub)                         
				oElement:ParentNode:AppendChild(oChild)				
				oChild := oDoc:CreateElement("Reference",cSchema)
				oAttribute := oDoc:CreateAttribute("Include")
				oAttribute:Value := "VulcanRTFuncs"
				oChild:Attributes:Append(oAttribute)
				oSub := oDoc:CreateElement("Name",cSchema)
				oSub:InnerText := "VulcanRTFuncs"
				oChild:AppendChild(oSub)                         
				oSub := oDoc:CreateElement("AssemblyName",cSchema)
				oSub:InnerText := "VulcanRTFuncs.DLL"
				oChild:AppendChild(oSub)                         
				oElement:ParentNode:AppendChild(oChild)				
				SELF:lVulcanRtWritten := TRUE
			ENDIF
		OTHERWISE   
			// All other elements should not be changed
			NOP
		END SWITCH
	ENDIF                                   
	RETURN	
	
METHOD WalkNode(oNode AS XmlNode) AS VOID       
	LOCAL aChildren AS List<XmlNode>
	aChildren := List<XmlNode>{}
	FOREACH oChild AS XmlNode IN oNode:ChildNodes
		aChildren:Add(oChild)
	NEXT
	FOREACH oChild AS XmlNode IN aChildren
		IF oChild IS XmlElement
			SELF:UpdateNode(oNode, (XmlElement) oChild)
		ENDIF
		SELF:WalkNode((XMlNode) oChild)
	NEXT
	RETURN

    PROTECT METHOD _LoadFileFromReader(oReader AS System.IO.TextReader) AS LOGIC STRICT 
        LOCAL lOk AS LOGIC
        TRY
            oDoc := System.Xml.XmlDocument{}
            oDoc:Load(oReader)
            lOk := TRUE
        CATCH
            lOk := FALSE
        END TRY
        RETURN lOk

   METHOD LoadFile(strFileName AS STRING) AS LOGIC STRICT 
        LOCAL lResult := FALSE AS LOGIC
        IF System.IO.File.Exists(strFileName)
            LOCAL oReader AS System.IO.TextReader
            oReader := System.IO.StreamReader{strFileName,TRUE}
            lResult := SELF:_LoadFileFromReader(oReader)
            oReader:Close()
        ENDIF
        RETURN lResult

   METHOD LoadFileFromString(strXMLString AS STRING) AS LOGIC STRICT 
        LOCAL lResult AS LOGIC
        LOCAL oReader AS System.IO.StringReader
        oReader := System.IO.StringReader{strXMLString}
        lResult := SELF:_LoadFileFromReader(oReader)
        oReader:Close()
        RETURN lResult	
        

	STATIC PROTECT aRename AS Dictionary<STRING, STRING>
	STATIC PROTECT aDelete AS List<STRING>	
	STATIC CONSTRUCTOR()
		aRename := Dictionary<STRING, STRING> {StringComparer.CurrentCultureIgnoreCase}
		aRename:Add("ZeroBasedArrays","AZ")
		aRename:Add("CaseSensitiveIdentifiers","CS")
		aRename:Add("CheckFloatOverflows","FOVF")
		aRename:Add("ImplicitNamespaceLookup","INS")
		aRename:Add("AllowLateBinding","LB")
		aRename:Add("UseDefaultNamespace","NS")
		aRename:Add("CheckForOverflowUnderflow","OVF")
		aRename:Add("GeneratePreprocessorOutput","PPO")
		aRename:Add("AllowUnsafeCode","UnSafe")
		aRename:Add("VOCompatibleStringInit","VO2")
		aRename:Add("AllMethodsVirtual","VO3")
		aRename:Add("ImplicitSignConversions","VO4")
		aRename:Add("VOCompatibleCallingConventions","VO5")
		aRename:Add("VOResolveFunctionPointers","VO6")
		aRename:Add("VOCompatibleImplicitConversions","VO7")
		aRename:Add("VOCompatiblePreprocessor","VO8")
		aRename:Add("VOCompatibleImplicitRetvals","VO9")
		aRename:Add("VOCompatibleIIF","VO10")
		aRename:Add("VOCompatibleArithmeticConversions","VO11")
		aRename:Add("IntegerDivisionsReturnFloat","VO12")
		aRename:Add("VOCompatibleStringComparisons","VO13")
		aRename:Add("VOFloatLiterals","VO14")		
		aRename:Add("AdditionalOptions","CommandLineOption")
		// Items to delete
		
		VAR aTemp := List<STRING>{}
		aTemp:Add("DisabledWarnings")
		aTemp:Add("ProjectName")
		aTemp:Add("ProjectExt")
		aTemp:Add("ProjectDir")
		aTemp:Add("ProjectFileName")
		aTemp:Add("ProjectPath")
		aTemp:Add("ProjectView")    
		aTemp:Add("SchemaVersion")    
		aDelete := List<STRING>{}
		FOREACH s AS STRING IN aTemp
			aDelete:Add(s:ToLower())
		NEXT
		
		
	RETURN

STATIC METHOD Convert(cFile AS STRING, oProgress AS IProgress) AS VOID
	LOCAL oConverter AS ProjectConverter
	LOCAL cSource AS STRING
	LOCAL cTarget AS STRING
	oConverter := ProjectConverter{oProgress}
	cSource := cFile
	cTarget := System.IO.Path.ChangeExtension(cSource, EXTENSION)
	IF oConverter:ConvertProjectFile(cSource, cTarget)
		oProgress:WriteLine( "Converted "+System.IO.Path.GetFileName(cSource)+" to " +System.IO.Path.GetFileName(cTarget))
	ELSE
		oProgress:WriteLine( "An error occurred")
	ENDIF
	RETURN
	
        
END CLASS        



