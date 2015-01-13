import ../lib/niup, ../lib/niupscintilla 

iupScintillaOpen()
var currentFile = ""
var code = """
import ../lib/niup, ../lib/niupscintilla

proc doDlgQuit(handle:PIhandle): cint {.cdecl.} = 
    discard handle.iupGetParent.iupGetParent.iupHide()
    handle.iupGetParent.iupGetParent.iupDestroy()
    return IUP_DEFAULT
  """
var hscite:PIhandle = nil

proc doDlgQuit(handle:PIhandle): cint {.cdecl.} = 
    discard handle.iupGetParent.iupGetParent.iupGetParent.iupHide()
    handle.iupGetParent.iupGetParent.iupGetParent.iupDestroy()
    return IUP_DEFAULT

proc doOpenFile(handle:PIhandle): cint {.cdecl.} =
    let handle =  iupFileDlg()
    iupSetAttribute(handle,"TITLE","Select File")
    iupSetAttribute(handle,"FILTER","*.nim")
    let r  =  iupPopup(handle, IUP_CENTER, IUP_CENTER)
    echo "return of mainDlg file" , r
    let status = iupgetInt(handle, "STATUS")
    if status != -1 : 
        currentfile = $iupgetAttribute(handle, "VALUE")
        code =  readFile(currentfile)

    iupSetAttribute(hscite,"VALUE", code)
    handle.iupdestroy()
    return IUP_DEFAULT    
    
proc mkDlg*(hParent:PIhandle): PIhandle =
  iupScintillaOpen()

  var btnOpenFile = iupbutton("OpenFile","")
  var btnQuit     = iupbutton("Quit","")
  var lblText     = iupLabel("DEMO SCINTILLA")
  iupSetAttribute(lblText,"ALIGNMENT", "ALEFT")
    
  hscite = iupScintilla()
  iupSetAttribute(hscite,"VALUE", code)
  iupSetAttribute(hscite, "LEXERLANGUAGE", "nimrod")
  iupSetAttribute(hscite, "KEYWORDS0", "import")
  iupSetAttribute(hscite, "KEYWORDS1", "proc discard return")
  #iupSetAttribute(hscite, "STYLEFONT32", "Courier New")
  iupSetAttribute(hscite, "STYLEFONT32", "Consolas")
  iupSetAttribute(hscite, "STYLEFONTSIZE32", "11")
  iupSetAttribute(hscite, "STYLECLEARALL", "Yes") 
  iupSetAttribute(hscite, "STYLEFGCOLOR1", "0 128 0")
  iupSetAttribute(hscite, "STYLEFGCOLOR2", "0 128 0") 
  iupSetAttribute(hscite, "STYLEFGCOLOR4", "128 0 0")
  iupSetAttribute(hscite, "STYLEFGCOLOR5", "0 0 255")
  iupSetAttribute(hscite, "STYLEFGCOLOR6", "160 20 20")
  iupSetAttribute(hscite, "STYLEFGCOLOR7", "128 0 0")
  iupSetAttribute(hscite, "STYLEFGCOLOR9", "0 0 255")
  iupSetAttribute(hscite, "STYLEFGCOLOR10", "255 0 255")
  iupSetAttribute(hscite, "STYLEBOLD10", "YES");
  iupSetAttribute(hscite, "STYLEHOTSPOT6", "YES") 
  iupSetAttribute(hscite, "MARGINWIDTH0", "50")
  iupSetAttribute(hscite, "PROPERTY", "fold=1")
  iupSetAttribute(hscite, "PROPERTY", "fold.compact=0")
  iupSetAttribute(hscite, "PROPERTY", "fold.comment=1")
  iupSetAttribute(hscite, "PROPERTY", "fold.preprocessor=1")
  iupSetAttribute(hscite, "MARGINWIDTH1", "20")
  iupSetAttribute(hscite, "MARGINTYPE1",  "SYMBOL")
  iupSetAttribute(hscite, "MARGINMASKFOLDERS1",  "Yes")
  iupSetAttribute(hscite, "MARKERDEFINE", "FOLDER=PLUS");
  iupSetAttribute(hscite, "MARKERDEFINE", "FOLDEROPEN=MINUS")
  iupSetAttribute(hscite, "MARKERDEFINE", "FOLDEREND=EMPTY")
  iupSetAttribute(hscite, "MARKERDEFINE", "FOLDERMIDTAIL=EMPTY")
  iupSetAttribute(hscite, "MARKERDEFINE", "FOLDEROPENMID=EMPTY")
  iupSetAttribute(hscite, "MARKERDEFINE", "FOLDERSUB=EMPTY")
  iupSetAttribute(hscite, "MARKERDEFINE", "FOLDERTAIL=EMPTY")
  iupSetAttribute(hscite, "FOLDFLAGS", "LINEAFTER_CONTRACTED")
  iupSetAttribute(hscite, "MARGINSENSITIVE1", "YES")
  iupSetAttribute(hscite, "TABSIZE", "2")
  iupSetAttribute(hscite, "INDENTATIONGUIDES", "YES")
  iupSetAttribute(hscite, "USETABS", "NO")
   
  var vbox = iupVbox(btnOpenFile ,btnQuit, nil)  
  var hbox = iupHbox(lblText, hscite ,vbox, nil)
  
  var hdlg = iupdialog(hbox)
  iupSetAttribute(hdlg,"TITLE", "myDemoApp")
  #iupSetAttribute(hdlg,"MINSIZE", "600x400")
  discard iupSetCallback(btnOpenFile,"ACTION", toCB(doOpenFile))
  discard iupSetCallback(btnQuit,"ACTION", toCB(doDlgQuit))
  discard hdlg.iupShow()
  result = hdlg
