//
// Copyright (c) XSharp B.V.  All Rights Reserved.
// Licensed under the Apache License, Version 2.0.
// See License.txt in the project root for license information.
//

using System;
using System.Runtime.InteropServices;
using Microsoft.VisualStudio.Shell;
using Microsoft.VisualStudio.Project;
using Microsoft.VisualStudio;
using Microsoft.VisualStudio.Shell.Interop;
using Microsoft.VisualStudio.OLE.Interop;
using Microsoft.VisualStudio.Package;
using Microsoft.VisualStudio.TextManager.Interop;

using XSharp.LanguageService;
using XSharp.Project.WPF;
using System.ComponentModel;
using System.ComponentModel.Design;
using System.Globalization;
#if VODESIGNER
using XSharp.VOEditors;
#endif
namespace XSharp.Project
{

    /// <summary>
    /// This class implements the package exposed by this assembly.
    /// </summary>
    /// <remarks>
    /// <para>A Visual Studio component can be registered under different registry roots; for instance
    /// when you debug your package you want to register it in the experimental hive. This
    /// attribute specifies the registry root to use if no one is provided to regpkg.exe with
    /// the /root switch.</para>
    /// <para>A description of the different attributes used here is given below:</para>
    /// <para>DefaultRegistryRoot: This defines the default registry root for registering the package.
    /// We are currently using the experimental hive.</para>
    /// <para>ProvideObject: Declares that a package provides creatable objects of specified type.</para>
    /// <para>ProvideProjectFactory: Declares that a package provides a project factory.</para>
    /// <para>ProvideProjectItem: Declares that a package provides a project item.</para>
    /// </remarks>
    ///
    [InstalledProductRegistration("#110", "#112", XSharp.Constants.Version, IconResourceID = 400)]
    [Description("XSharp Project System")]
    [PackageRegistration(UseManagedResourcesOnly = true)]
    [DefaultRegistryRoot("Software\\Microsoft\\VisualStudio\\14.0")]
    [ProvideObject(typeof(XSharpGeneralPropertyPage))]      // 53651BEA-799A-45EB-B58C-C884F5417219
    [ProvideObject(typeof(XSharpLanguagePropertyPage))]     // 2652FCA6-1C45-4D25-942D-4C5D5EDE9539
    [ProvideObject(typeof(XSharpBuildPropertyPage))]        // E994C210-9D6D-4CF4-A061-EBBEA2BC626B
    [ProvideObject(typeof(XSharpBuildEventsPropertyPage))]  // 49306259-9119-466E-8780-486CFBE2597D
    [ProvideObject(typeof(XSharpDebugPropertyPage))]        // 2955A638-C389-4675-BB1C-6B2BC173C1E7
    [ProvideProjectFactory(typeof(XSharpProjectFactory),
        XSharpConstants.LanguageName,
        XSharpConstants.LanguageName + " Project Files (*." + XSharpConstants.ProjectExtension + ");*." + XSharpConstants.ProjectExtension,
        XSharpConstants.ProjectExtension,
        XSharpConstants.ProjectExtensions,
        @".NullPath", LanguageVsTemplate = "XSharp", NewProjectRequireNewFolderVsTemplate = false)]

