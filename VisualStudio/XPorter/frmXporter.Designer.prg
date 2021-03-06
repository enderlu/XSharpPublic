﻿PUBLIC PARTIAL CLASS frmXporter ;
    INHERIT System.Windows.Forms.Form
    
    PROTECTED oToolTip1 AS System.Windows.Forms.ToolTip
    PROTECTED olblTitle AS System.Windows.Forms.Label
    PROTECTED oFileButton AS System.Windows.Forms.Button
    PROTECTED oDescription AS System.Windows.Forms.TextBox
    PROTECTED otbFileName AS System.Windows.Forms.TextBox
    PROTECTED olblFileName AS System.Windows.Forms.Label
    PROTECTED ogrpExport AS System.Windows.Forms.GroupBox
    PROTECTED orbProject AS System.Windows.Forms.RadioButton
    PROTECTED orbSolution AS System.Windows.Forms.RadioButton
    PROTECTED oOKButton AS System.Windows.Forms.Button
    PRIVATE components AS System.ComponentModel.IContainer
    PROTECTED oCancelButton AS System.Windows.Forms.Button
    //        User code starts here (DO NOT remove this line)  ##USER##
    PUBLIC VIRTUAL METHOD InitializeComponent() AS VOID
        SELF:components := System.ComponentModel.Container{}
        SELF:oToolTip1 := System.Windows.Forms.ToolTip{SELF:components}
        SELF:oFileButton := System.Windows.Forms.Button{}
        SELF:otbFileName := System.Windows.Forms.TextBox{}
        SELF:orbProject := System.Windows.Forms.RadioButton{}
        SELF:orbSolution := System.Windows.Forms.RadioButton{}
        SELF:oOKButton := System.Windows.Forms.Button{}
        SELF:oCancelButton := System.Windows.Forms.Button{}
        SELF:olblTitle := System.Windows.Forms.Label{}
        SELF:oDescription := System.Windows.Forms.TextBox{}
        SELF:olblFileName := System.Windows.Forms.Label{}
        SELF:ogrpExport := System.Windows.Forms.GroupBox{}
        SELF:ogrpExport:SuspendLayout()
        SELF:SuspendLayout()
        // 
        // oFileButton
        // 
        SELF:oFileButton:Location := System.Drawing.Point{432, 144}
        SELF:oFileButton:Name := "oFileButton"
        SELF:oFileButton:Size := System.Drawing.Size{24, 22}
        SELF:oFileButton:TabIndex := 6
        SELF:oFileButton:Text := "..."
        SELF:oToolTip1:SetToolTip(SELF:oFileButton, "Click here to choose the source file with a standard Windows File Dialog")
        SELF:oFileButton:Click += System.EventHandler{ SELF, @FileButtonClick() }
        // 
        // otbFileName
        // 
        SELF:otbFileName:Location := System.Drawing.Point{80, 144}
        SELF:otbFileName:Name := "otbFileName"
        SELF:otbFileName:Size := System.Drawing.Size{344, 20}
        SELF:otbFileName:TabIndex := 4
        SELF:oToolTip1:SetToolTip(SELF:otbFileName, "Enter the source file name")
        SELF:otbFileName:TextChanged += System.EventHandler{ SELF, @tbFileNameTextChanged() }
        // 
        // orbProject
        // 
        SELF:orbProject:Location := System.Drawing.Point{16, 56}
        SELF:orbProject:Name := "orbProject"
        SELF:orbProject:Size := System.Drawing.Size{320, 24}
        SELF:orbProject:TabIndex := 1
        SELF:orbProject:Text := "Single Vulcan.NET project"
        SELF:oToolTip1:SetToolTip(SELF:orbProject, "Click this button to convert a single Vulcan.NET project")
        SELF:orbProject:CheckedChanged += System.EventHandler{ SELF, @rbClick() }
        // 
        // orbSolution
        // 
        SELF:orbSolution:Checked := true
        SELF:orbSolution:Location := System.Drawing.Point{16, 24}
        SELF:orbSolution:Name := "orbSolution"
        SELF:orbSolution:Size := System.Drawing.Size{320, 24}
        SELF:orbSolution:TabIndex := 0
        SELF:orbSolution:TabStop := true
        SELF:orbSolution:Text := "Visual Studio Solution with Vulcan.NET projects"
        SELF:oToolTip1:SetToolTip(SELF:orbSolution, "Click this button to convert a Visual Studio Solution")
        SELF:orbSolution:Click += System.EventHandler{ SELF, @rbClick() }
        // 
        // oOKButton
        // 
        SELF:oOKButton:Location := System.Drawing.Point{360, 224}
        SELF:oOKButton:Name := "oOKButton"
        SELF:oOKButton:Size := System.Drawing.Size{96, 24}
        SELF:oOKButton:TabIndex := 1
        SELF:oOKButton:Text := "E&xport"
        SELF:oToolTip1:SetToolTip(SELF:oOKButton, "Click to start the conversion process")
        SELF:oOKButton:Click += System.EventHandler{ SELF, @OKButtonClick() }
        // 
        // oCancelButton
        // 
        SELF:oCancelButton:DialogResult := System.Windows.Forms.DialogResult.Cancel
        SELF:oCancelButton:Location := System.Drawing.Point{360, 264}
        SELF:oCancelButton:Name := "oCancelButton"
        SELF:oCancelButton:Size := System.Drawing.Size{96, 24}
        SELF:oCancelButton:TabIndex := 0
        SELF:oCancelButton:Text := "&Close"
        SELF:oToolTip1:SetToolTip(SELF:oCancelButton, "Click to close the window")
        SELF:oCancelButton:Click += System.EventHandler{ SELF, @CancelButtonClick() }
        // 
        // olblTitle
        // 
        SELF:olblTitle:Location := System.Drawing.Point{8, 8}
        SELF:olblTitle:Name := "olblTitle"
        SELF:olblTitle:Size := System.Drawing.Size{448, 23}
        SELF:olblTitle:TabIndex := 7
        SELF:olblTitle:Text := "This program helps you to convert your Vulcan.NET projects and solutions to X#"
        // 
        // oDescription
        // 
        SELF:oDescription:BackColor := System.Drawing.SystemColors.InactiveCaption
        SELF:oDescription:BorderStyle := System.Windows.Forms.BorderStyle.None
        SELF:oDescription:Location := System.Drawing.Point{8, 184}
        SELF:oDescription:Multiline := true
        SELF:oDescription:Name := "oDescription"
        SELF:oDescription:ReadOnly := true
        SELF:oDescription:Size := System.Drawing.Size{344, 104}
        SELF:oDescription:TabIndex := 5
        // 
        // olblFileName
        // 
        SELF:olblFileName:Location := System.Drawing.Point{8, 144}
        SELF:olblFileName:Name := "olblFileName"
        SELF:olblFileName:Size := System.Drawing.Size{64, 23}
        SELF:olblFileName:TabIndex := 3
        SELF:olblFileName:Text := "File Name:"
        // 
        // ogrpExport
        // 
        SELF:ogrpExport:BackColor := System.Drawing.SystemColors.InactiveCaption
        SELF:ogrpExport:Controls:Add(SELF:orbProject)
        SELF:ogrpExport:Controls:Add(SELF:orbSolution)
        SELF:ogrpExport:Location := System.Drawing.Point{8, 32}
        SELF:ogrpExport:Name := "ogrpExport"
        SELF:ogrpExport:Size := System.Drawing.Size{448, 96}
        SELF:ogrpExport:TabIndex := 2
        SELF:ogrpExport:TabStop := false
        SELF:ogrpExport:Text := "What to convert"
        // 
        // frmXporter
        // 
        SELF:AcceptButton := SELF:oOKButton
        SELF:BackColor := System.Drawing.SystemColors.InactiveCaption
        SELF:BackgroundImageLayout := System.Windows.Forms.ImageLayout.Stretch
        SELF:CancelButton := SELF:oCancelButton
        SELF:ClientSize := System.Drawing.Size{464, 296}
        SELF:Controls:Add(SELF:olblTitle)
        SELF:Controls:Add(SELF:oFileButton)
        SELF:Controls:Add(SELF:oDescription)
        SELF:Controls:Add(SELF:otbFileName)
        SELF:Controls:Add(SELF:olblFileName)
        SELF:Controls:Add(SELF:ogrpExport)
        SELF:Controls:Add(SELF:oOKButton)
        SELF:Controls:Add(SELF:oCancelButton)
        SELF:Location := System.Drawing.Point{100, 100}
        SELF:MaximizeBox := false
        SELF:MinimizeBox := false
        SELF:Name := "frmXporter"
        SELF:StartPosition := System.Windows.Forms.FormStartPosition.CenterScreen
        SELF:Text := "XSharp XPorter"
        SELF:Shown += System.EventHandler{ SELF, @BasicFormShown() }
        SELF:ogrpExport:ResumeLayout(false)
        SELF:ResumeLayout(false)
        SELF:PerformLayout()

END CLASS
