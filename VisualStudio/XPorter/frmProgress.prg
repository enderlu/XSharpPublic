//  Application : XPorter
//  dlgProgress.prg , Created : 28-9-2016   15:10
//  User : robert
PUBLIC PARTIAL CLASS frmProgress ;
    INHERIT System.Windows.Forms.Form ;
    IMPLEMENTS IProgress
    
    PUBLIC CONSTRUCTOR()
        SUPER()

    SELF:InitializeComponent()

RETURN

    PUBLIC VIRTUAL METHOD WriteLine(cText AS STRING) AS VOID
        SELF:oTbMessage:Text += cText + e"\r\n"   
    SELF:otbMessage:SelectionStart := SELF:otbMessage:Text:Length   
    SELF:otbMessage:ScrollToCaret()

    PUBLIC VIRTUAL METHOD Stop() AS VOID
        SELF:obtnClose:Enabled := TRUE
    PUBLIC VIRTUAL METHOD Start() AS VOID
        SELF:obtnClose:Enabled := FALSE

    PUBLIC VIRTUAL METHOD btnCloseClick(sender AS OBJECT, e AS System.EventArgs) AS VOID
        SELF:Close()
RETURN


END CLASS