    [ProvideService(typeof(XSharpLanguageService), ServiceName = "XSharp Language Service")]
    [ProvideLanguageExtension(typeof(XSharpLanguageService), ".prg")]
    [ProvideLanguageExtension(typeof(XSharpLanguageService), ".ppo")]
    [ProvideLanguageExtension(typeof(XSharpLanguageService), ".xs")]
    [ProvideLanguageExtension(typeof(XSharpLanguageService), ".xh")]
    [ProvideLanguageExtension(typeof(XSharpLanguageService), ".vh")]
    [ProvideLanguageService(typeof(XSharpLanguageService),
                         "XSharp",
                         1,                            // resource ID of localized language name
                         AutoOutlining =true,
                         CodeSense = true,             // Supports IntelliSense
                         CodeSenseDelay = 1000,        // Delay to wait
                         DefaultToInsertSpaces = true,
                         DefaultToNonHotURLs = true,
                         EnableAdvancedMembersOption =true,
                         EnableAsyncCompletion = true, // Supports background parsing
                         EnableCommenting = true,      // Supports commenting out code
                         EnableFormatSelection = true,
                         EnableLineNumbers =true,
                         MatchBraces =true,
                         MatchBracesAtCaret =true,
                         MaxErrorMessages =10,
                         QuickInfo = true,
                         RequestStockColors = false,   // Supplies custom colors
                         ShowCompletion =true,
                         ShowDropDownOptions = true,    // Supports NavigationBar 
                         ShowMatchingBrace =true,
                         ShowSmartIndent = false,
                         SingleCodeWindowOnly = false,
                         SupportCopyPasteOfHTML = false
                 )]
    [ProvideLanguageCodeExpansionAttribute(
         typeof(XSharpLanguageService),
         "XSharp",  // Name of language used as registry key.
         1,         // Resource ID of localized name of language service.
         "XSharp",  // language key used in snippet templates.
         @"%InstallRoot%\Common7\IDE\Extensions\XSharp\Snippets\%LCID%\SnippetsIndex.xml",  // Path to snippets index
         SearchPaths = @"%InstallRoot%\Common7\IDE\Extensions\XSharp\Snippets\%LCID%\Snippets;" +
                  @"\%MyDocs%\Code Snippets\XSharp\My Code Snippets"
         )]

    /*
        [ProvideLanguageEditorOptionPageAttribute()
                 "{A2FE74E1-FFFF-3311-4342-123052450768}",  // GUID of property page
                 "XSharp",  // Registry key name for language
                 "Options",      // Registry key name for property page
                 "#242"         // Localized name of property page
                 )]
        [ProvideLanguageEditorOptionPageAttribute(
                 "XSharp",  // Registry key name for language
                 "Advanced",     // Registry key name for node
                 "#243"         // Localized name of node
                 )]
        [ProvideLanguageEditorOptionPageAttribute(
            "{A2FE74E2-FFFF-3311-4342-123052450768}",  // GUID of property page
            "XSharp",  // Registry key name for language
                 @"Advanced\Indenting",     // Registry key name for property page
                 "#244"         // Localized name of property page

                 )]


    [ProvideLanguageEditorOptionPage(typeof(Options.AdvancedOptionPage), "CSharp", null, "Advanced", pageNameResourceId: "#102", keywordListResourceId: 306)]
        [ProvideLanguageEditorOptionPage(typeof(Options.Formatting.FormattingStylePage), "CSharp", null, @"Code Style", pageNameResourceId: "#114", keywordListResourceId: 313)]
        [ProvideLanguageEditorOptionPage(typeof(Options.IntelliSenseOptionPage), "CSharp", null, "IntelliSense", pageNameResourceId: "#103", keywordListResourceId: 312)]
        [ProvideLanguageEditorOptionPage(typeof(Options.Formatting.FormattingOptionPage), "CSharp", "Formatting", "General", pageNameResourceId: "#108", keywordListResourceId: 307)]
        [ProvideLanguageEditorOptionPage(typeof(Options.Formatting.FormattingIndentationOptionPage), "CSharp", "Formatting", "Indentation", pageNameResourceId: "#109", keywordListResourceId: 308)]
        [ProvideLanguageEditorOptionPage(typeof(Options.Formatting.FormattingWrappingPage), "CSharp", "Formatting", "Wrapping", pageNameResour
    */
    [ProvideProjectFactory(typeof(XSharpWPFProjectFactory),
        null,
        null,
        null,
        null,
        null,
        LanguageVsTemplate = XSharpConstants.LanguageName,
        TemplateGroupIDsVsTemplate = "WPF",
        ShowOnlySpecifiedTemplatesVsTemplate = false, SortPriority =100)]

