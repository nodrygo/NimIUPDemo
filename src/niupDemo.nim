import lib/niup, lib/niupcd, lib/niupcdcairo
import dialogs.dlg1 as dlg1

var currentFile = ""
var currentFileModified = false

# some part stollen from Rosetta demo

 
discard iupopen(nil,nil)
 
var btnRestore = iupbutton("restore","")
var btnFull = iupbutton("Full screen","")
var btnMin = iupbutton("minimize","")
var btnMax = iupbutton("maximize","")
var btnShow = iupbutton("Show non modal Dialog","")
var btnFile = iupbutton("Open File Dialog","")
var btnQuit = iupbutton("Quit","")
 
var hbox = iuphbox(btnRestore, btnFull, btnMax, btnMin, btnShow,btnFile, btnQuit, nil)
iupSetAttribute(hbox,"MARGIN", "1x1")
iupSetAttribute(hbox,"PADDING", "1x1")

var toolbox = iupframe(hbox) 
var hexpand = iupExpander(toolbox)
iupSetAttribute(hexpand,"TITLE", "TOOLBOX")
#    CANVAS
# set an iup canvas (because cairo canvas hard fail :-( ) 
let  CD_CAIRO_NATIVEWINDOW = cdContextCairoNativeWindow()
let canvas = iupCanvas(nil)
iupSetAttribute(canvas, "SIZE", "100x100")
iupSetAttribute(canvas, "EXPAND", "YES")
discard iupSetAttributes(canvas, "CURSOR=CROSS, SCROLLBAR=YES, DX=0.5, DY=0.5")

# get context draw on canvas
#let CD_IUP* = cdContextIup()

let cdcanvas = cdCreateCanvas(CD_IUP,  canvas)

echo "Create CD CANVAS RETURN =",cast[int](cdcanvas)
#let cdcanvas = cdCreateCanvas( CD_CAIRO_NATIVEWINDOW,  canvas)
cdCanvasSetAttribute(cdcanvas, "ANTIALIAS", "0")

var txtval = """
ceci est
une demo 
multiline text 
idans un splitter
"""
var txt =  iupMultiLine("")
iupSetAttribute(txt, "SIZE", "50x100");
iupSetAttribute(txt, "EXPAND", "YES");
iupSetAttribute(txt, "VISIBLELINES", "5");
iupSetAttribute(txt, "VISIBLECOLUMNS", "5");
iupSetAttribute(txt, "VALUE", txtval);
var split = iupSplit(txt,canvas)

var topvbox = iupvbox(hexpand,split,nil)

# MENU PARTS
# menu File
var itemfopen =  iupitem("Open","FILEOPEN")
iupSetAttribute(itemfopen, "KEY", "O")
var itemfclose = iupitem("Close","FILECLOSE")
iupSetAttribute(itemfopen, "KEY", "O")
var itemquit = iupitem("QUIT",nil)
iupSetAttribute(itemfopen, "KEY", "O")
var menufile = iupmenu(itemfopen,itemfclose,iupseparator(),itemquit,nil)
var submenufile = iupsubmenu("File",menufile)
# menu Edit
var itemcopy = iupitem("Copy",nil)
iupSetAttribute(itemfopen, "KEY", "C")
var itempaste = iupitem("Paste",nil)
iupSetAttribute(itemfopen, "KEY", "V")
var itemcut = iupitem("Cut",nil)
iupSetAttribute(itemfopen, "KEY", "X")
var menuedit = iupmenu(itemcopy,itempaste,itemcut,nil)
var submenuedit = iupsubmenu("Edit",menuedit)
# main menu
var mainmenu = iupmenu(submenufile,submenuedit,nil)
## associate a menu_name to an handle
var hmenu =  iupsetHandle("mainmenu",mainmenu)

# MAIN DIALOG 
var mainDlg = iupdialog(topvbox)
iupSetAttribute(mainDlg,"TITLE", "myDemoApp")
iupSetAttribute(mainDlg,"MINSIZE", "600x500")
# use the named menu 
iupSetAttribute(mainDlg,"MENU", "mainmenu")
 