    [ProvideProjectItem(typeof(XSharpProjectFactory), "XSharp Items", @"ItemTemplates\Class", 500)]
    [ProvideProjectItem(typeof(XSharpProjectFactory), "XSharp Items", @"ItemTemplates\Form", 500)]

    [ProvideEditorExtension(typeof(XSharpEditorFactory), ".prg", 0x42, DefaultName = "XSharp Source Code Editor",NameResourceID =109)]
    [ProvideEditorExtension(typeof(XSharpEditorFactory), ".xs", 0x42, DefaultName = "XSharp Source Code Editor", NameResourceID = 109)]
    [ProvideEditorExtension(typeof(XSharpEditorFactory), ".vh", 0x42, DefaultName = "XSharp Source Code Editor", NameResourceID = 109)]
    [ProvideEditorExtension(typeof(XSharpEditorFactory), ".xh", 0x42, DefaultName = "XSharp Source Code Editor", NameResourceID = 109)]
    [ProvideEditorExtension(typeof(XSharpEditorFactory), ".ppo", 0x42, DefaultName = "XSharp Source Code Editor", NameResourceID = 109)]
    // This tells VS that we support Code and Designer view
    // The guids are VS specific and should not be changed
    [ProvideEditorLogicalView(typeof(XSharpEditorFactory), VSConstants.LOGVIEWID.Designer_string)]
    [ProvideEditorLogicalView(typeof(XSharpEditorFactory), VSConstants.LOGVIEWID.Code_string)]

#if VODESIGNER
    // Editors for VOBinaries
    [ProvideEditorExtension(typeof(VOFormEditorFactory),        ".xsfrm", 0x42, DefaultName = "XSharp VO Form Editor", NameResourceID = 80110)]
    [ProvideEditorExtension(typeof(VOMenuEditorFactory),        ".xsmnu", 0x42, DefaultName = "XSharp VO Menu Editor", NameResourceID = 80111)]
    [ProvideEditorExtension(typeof(VODBServerEditorFactory),    ".xsdbs", 0x42, DefaultName = "XSharp VO DbServer Editor", NameResourceID = 80112)]
    [ProvideEditorExtension(typeof(VOFieldSpecEditorFactory),   ".xsfs", 0x42, DefaultName = "XSharp VO FieldSpec Editor", NameResourceID = 80113)]
    // Vulcan Binaries
    [ProvideEditorExtension(typeof(VOFormEditorFactory), ".vnfrm", 0x42, DefaultName = "XSharp VO Form Editor", NameResourceID = 80110)]
    [ProvideEditorExtension(typeof(VOMenuEditorFactory), ".vnmnu", 0x42, DefaultName = "XSharp VO Menu Editor", NameResourceID = 80111)]
    [ProvideEditorExtension(typeof(VODBServerEditorFactory), ".vndbs", 0x42, DefaultName = "XSharp VO DbServer Editor", NameResourceID = 80112)]
    [ProvideEditorExtension(typeof(VOFieldSpecEditorFactory), ".vnfs", 0x42, DefaultName = "XSharp VO FieldSpec Editor", NameResourceID = 80113)]
    [ProvideEditorLogicalView(typeof(VOFormEditorFactory), VsConstants.LOGVIEWID.Designer_string)]
    [ProvideEditorLogicalView(typeof(VOMenuEditorFactory), VsConstants.LOGVIEWID.Designer_string)]
    [ProvideEditorLogicalView(typeof(VODBServerEditorFactory), VsConstants.LOGVIEWID.Designer_string)]
    [ProvideEditorLogicalView(typeof(VOFieldSpecEditorFactory), VsConstants.LOGVIEWID.Designer_string)]
#endif

    [SingleFileGeneratorSupportRegistrationAttribute(typeof(XSharpProjectFactory))]  // 5891B814-A2E0-4e64-9A2F-2C2ECAB940FE"
    //[CodeGeneratorRegistration(typeof(XSharpProjectFactory), generatorName: "ResXFileCodeGenerator", contextGuid: "ResXFileCodeGenerator", GeneratesDesignTimeSource =true, GeneratorRegKeyName = "Microsoft ResX File Code Generator")]
    //[CodeGeneratorRegistration(typeof(XSharpProjectFactory), generatorName: "PublicResXFileCodeGenerator", contextGuid: "{69b6a86d-ef43-4d9e-a758-8a18b38a7384}", GeneratesDesignTimeSource=true,GeneratorRegKeyName = "Microsoft ResX File Code Generator (public class)")]
    //[CodeGeneratorRegistration(typeof(XSharpProjectFactory), generatorName: "SettingsSingleFileGenerator", contextGuid: "{3B4C204A-88A2-3AF8-BCFD-CFCB16399541}", GeneratesDesignTimeSource = false, GeneratesSharedDesignTimeSource =true,GeneratorRegKeyName = "Generator for strongly typed settings class")]
    //[CodeGeneratorRegistration(typeof(XSharpProjectFactory), generatorName: "PublicSettingsSingleFileGenerator", contextGuid: "{940f36b5-a42e-435e-8ef4-20b9d4801d22}", GeneratesDesignTimeSource = false, GeneratesSharedDesignTimeSource = true, GeneratorRegKeyName = "Generator for strongly typed settings class (public class)")]
    [Guid(GuidStrings.guidXSharpProjectPkgString)]
    public sealed class XSharpProjectPackage : ProjectPackage, IOleComponent
    {
        private uint m_componentID;
        private static XSharpProjectPackage instance;
        private XPackageSettings settings;

        // =========================================================================================
        // Properties
        // =========================================================================================

        /// <summary>
        /// Gets the singleton XSharpProjectPackage instance.
        /// </summary>
        public static XSharpProjectPackage Instance
        {
            get { return XSharpProjectPackage.instance; }
        }
        #region Overridden Implementation
        /// <summary>
        /// Initialization of the package; this method is called right after the package is sited, so this is the place
        /// where you can put all the initialization code that rely on services provided by VisualStudio.
        /// </summary>
        protected override void Initialize()
        {
            base.Initialize();
            XSharpProjectPackage.instance = this;
            this.RegisterProjectFactory(new XSharpProjectFactory(this));
            this.settings = new XPackageSettings(this);

            // Indicate how to open the different source files : SourceCode or Designer ??
            this.RegisterEditorFactory(new XSharpEditorFactory(this));
            this.RegisterProjectFactory(new XSharpWPFProjectFactory(this));

#if VODESIGNER
            // editors for the binaries
            base.RegisterEditorFactory(new VOFormEditorFactory(this));
            base.RegisterEditorFactory(new VOMenuEditorFactory(this));
            base.RegisterEditorFactory(new VODBServerEditorFactory(this));
            base.RegisterEditorFactory(new VOFieldSpecEditorFactory(this));
#endif
            // Register the language service
            // Add our command handlers for menu (commands must exist in the .vsct file)
            OleMenuCommandService mcs = GetService(typeof(IMenuCommandService)) as OleMenuCommandService;
            if (null != mcs)
            {
                // Create the command for the menu item.
                CommandID menuCommandID = new CommandID(GuidStrings.guidXSharpLanguageServiceCmdSet, (int)PkgCmdIDList.cmdidInsertSnippet);
                MenuCommand menuItem = new MenuCommand(MenuItemCallback, menuCommandID);
                mcs.AddCommand(menuItem);
            }

            // Proffer the service.
            IServiceContainer serviceContainer = this as IServiceContainer;
            XSharpLanguageService langService = new XSharpLanguageService();
            langService.SetSite(this);
            serviceContainer.AddService(typeof(XSharpLanguageService),
                                        langService,
                                        true);

            // Register a timer to call our language service during
            // idle periods.
            IOleComponentManager mgr = GetService(typeof(SOleComponentManager))
                                       as IOleComponentManager;
            if (m_componentID == 0 && mgr != null)
            {
                OLECRINFO[] crinfo = new OLECRINFO[1];
                crinfo[0].cbSize = (uint)Marshal.SizeOf(typeof(OLECRINFO));
                crinfo[0].grfcrf = (uint)_OLECRF.olecrfNeedIdleTime |
                                              (uint)_OLECRF.olecrfNeedPeriodicIdleTime;
                crinfo[0].grfcadvf = (uint)_OLECADVF.olecadvfModal |
                                              (uint)_OLECADVF.olecadvfRedrawOff |
                                              (uint)_OLECADVF.olecadvfWarningsOff;
                crinfo[0].uIdleTimeInterval = 1000;
                int hr = mgr.FRegisterComponent(this, crinfo, out m_componentID);
            }

         }