# CALLBACKS 
proc doRedrawCanvas(ih:PIhandle): cint {.cdecl.} =
    # echo "Enter Canvas redraw"
    # let ctx = cdCanvasGetContext(cdcanvas)
    discard cdCanvasActivate(cdcanvas)
    cdCanvasClear(cdcanvas)
    discard cdCanvasForeground(cdcanvas, CD_BLUE)
    cdCanvasBox(cdcanvas, 10, 100, 10, 100)
    discard cdCanvasForeground(cdcanvas, CD_RED)
    cdCanvasRect(cdcanvas, 10, 100, 10, 100)
    cdCanvasLine(cdcanvas, 10,10,10,100);
    cdCanvasLine(cdcanvas, 100,10,100,100);
    cdCanvasLine(cdcanvas, 10,10,100,10);
    cdCanvasLine(cdcanvas, 10,100,100,100);
    cdCanvasFlush(cdcanvas)
    return IUP_DEFAULT

proc doFull(ih:PIhandle): cint {.cdecl.} =
    iupSetAttribute(mainDlg,"FULLSCREEN","YES")
    return IUP_DEFAULT
 
proc doMax(ih:PIhandle): cint {.cdecl.} =
    #iupSetAttribute(mainDlg,"FULLSCREEN","YES")
    iupSetAttribute(mainDlg,"PLACEMENT","MAXIMIZED")
    # this is a work-around to get the dialog minimised (on win platform)
    iupSetAttribute(mainDlg,"VISIBLE","YES")
    return IUP_DEFAULT
 
proc doMin(ih:PIhandle): cint {.cdecl.} =
    iupSetAttribute(mainDlg,"PLACEMENT","MINIMIZED")
    # this is a work-around to get the dialog minimised (on win platform)
    iupSetAttribute(mainDlg,"VISIBLE","YES")
    return IUP_DEFAULT
 
proc doRestore(ih:PIhandle): cint {.cdecl.} =
    iupSetAttribute(mainDlg,"OPACITY","255")
    iupSetAttribute(mainDlg,"FULLSCREEN","NO")
    iupSetAttribute(mainDlg,"PLACEMENT","NORMAL")
    iupSetAttribute(mainDlg,"VISIBLE","YES")
    return IUP_DEFAULT
 
 
proc doShow(ih:PIhandle): cint {.cdecl.} =
    discard  dlg1.mkDlg(ih)
    return IUP_DEFAULT

proc doFile(ih:PIhandle): cint {.cdecl.} =
    let fh =  iupFileDlg()
    iupSetAttribute(fh,"TITLE","Select File")
    iupSetAttribute(fh,"FILTER","*.nim")
    let r  =  iupPopup(fh, IUP_CENTER, IUP_CENTER)
    echo "return of mainDlg file" , r
    let status = iupgetInt(fh, "STATUS")
    currentfile = if status != -1 : 
                  $iupgetAttribute(fh, "VALUE")
               else:
                  "newfile"
    discard iupalarm("MyTitle",currentfile ,"Ok", nil, nil)
    fh.iupdestroy()
    return IUP_DEFAULT
 
proc doQuit(ih:PIhandle): cint {.cdecl.} =
    let r =  iupalarm("MyAPP","Really quit","Ok", "Not Ok", nil)
    if r == 1: iupclose()
    return IUP_DEFAULT

proc doShowAction(ih:PIhandle): cint {.cdecl} =
    discard  iupalarm("MyAPP","Action","Ok", nil, nil)
    return IUP_DEFAULT

discard iupSetCallback(btnRestore,"ACTION", toCB(doRestore))
discard iupSetCallback(btnFull,"ACTION", toCB(doFull))
discard iupSetCallback(btnMax,"ACTION", toCB(doMax))
discard iupSetCallback(btnMin,"ACTION", toCB(doMin))
discard iupSetCallback(btnShow,"ACTION", toCB(doShow))
discard iupSetCallback(btnFile,"ACTION", toCB(doFile))
discard iupSetCallback(btnQuit,"ACTION", toCB(doQuit))
discard iupSetCallback(itemquit,"ACTION", toCB(doQuit))
discard iupSetCallback(itemfopen,"ACTION", toCB(doShowAction))

# discard iupSetCallback(mainDlg, "MOVE_CB",toCB(doRedrawCanvas))
# discard iupSetCallback(mainDlg, "RESIZE_CB",toCB(doRedrawCanvas))
# discard iupSetCallback(canvas, "ACTION",toCB(doRedrawCanvas))
discard iupSetCallback(canvas, "RESIZE_CB",toCB(doRedrawCanvas))
discard iupSetCallback(canvas, "BUTTON_CB",toCB(doRedrawCanvas))
discard doRedrawCanvas(cdcanvas)
  
discard mainDlg.iupShow()
discard iupMainloop()
iupclose()