        /// <summary>
        /// Gets the settings stored in the registry for this package.
        /// </summary>
        /// <value>The settings stored in the registry for this package.</value>
        public XPackageSettings Settings
        {
            get { return this.settings; }
        }
        public override string ProductUserContext
        {
            get { return "XSharp"; }
        }
        private void MenuItemCallback(object sender, EventArgs e)
        {
            // Show a Message Box to prove we were here
            IVsUIShell uiShell = (IVsUIShell)GetService(typeof(SVsUIShell));
            Guid clsid = Guid.Empty;
            int result;
            Microsoft.VisualStudio.ErrorHandler.ThrowOnFailure(uiShell.ShowMessageBox(
                       0,
                       ref clsid,
                       "XSharp Language Service",
                       string.Format(CultureInfo.CurrentCulture, "Inside {0}.MenuItemCallback()", this.ToString()),
                       string.Empty,
                       0,
                       OLEMSGBUTTON.OLEMSGBUTTON_OK,
                       OLEMSGDEFBUTTON.OLEMSGDEFBUTTON_FIRST,
                       OLEMSGICON.OLEMSGICON_INFO,
                       0,        // false
                       out result));
        }

#endregion

#region IOleComponent Members

        public int FDoIdle(uint grfidlef)
        {
            bool bPeriodic = (grfidlef & (uint)_OLEIDLEF.oleidlefPeriodic) != 0;
            // Use typeof(TestLanguageService) because we need to
            // reference the GUID for our language service.
            Microsoft.VisualStudio.Package.LanguageService service = GetService(typeof(XSharpLanguageService))
                                      as Microsoft.VisualStudio.Package.LanguageService;
            if (service != null)
            {
                service.OnIdle(bPeriodic);
            }
            return 0;
        }

        public int FContinueMessageLoop(uint uReason,
                                        IntPtr pvLoopData,
                                        MSG[] pMsgPeeked)
        {
            return 1;
        }

        public int FPreTranslateMessage(MSG[] pMsg)
        {
            return 0;
        }

        public int FQueryTerminate(int fPromptUser)
        {
            return 1;
        }

        public int FReserved1(uint dwReserved,
                              uint message,
                              IntPtr wParam,
                              IntPtr lParam)
        {
            return 1;
        }

        public IntPtr HwndGetWindow(uint dwWhich, uint dwReserved)
        {
            return IntPtr.Zero;
        }

        public void OnActivationChange(IOleComponent pic,
                                       int fSameComponent,
                                       OLECRINFO[] pcrinfo,
                                       int fHostIsActivating,
                                       OLECHOSTINFO[] pchostinfo,
                                       uint dwReserved)
        {
        }

        public void OnAppActivate(int fActive, uint dwOtherThreadID)
        {
        }

        public void OnEnterState(uint uStateID, int fEnter)
        {
        }

        public void OnLoseActivation()
        {
        }

        public void Terminate()
        {
        }

#endregion

    }

}
