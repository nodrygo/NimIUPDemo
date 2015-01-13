#  \brief User API
#  IUP - A Portable User Interface Toolkit
#  Tecgraf: Computer Graphics Technology Group, PUC-Rio, Brazil
#  http://www.tecgraf.puc-rio.br/iup  mailto:iup@tecgraf.puc-rio.br
# 
#*****************************************************************************
# Copyright (C) 1994-2014 Tecgraf, PUC-Rio.
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
# 
when defined(windows):
  const iuplib* = "iup.dll"
elif defined(macosx):
  const iuplib* = "libiup.dylib"
else:
  const iuplib* = "libiup.so" 

const 
  IUP_NAME* = "IUP - Portable User Interface"
  IUP_COPYRIGHT* = "Copyright (C) 1994-2014 Tecgraf, PUC-Rio."
  IUP_DESCRIPTION* = "Multi-platform toolkit for building graphical user interfaces."
  IUP_VERSION* = "3.12"
  IUP_VERSION_NUMBER* = 312000
  IUP_VERSION_DATE* = "2014/11/19"
type 
  Ihandle* = cint
  PIhandle* = ptr Ihandle
  Icallback* = proc (a2: ptr Ihandle): cint {.cdecl.}
  
# Callback   
proc toCB*(fp: proc): ICallback =
 return cast[ICallback](fp)
     
#**********************************************************************
#                        Main API                                      
#**********************************************************************
proc iupOpen*(argc: ptr cint; argv: ptr cstringArray): cint {.cdecl, 
    importc: "IupOpen", dynlib: iuplib.}
proc iupClose*() {.cdecl, importc: "IupClose", dynlib: iuplib.}
#~ proc iupImageLibOpen*() {.cdecl, importc: "IupImageLibOpen", dynlib: iuplib.}
proc iupMainLoop*(): cint {.cdecl, importc: "IupMainLoop", dynlib: iuplib.}
proc iupLoopStep*(): cint {.cdecl, importc: "IupLoopStep", dynlib: iuplib.}
proc iupLoopStepWait*(): cint {.cdecl, importc: "IupLoopStepWait", 
                                dynlib: iuplib.}
proc iupMainLoopLevel*(): cint {.cdecl, importc: "IupMainLoopLevel", 
                                 dynlib: iuplib.}
proc iupFlush*() {.cdecl, importc: "IupFlush", dynlib: iuplib.}
proc iupExitLoop*() {.cdecl, importc: "IupExitLoop", dynlib: iuplib.}
proc iupRecordInput*(filename: cstring; mode: cint): cint {.cdecl, 
    importc: "IupRecordInput", dynlib: iuplib.}
proc iupPlayInput*(filename: cstring): cint {.cdecl, importc: "IupPlayInput", 
    dynlib: iuplib.}
proc iupUpdate*(ih: ptr Ihandle) {.cdecl, importc: "IupUpdate", dynlib: iuplib.}
proc iupUpdateChildren*(ih: ptr Ihandle) {.cdecl, 
    importc: "IupUpdateChildren", dynlib: iuplib.}
proc iupRedraw*(ih: ptr Ihandle; children: cint) {.cdecl, 
    importc: "IupRedraw", dynlib: iuplib.}
proc iupRefresh*(ih: ptr Ihandle) {.cdecl, importc: "IupRefresh", 
                                    dynlib: iuplib.}
proc iupRefreshChildren*(ih: ptr Ihandle) {.cdecl, 
    importc: "IupRefreshChildren", dynlib: iuplib.}
proc iupHelp*(url: cstring): cint {.cdecl, importc: "IupHelp", dynlib: iuplib.}
proc iupLoad*(filename: cstring): cstring {.cdecl, importc: "IupLoad", 
    dynlib: iuplib.}
proc iupLoadBuffer*(buffer: cstring): cstring {.cdecl, 
    importc: "IupLoadBuffer", dynlib: iuplib.}
proc iupVersion*(): cstring {.cdecl, importc: "IupVersion", dynlib: iuplib.}
proc iupVersionDate*(): cstring {.cdecl, importc: "IupVersionDate", 
                                  dynlib: iuplib.}
proc iupVersionNumber*(): cint {.cdecl, importc: "IupVersionNumber", 
                                 dynlib: iuplib.}
proc iupSetLanguage*(lng: cstring) {.cdecl, importc: "IupSetLanguage", 
                                     dynlib: iuplib.}
proc iupGetLanguage*(): cstring {.cdecl, importc: "IupGetLanguage", 
                                  dynlib: iuplib.}
proc iupSetLanguageString*(name: cstring; str: cstring) {.cdecl, 
    importc: "IupSetLanguageString", dynlib: iuplib.}
proc iupStoreLanguageString*(name: cstring; str: cstring) {.cdecl, 
    importc: "IupStoreLanguageString", dynlib: iuplib.}
proc iupGetLanguageString*(name: cstring): cstring {.cdecl, 
    importc: "IupGetLanguageString", dynlib: iuplib.}
proc iupSetLanguagePack*(ih: ptr Ihandle) {.cdecl, 
    importc: "IupSetLanguagePack", dynlib: iuplib.}
proc iupDestroy*(ih: ptr Ihandle) {.cdecl, importc: "IupDestroy", 
                                    dynlib: iuplib.}
proc iupDetach*(child: ptr Ihandle) {.cdecl, importc: "IupDetach", 
                                      dynlib: iuplib.}
proc iupAppend*(ih: ptr Ihandle; child: ptr Ihandle): ptr Ihandle {.cdecl, 
    importc: "IupAppend", dynlib: iuplib.}
proc iupInsert*(ih: ptr Ihandle; refChild: ptr Ihandle; child: ptr Ihandle): ptr Ihandle {.
    cdecl, importc: "IupInsert", dynlib: iuplib.}
proc iupGetChild*(ih: ptr Ihandle; pos: cint): ptr Ihandle {.cdecl, 
    importc: "IupGetChild", dynlib: iuplib.}
proc iupGetChildPos*(ih: ptr Ihandle; child: ptr Ihandle): cint {.cdecl, 
    importc: "IupGetChildPos", dynlib: iuplib.}
proc iupGetChildCount*(ih: ptr Ihandle): cint {.cdecl, 
    importc: "IupGetChildCount", dynlib: iuplib.}
proc iupGetNextChild*(ih: ptr Ihandle; child: ptr Ihandle): ptr Ihandle {.
    cdecl, importc: "IupGetNextChild", dynlib: iuplib.}
proc iupGetBrother*(ih: ptr Ihandle): ptr Ihandle {.cdecl, 
    importc: "IupGetBrother", dynlib: iuplib.}
proc iupGetParent*(ih: ptr Ihandle): ptr Ihandle {.cdecl, 
    importc: "IupGetParent", dynlib: iuplib.}
proc iupGetDialog*(ih: ptr Ihandle): ptr Ihandle {.cdecl, 
    importc: "IupGetDialog", dynlib: iuplib.}
proc iupGetDialogChild*(ih: ptr Ihandle; name: cstring): ptr Ihandle {.cdecl, 
    importc: "IupGetDialogChild", dynlib: iuplib.}
proc iupReparent*(ih: ptr Ihandle; newParent: ptr Ihandle; 
                  refChild: ptr Ihandle): cint {.cdecl, 
    importc: "IupReparent", dynlib: iuplib.}
proc iupPopup*(ih: ptr Ihandle; x: cint; y: cint): cint {.cdecl, 
    importc: "IupPopup", dynlib: iuplib.}
proc iupShow*(ih: ptr Ihandle): cint {.cdecl, importc: "IupShow", 
    dynlib: iuplib.}
proc iupShowXY*(ih: ptr Ihandle; x: cint; y: cint): cint {.cdecl, 
    importc: "IupShowXY", dynlib: iuplib.}
proc iupHide*(ih: ptr Ihandle): cint {.cdecl, importc: "IupHide", 
    dynlib: iuplib.}
proc iupMap*(ih: ptr Ihandle): cint {.cdecl, importc: "IupMap", dynlib: iuplib.}
proc iupUnmap*(ih: ptr Ihandle) {.cdecl, importc: "IupUnmap", dynlib: iuplib.}
proc iupResetAttribute*(ih: ptr Ihandle; name: cstring) {.cdecl, 
    importc: "IupResetAttribute", dynlib: iuplib.}
proc iupGetAllAttributes*(ih: ptr Ihandle; names: cstringArray; n: cint): cint {.
    cdecl, importc: "IupGetAllAttributes", dynlib: iuplib.}
proc iupSetAtt*(handleName: cstring; ih: ptr Ihandle; name: cstring): ptr Ihandle {.
    varargs, cdecl, importc: "IupSetAtt", dynlib: iuplib.}
proc iupSetAttributes*(ih: ptr Ihandle; str: cstring): ptr Ihandle {.cdecl, 
    importc: "IupSetAttributes", dynlib: iuplib.}
proc iupGetAttributes*(ih: ptr Ihandle): cstring {.cdecl, 
    importc: "IupGetAttributes", dynlib: iuplib.}
proc iupSetAttribute*(ih: ptr Ihandle; name: cstring; value: cstring) {.cdecl, 
    importc: "IupSetAttribute", dynlib: iuplib.}
proc iupSetStrAttribute*(ih: ptr Ihandle; name: cstring; value: cstring) {.
    cdecl, importc: "IupSetStrAttribute", dynlib: iuplib.}
proc iupSetStrf*(ih: ptr Ihandle; name: cstring; format: cstring) {.varargs, 
    cdecl, importc: "IupSetStrf", dynlib: iuplib.}
proc iupSetInt*(ih: ptr Ihandle; name: cstring; value: cint) {.cdecl, 
    importc: "IupSetInt", dynlib: iuplib.}
proc iupSetFloat*(ih: ptr Ihandle; name: cstring; value: cfloat) {.cdecl, 
    importc: "IupSetFloat", dynlib: iuplib.}
proc iupSetDouble*(ih: ptr Ihandle; name: cstring; value: cdouble) {.cdecl, 
    importc: "IupSetDouble", dynlib: iuplib.}
proc iupSetRGB*(ih: ptr Ihandle; name: cstring; r: cuchar; g: cuchar; 
                b: cuchar) {.cdecl, importc: "IupSetRGB", dynlib: iuplib.}
proc iupGetAttribute*(ih: ptr Ihandle; name: cstring): cstring {.cdecl, 
    importc: "IupGetAttribute", dynlib: iuplib.}
proc iupGetInt*(ih: ptr Ihandle; name: cstring): cint {.cdecl, 
    importc: "IupGetInt", dynlib: iuplib.}
proc iupGetInt2*(ih: ptr Ihandle; name: cstring): cint {.cdecl, 
    importc: "IupGetInt2", dynlib: iuplib.}
proc iupGetIntInt*(ih: ptr Ihandle; name: cstring; i1: ptr cint; i2: ptr cint): cint {.
    cdecl, importc: "IupGetIntInt", dynlib: iuplib.}
proc iupGetFloat*(ih: ptr Ihandle; name: cstring): cfloat {.cdecl, 
    importc: "IupGetFloat", dynlib: iuplib.}
proc iupGetDouble*(ih: ptr Ihandle; name: cstring): cdouble {.cdecl, 
    importc: "IupGetDouble", dynlib: iuplib.}
proc iupGetRGB*(ih: ptr Ihandle; name: cstring; r: ptr cuchar; g: ptr cuchar; 
                b: ptr cuchar) {.cdecl, importc: "IupGetRGB", dynlib: iuplib.}
proc iupSetAttributeId*(ih: ptr Ihandle; name: cstring; id: cint; 
                        value: cstring) {.cdecl, importc: "IupSetAttributeId", 
    dynlib: iuplib.}
proc iupSetStrAttributeId*(ih: ptr Ihandle; name: cstring; id: cint; 
                           value: cstring) {.cdecl, 
    importc: "IupSetStrAttributeId", dynlib: iuplib.}
proc iupSetStrfId*(ih: ptr Ihandle; name: cstring; id: cint; format: cstring) {.
    varargs, cdecl, importc: "IupSetStrfId", dynlib: iuplib.}
proc iupSetIntId*(ih: ptr Ihandle; name: cstring; id: cint; value: cint) {.
    cdecl, importc: "IupSetIntId", dynlib: iuplib.}
proc iupSetFloatId*(ih: ptr Ihandle; name: cstring; id: cint; value: cfloat) {.
    cdecl, importc: "IupSetFloatId", dynlib: iuplib.}
proc iupSetDoubleId*(ih: ptr Ihandle; name: cstring; id: cint; value: cdouble) {.
    cdecl, importc: "IupSetDoubleId", dynlib: iuplib.}
proc iupSetRGBId*(ih: ptr Ihandle; name: cstring; id: cint; r: cuchar; 
                  g: cuchar; b: cuchar) {.cdecl, importc: "IupSetRGBId", 
    dynlib: iuplib.}
proc iupGetAttributeId*(ih: ptr Ihandle; name: cstring; id: cint): cstring {.
    cdecl, importc: "IupGetAttributeId", dynlib: iuplib.}
proc iupGetIntId*(ih: ptr Ihandle; name: cstring; id: cint): cint {.cdecl, 
    importc: "IupGetIntId", dynlib: iuplib.}
proc iupGetFloatId*(ih: ptr Ihandle; name: cstring; id: cint): cfloat {.cdecl, 
    importc: "IupGetFloatId", dynlib: iuplib.}
proc iupGetDoubleId*(ih: ptr Ihandle; name: cstring; id: cint): cdouble {.
    cdecl, importc: "IupGetDoubleId", dynlib: iuplib.}
proc iupGetRGBId*(ih: ptr Ihandle; name: cstring; id: cint; r: ptr cuchar; 
                  g: ptr cuchar; b: ptr cuchar) {.cdecl, 
    importc: "IupGetRGBId", dynlib: iuplib.}
proc iupSetAttributeId2*(ih: ptr Ihandle; name: cstring; lin: cint; col: cint; 
                         value: cstring) {.cdecl, 
    importc: "IupSetAttributeId2", dynlib: iuplib.}
proc iupSetStrAttributeId2*(ih: ptr Ihandle; name: cstring; lin: cint; 
                            col: cint; value: cstring) {.cdecl, 
    importc: "IupSetStrAttributeId2", dynlib: iuplib.}
proc iupSetStrfId2*(ih: ptr Ihandle; name: cstring; lin: cint; col: cint; 
                    format: cstring) {.varargs, cdecl, 
    importc: "IupSetStrfId2", dynlib: iuplib.}
proc iupSetIntId2*(ih: ptr Ihandle; name: cstring; lin: cint; col: cint; 
                   value: cint) {.cdecl, importc: "IupSetIntId2", 
                                  dynlib: iuplib.}
proc iupSetFloatId2*(ih: ptr Ihandle; name: cstring; lin: cint; col: cint; 
                     value: cfloat) {.cdecl, importc: "IupSetFloatId2", 
                                      dynlib: iuplib.}
proc iupSetDoubleId2*(ih: ptr Ihandle; name: cstring; lin: cint; col: cint; 
                      value: cdouble) {.cdecl, importc: "IupSetDoubleId2", 
    dynlib: iuplib.}
proc iupSetRGBId2*(ih: ptr Ihandle; name: cstring; lin: cint; col: cint; 
                   r: cuchar; g: cuchar; b: cuchar) {.cdecl, 
    importc: "IupSetRGBId2", dynlib: iuplib.}
proc iupGetAttributeId2*(ih: ptr Ihandle; name: cstring; lin: cint; col: cint): cstring {.
    cdecl, importc: "IupGetAttributeId2", dynlib: iuplib.}
proc iupGetIntId2*(ih: ptr Ihandle; name: cstring; lin: cint; col: cint): cint {.
    cdecl, importc: "IupGetIntId2", dynlib: iuplib.}
proc iupGetFloatId2*(ih: ptr Ihandle; name: cstring; lin: cint; col: cint): cfloat {.
    cdecl, importc: "IupGetFloatId2", dynlib: iuplib.}
proc iupGetDoubleId2*(ih: ptr Ihandle; name: cstring; lin: cint; col: cint): cdouble {.
    cdecl, importc: "IupGetDoubleId2", dynlib: iuplib.}
proc iupGetRGBId2*(ih: ptr Ihandle; name: cstring; lin: cint; col: cint; 
                   r: ptr cuchar; g: ptr cuchar; b: ptr cuchar) {.cdecl, 
    importc: "IupGetRGBId2", dynlib: iuplib.}
proc iupSetGlobal*(name: cstring; value: cstring) {.cdecl, 
    importc: "IupSetGlobal", dynlib: iuplib.}
proc iupSetStrGlobal*(name: cstring; value: cstring) {.cdecl, 
    importc: "IupSetStrGlobal", dynlib: iuplib.}
proc iupGetGlobal*(name: cstring): cstring {.cdecl, importc: "IupGetGlobal", 
    dynlib: iuplib.}
proc iupSetFocus*(ih: ptr Ihandle): ptr Ihandle {.cdecl, 
    importc: "IupSetFocus", dynlib: iuplib.}
proc iupGetFocus*(): ptr Ihandle {.cdecl, importc: "IupGetFocus", 
                                   dynlib: iuplib.}
proc iupPreviousField*(ih: ptr Ihandle): ptr Ihandle {.cdecl, 
    importc: "IupPreviousField", dynlib: iuplib.}
proc iupNextField*(ih: ptr Ihandle): ptr Ihandle {.cdecl, 
    importc: "IupNextField", dynlib: iuplib.}
proc iupGetCallback*(ih: ptr Ihandle; name: cstring): Icallback {.cdecl, 
    importc: "IupGetCallback", dynlib: iuplib.}
proc iupSetCallback*(ih: ptr Ihandle; name: cstring; `func`: Icallback): Icallback {.
    cdecl, importc: "IupSetCallback", dynlib: iuplib.}
proc iupSetCallbacks*(ih: ptr Ihandle; name: cstring; `func`: Icallback): ptr Ihandle {.
    varargs, cdecl, importc: "IupSetCallbacks", dynlib: iuplib.}
proc iupGetFunction*(name: cstring): Icallback {.cdecl, 
    importc: "IupGetFunction", dynlib: iuplib.}
proc iupSetFunction*(name: cstring; `func`: Icallback): Icallback {.cdecl, 
    importc: "IupSetFunction", dynlib: iuplib.}
proc iupGetHandle*(name: cstring): ptr Ihandle {.cdecl, 
    importc: "IupGetHandle", dynlib: iuplib.}
proc iupSetHandle*(name: cstring; ih: ptr Ihandle): ptr Ihandle {.cdecl, 
    importc: "IupSetHandle", dynlib: iuplib.}
proc iupGetAllNames*(names: cstringArray; n: cint): cint {.cdecl, 
    importc: "IupGetAllNames", dynlib: iuplib.}
proc iupGetAllDialogs*(names: cstringArray; n: cint): cint {.cdecl, 
    importc: "IupGetAllDialogs", dynlib: iuplib.}
proc iupGetName*(ih: ptr Ihandle): cstring {.cdecl, importc: "IupGetName", 
    dynlib: iuplib.}
proc iupSetAttributeHandle*(ih: ptr Ihandle; name: cstring; 
                            ihNamed: ptr Ihandle) {.cdecl, 
    importc: "IupSetAttributeHandle", dynlib: iuplib.}
proc iupGetAttributeHandle*(ih: ptr Ihandle; name: cstring): ptr Ihandle {.
    cdecl, importc: "IupGetAttributeHandle", dynlib: iuplib.}
proc iupGetClassName*(ih: ptr Ihandle): cstring {.cdecl, 
    importc: "IupGetClassName", dynlib: iuplib.}
proc iupGetClassType*(ih: ptr Ihandle): cstring {.cdecl, 
    importc: "IupGetClassType", dynlib: iuplib.}
proc iupGetAllClasses*(names: cstringArray; n: cint): cint {.cdecl, 
    importc: "IupGetAllClasses", dynlib: iuplib.}
proc iupGetClassAttributes*(classname: cstring; names: cstringArray; n: cint): cint {.
    cdecl, importc: "IupGetClassAttributes", dynlib: iuplib.}
proc iupGetClassCallbacks*(classname: cstring; names: cstringArray; n: cint): cint {.
    cdecl, importc: "IupGetClassCallbacks", dynlib: iuplib.}
proc iupSaveClassAttributes*(ih: ptr Ihandle) {.cdecl, 
    importc: "IupSaveClassAttributes", dynlib: iuplib.}
proc iupCopyClassAttributes*(srcIh: ptr Ihandle; dstIh: ptr Ihandle) {.cdecl, 
    importc: "IupCopyClassAttributes", dynlib: iuplib.}
proc iupSetClassDefaultAttribute*(classname: cstring; name: cstring; 
                                  value: cstring) {.cdecl, 
    importc: "IupSetClassDefaultAttribute", dynlib: iuplib.}
proc iupClassMatch*(ih: ptr Ihandle; classname: cstring): cint {.cdecl, 
    importc: "IupClassMatch", dynlib: iuplib.}
proc iupCreate*(classname: cstring): ptr Ihandle {.cdecl, 
    importc: "IupCreate", dynlib: iuplib.}
proc iupCreatev*(classname: cstring; params: ptr pointer): ptr Ihandle {.
    cdecl, importc: "IupCreatev", dynlib: iuplib.}
proc iupCreatep*(classname: cstring; first: pointer): ptr Ihandle {.varargs, 
    cdecl, importc: "IupCreatep", dynlib: iuplib.}
#**********************************************************************
#                        Elements                                      
#**********************************************************************
proc iupFill*(): ptr Ihandle {.cdecl, importc: "IupFill", dynlib: iuplib.}
proc iupRadio*(child: ptr Ihandle): ptr Ihandle {.cdecl, importc: "IupRadio", 
    dynlib: iuplib.}
proc iupVbox*(child: ptr Ihandle): ptr Ihandle {.varargs, cdecl, 
    importc: "IupVbox", dynlib: iuplib.}
proc iupVboxv*(children: ptr ptr Ihandle): ptr Ihandle {.cdecl, 
    importc: "IupVboxv", dynlib: iuplib.}
proc iupZbox*(child: ptr Ihandle): ptr Ihandle {.varargs, cdecl, 
    importc: "IupZbox", dynlib: iuplib.}
proc iupZboxv*(children: ptr ptr Ihandle): ptr Ihandle {.cdecl, 
    importc: "IupZboxv", dynlib: iuplib.}
proc iupHbox*(child: ptr Ihandle): ptr Ihandle {.varargs, cdecl, 
    importc: "IupHbox", dynlib: iuplib.}
proc iupHboxv*(children: ptr ptr Ihandle): ptr Ihandle {.cdecl, 
    importc: "IupHboxv", dynlib: iuplib.}
proc iupNormalizer*(ihFirst: ptr Ihandle): ptr Ihandle {.varargs, cdecl, 
    importc: "IupNormalizer", dynlib: iuplib.}
proc iupNormalizerv*(ihList: ptr ptr Ihandle): ptr Ihandle {.cdecl, 
    importc: "IupNormalizerv", dynlib: iuplib.}
proc iupCbox*(child: ptr Ihandle): ptr Ihandle {.varargs, cdecl, 
    importc: "IupCbox", dynlib: iuplib.}
proc iupCboxv*(children: ptr ptr Ihandle): ptr Ihandle {.cdecl, 
    importc: "IupCboxv", dynlib: iuplib.}
proc iupSbox*(child: ptr Ihandle): ptr Ihandle {.cdecl, importc: "IupSbox", 
    dynlib: iuplib.}
proc iupSplit*(child1: ptr Ihandle; child2: ptr Ihandle): ptr Ihandle {.cdecl, 
    importc: "IupSplit", dynlib: iuplib.}
proc iupScrollBox*(child: ptr Ihandle): ptr Ihandle {.cdecl, 
    importc: "IupScrollBox", dynlib: iuplib.}
proc iupGridBox*(child: ptr Ihandle): ptr Ihandle {.varargs, cdecl, 
    importc: "IupGridBox", dynlib: iuplib.}
proc iupGridBoxv*(children: ptr ptr Ihandle): ptr Ihandle {.cdecl, 
    importc: "IupGridBoxv", dynlib: iuplib.}
proc iupExpander*(child: ptr Ihandle): ptr Ihandle {.cdecl, 
    importc: "IupExpander", dynlib: iuplib.}
proc iupDetachBox*(child: ptr Ihandle): ptr Ihandle {.cdecl, 
    importc: "IupDetachBox", dynlib: iuplib.}
proc iupBackgroundBox*(child: ptr Ihandle): ptr Ihandle {.cdecl, 
    importc: "IupBackgroundBox", dynlib: iuplib.}
proc iupFrame*(child: ptr Ihandle): ptr Ihandle {.cdecl, importc: "IupFrame", 
    dynlib: iuplib.}
proc iupImage*(width: cint; height: cint; pixmap: ptr cuchar): ptr Ihandle {.
    cdecl, importc: "IupImage", dynlib: iuplib.}
proc iupImageRGB*(width: cint; height: cint; pixmap: ptr cuchar): ptr Ihandle {.
    cdecl, importc: "IupImageRGB", dynlib: iuplib.}
proc iupImageRGBA*(width: cint; height: cint; pixmap: ptr cuchar): ptr Ihandle {.
    cdecl, importc: "IupImageRGBA", dynlib: iuplib.}
proc iupItem*(title: cstring; action: cstring): ptr Ihandle {.cdecl, 
    importc: "IupItem", dynlib: iuplib.}
proc iupSubmenu*(title: cstring; child: ptr Ihandle): ptr Ihandle {.cdecl, 
    importc: "IupSubmenu", dynlib: iuplib.}
proc iupSeparator*(): ptr Ihandle {.cdecl, importc: "IupSeparator", 
                                    dynlib: iuplib.}
proc iupMenu*(child: ptr Ihandle): ptr Ihandle {.varargs, cdecl, 
    importc: "IupMenu", dynlib: iuplib.}
proc iupMenuv*(children: ptr ptr Ihandle): ptr Ihandle {.cdecl, 
    importc: "IupMenuv", dynlib: iuplib.}
proc iupButton*(title: cstring; action: cstring): ptr Ihandle {.cdecl, 
    importc: "IupButton", dynlib: iuplib.}
proc iupCanvas*(action: cstring): ptr Ihandle {.cdecl, importc: "IupCanvas", 
    dynlib: iuplib.}
proc iupDialog*(child: ptr Ihandle): ptr Ihandle {.cdecl, 
    importc: "IupDialog", dynlib: iuplib.}
proc iupUser*(): ptr Ihandle {.cdecl, importc: "IupUser", dynlib: iuplib.}
proc iupLabel*(title: cstring): ptr Ihandle {.cdecl, importc: "IupLabel", 
    dynlib: iuplib.}
proc iupList*(action: cstring): ptr Ihandle {.cdecl, importc: "IupList", 
    dynlib: iuplib.}
proc iupText*(action: cstring): ptr Ihandle {.cdecl, importc: "IupText", 
    dynlib: iuplib.}
proc iupMultiLine*(action: cstring): ptr Ihandle {.cdecl, 
    importc: "IupMultiLine", dynlib: iuplib.}
proc iupToggle*(title: cstring; action: cstring): ptr Ihandle {.cdecl, 
    importc: "IupToggle", dynlib: iuplib.}
proc iupTimer*(): ptr Ihandle {.cdecl, importc: "IupTimer", dynlib: iuplib.}
proc iupClipboard*(): ptr Ihandle {.cdecl, importc: "IupClipboard", 
                                    dynlib: iuplib.}
proc iupProgressBar*(): ptr Ihandle {.cdecl, importc: "IupProgressBar", 
                                      dynlib: iuplib.}
proc iupVal*(`type`: cstring): ptr Ihandle {.cdecl, importc: "IupVal", 
    dynlib: iuplib.}
proc iupTabs*(child: ptr Ihandle): ptr Ihandle {.varargs, cdecl, 
    importc: "IupTabs", dynlib: iuplib.}
proc iupTabsv*(children: ptr ptr Ihandle): ptr Ihandle {.cdecl, 
    importc: "IupTabsv", dynlib: iuplib.}
proc iupTree*(): ptr Ihandle {.cdecl, importc: "IupTree", dynlib: iuplib.}
proc iupLink*(url: cstring; title: cstring): ptr Ihandle {.cdecl, 
    importc: "IupLink", dynlib: iuplib.}
# Old controls, use SPIN attribute of IupText 
proc iupSpin*(): ptr Ihandle {.cdecl, importc: "IupSpin", dynlib: iuplib.}
proc iupSpinbox*(child: ptr Ihandle): ptr Ihandle {.cdecl, 
    importc: "IupSpinbox", dynlib: iuplib.}
#**********************************************************************
#                      Utilities                                       
#**********************************************************************
# IupImage utility 
proc iupSaveImageAsText*(ih: ptr Ihandle; fileName: cstring; format: cstring; 
                         name: cstring): cint {.cdecl, 
    importc: "IupSaveImageAsText", dynlib: iuplib.}
# IupText and IupScintilla utilities 
proc iupTextConvertLinColToPos*(ih: ptr Ihandle; lin: cint; col: cint; 
                                pos: ptr cint) {.cdecl, 
    importc: "IupTextConvertLinColToPos", dynlib: iuplib.}
proc iupTextConvertPosToLinCol*(ih: ptr Ihandle; pos: cint; lin: ptr cint; 
                                col: ptr cint) {.cdecl, 
    importc: "IupTextConvertPosToLinCol", dynlib: iuplib.}
# IupText, IupList, IupTree, IupMatrix and IupScintilla utility 
proc iupConvertXYToPos*(ih: ptr Ihandle; x: cint; y: cint): cint {.cdecl, 
    importc: "IupConvertXYToPos", dynlib: iuplib.}
# OLD names, kept for backward compatibility, will never be removed. 
proc iupStoreGlobal*(name: cstring; value: cstring) {.cdecl, 
    importc: "IupStoreGlobal", dynlib: iuplib.}
proc iupStoreAttribute*(ih: ptr Ihandle; name: cstring; value: cstring) {.
    cdecl, importc: "IupStoreAttribute", dynlib: iuplib.}
proc iupSetfAttribute*(ih: ptr Ihandle; name: cstring; format: cstring) {.
    varargs, cdecl, importc: "IupSetfAttribute", dynlib: iuplib.}
proc iupStoreAttributeId*(ih: ptr Ihandle; name: cstring; id: cint; 
                          value: cstring) {.cdecl, 
    importc: "IupStoreAttributeId", dynlib: iuplib.}
proc iupSetfAttributeId*(ih: ptr Ihandle; name: cstring; id: cint; f: cstring) {.
    varargs, cdecl, importc: "IupSetfAttributeId", dynlib: iuplib.}
proc iupStoreAttributeId2*(ih: ptr Ihandle; name: cstring; lin: cint; 
                           col: cint; value: cstring) {.cdecl, 
    importc: "IupStoreAttributeId2", dynlib: iuplib.}
proc iupSetfAttributeId2*(ih: ptr Ihandle; name: cstring; lin: cint; 
                          col: cint; format: cstring) {.varargs, cdecl, 
    importc: "IupSetfAttributeId2", dynlib: iuplib.}
# IupTree utilities 
proc iupTreeSetUserId*(ih: ptr Ihandle; id: cint; userid: pointer): cint {.
    cdecl, importc: "IupTreeSetUserId", dynlib: iuplib.}
proc iupTreeGetUserId*(ih: ptr Ihandle; id: cint): pointer {.cdecl, 
    importc: "IupTreeGetUserId", dynlib: iuplib.}
proc iupTreeGetId*(ih: ptr Ihandle; userid: pointer): cint {.cdecl, 
    importc: "IupTreeGetId", dynlib: iuplib.}
proc iupTreeSetAttributeHandle*(ih: ptr Ihandle; name: cstring; id: cint; 
                                ihNamed: ptr Ihandle) {.cdecl, 
    importc: "IupTreeSetAttributeHandle", dynlib: iuplib.}
# DEPRECATED IupTree utilities, use Iup*AttributeId functions. It will be removed in a future version.  
proc iupTreeSetAttribute*(ih: ptr Ihandle; name: cstring; id: cint; 
                          value: cstring) {.cdecl, 
    importc: "IupTreeSetAttribute", dynlib: iuplib.}
proc iupTreeStoreAttribute*(ih: ptr Ihandle; name: cstring; id: cint; 
                            value: cstring) {.cdecl, 
    importc: "IupTreeStoreAttribute", dynlib: iuplib.}
proc iupTreeGetAttribute*(ih: ptr Ihandle; name: cstring; id: cint): cstring {.
    cdecl, importc: "IupTreeGetAttribute", dynlib: iuplib.}
proc iupTreeGetInt*(ih: ptr Ihandle; name: cstring; id: cint): cint {.cdecl, 
    importc: "IupTreeGetInt", dynlib: iuplib.}
proc iupTreeGetFloat*(ih: ptr Ihandle; name: cstring; id: cint): cfloat {.
    cdecl, importc: "IupTreeGetFloat", dynlib: iuplib.}
proc iupTreeSetfAttribute*(ih: ptr Ihandle; name: cstring; id: cint; 
                           format: cstring) {.varargs, cdecl, 
    importc: "IupTreeSetfAttribute", dynlib: iuplib.}
# DEPRECATED callback management. It will be removed in a future version. 
proc iupGetActionName*(): cstring {.cdecl, importc: "IupGetActionName", 
                                    dynlib: iuplib.}
# DEPRECATED font names. It will be removed in a future version.  
proc iupMapFont*(iupfont: cstring): cstring {.cdecl, importc: "IupMapFont", 
    dynlib: iuplib.}
proc iupUnMapFont*(driverfont: cstring): cstring {.cdecl, 
    importc: "IupUnMapFont", dynlib: iuplib.}
#**********************************************************************
#                      Pre-definided dialogs                           
#**********************************************************************
proc iupFileDlg*(): ptr Ihandle {.cdecl, importc: "IupFileDlg", dynlib: iuplib.}
proc iupMessageDlg*(): ptr Ihandle {.cdecl, importc: "IupMessageDlg", 
                                     dynlib: iuplib.}
proc iupColorDlg*(): ptr Ihandle {.cdecl, importc: "IupColorDlg", 
                                   dynlib: iuplib.}
proc iupFontDlg*(): ptr Ihandle {.cdecl, importc: "IupFontDlg", dynlib: iuplib.}
proc iupProgressDlg*(): ptr Ihandle {.cdecl, importc: "IupProgressDlg", 
                                      dynlib: iuplib.}
proc iupGetFile*(arq: cstring): cint {.cdecl, importc: "IupGetFile", 
    dynlib: iuplib.}
proc iupMessage*(title: cstring; msg: cstring) {.cdecl, importc: "IupMessage", 
    dynlib: iuplib.}
proc iupMessagef*(title: cstring; format: cstring) {.varargs, cdecl, 
    importc: "IupMessagef", dynlib: iuplib.}
proc iupAlarm*(title: cstring; msg: cstring; b1: cstring; b2: cstring; 
               b3: cstring): cint {.cdecl, importc: "IupAlarm", dynlib: iuplib.}
proc iupScanf*(format: cstring): cint {.varargs, cdecl, importc: "IupScanf", 
    dynlib: iuplib.}
proc iupListDialog*(`type`: cint; title: cstring; size: cint; 
                    list: cstringArray; op: cint; maxCol: cint; maxLin: cint; 
                    marks: ptr cint): cint {.cdecl, importc: "IupListDialog", 
    dynlib: iuplib.}
proc iupGetText*(title: cstring; text: cstring): cint {.cdecl, 
    importc: "IupGetText", dynlib: iuplib.}
proc iupGetColor*(x: cint; y: cint; r: ptr cuchar; g: ptr cuchar; 
                  b: ptr cuchar): cint {.cdecl, importc: "IupGetColor", 
    dynlib: iuplib.}
type 
  Iparamcb* = proc (dialog: ptr Ihandle; paramIndex: cint; userData: pointer): cint {.
      cdecl.}
proc iupGetParam*(title: cstring; action: Iparamcb; userData: pointer; 
                  format: cstring): cint {.varargs, cdecl, 
    importc: "IupGetParam", dynlib: iuplib.}
proc iupGetParamv*(title: cstring; action: Iparamcb; userData: pointer; 
                   format: cstring; paramCount: cint; paramExtra: cint; 
                   paramData: ptr pointer): cint {.cdecl, 
    importc: "IupGetParamv", dynlib: iuplib.}
proc iupLayoutDialog*(dialog: ptr Ihandle): ptr Ihandle {.cdecl, 
    importc: "IupLayoutDialog", dynlib: iuplib.}
proc iupElementPropertiesDialog*(elem: ptr Ihandle): ptr Ihandle {.cdecl, 
    importc: "IupElementPropertiesDialog", dynlib: iuplib.}
#**********************************************************************
#                   Common Flags and Return Values                     
#**********************************************************************
const 
  IUP_ERROR* = 1
  IUP_NOERROR* = 0
  IUP_OPENED* = - 1
  IUP_INVALID* = - 1
  IUP_INVALID_ID* = - 10
#**********************************************************************
#                   Callback Return Values                             
#**********************************************************************
const 
  IUP_IGNORE* = - 1
  IUP_DEFAULT* = - 2
  IUP_CLOSE* = - 3
  IUP_CONTINUE* = - 4
#**********************************************************************
#           IupPopup and IupShowXY Parameter Values                    
#**********************************************************************
const 
  IUP_CENTER* = 0x0000FFFF
  IUP_LEFT* = 0x0000FFFE
  IUP_RIGHT* = 0x0000FFFD
  IUP_MOUSEPOS* = 0x0000FFFC
  IUP_CURRENT* = 0x0000FFFB
  IUP_CENTERPARENT* = 0x0000FFFA
  IUP_TOP* =IUP_LEFT
  IUP_BOTTOM* =  IUP_RIGHT
#**********************************************************************
#               SHOW_CB Callback Values                                
#**********************************************************************
const 
  IUP_SHOW* = 0
  IUP_RESTORE* = 1
  IUP_MINIMIZE* = 2
  IUP_MAXIMIZE* = 3
  IUP_HIDE* = 4
#**********************************************************************
#               SCROLL_CB Callback Values                              
#**********************************************************************
const 
  IUP_SBUP* = 0
  IUP_SBDN* = 1
  IUP_SBPGUP* = 2
  IUP_SBPGDN* = 3
  IUP_SBPOSV* = 4
  IUP_SBDRAGV* = 5
  IUP_SBLEFT* = 6
  IUP_SBRIGHT* = 7
  IUP_SBPGLEFT* = 8
  IUP_SBPGRIGHT* = 9
  IUP_SBPOSH* = 10
  IUP_SBDRAGH* = 11
#**********************************************************************
#               Mouse Button Values and Macros                         
#**********************************************************************
const 
  IUP_BUTTON1* = '1'
  IUP_BUTTON2* = '2'
  IUP_BUTTON3* = '3'
  IUP_BUTTON4* = '4'
  IUP_BUTTON5* = '5'
template iupIsshift*(s: expr): expr = 
  (s[0] == 'S')

template iupIscontrol*(s: expr): expr = 
  (s[1] == 'C')

template iupIsbutton1*(s: expr): expr = 
  (s[2] == '1')

template iupIsbutton2*(s: expr): expr = 
  (s[3] == '2')

template iupIsbutton3*(s: expr): expr = 
  (s[4] == '3')

template iupIsdouble*(s: expr): expr = 
  (s[5] == 'D')

template iupIsalt*(s: expr): expr = 
  (s[6] == 'A')

template iupIssys*(s: expr): expr = 
  (s[7] == 'Y')

template iupIsbutton4*(s: expr): expr = 
  (s[8] == '4')

template iupIsbutton5*(s: expr): expr = 
  (s[9] == '5')


#**********************************************************************
#                      Pre-Defined Masks                               
#**********************************************************************
const 
  IUP_MASK_FLOAT* = "[+/-]?(/d+/.?/d*|/./d+)"
  IUP_MASK_UFLOAT* = "(/d+/.?/d*|/./d+)"
  IUP_MASK_EFLOAT* = "[+/-]?(/d+/.?/d*|/./d+)([eE][+/-]?/d+)?"
  IUP_MASK_INT* = "[+/-]?/d+"
  IUP_MASK_UINT* = "/d+"

#**********************************************************************
#                   IupGetParam Callback situations                    
#**********************************************************************
const 
  IUP_GETPARAM_OK* = - 1
  IUP_GETPARAM_INIT* = - 2
  IUP_GETPARAM_CANCEL* = - 3
  IUP_GETPARAM_HELP* = - 4
#**********************************************************************
#                   Record Input Modes                                 
#**********************************************************************
const 
  IUP_RECBINARY* = 0
  IUP_RECTEXT* = 1


const
  K_SP* = cint(ord(' '))
  K_exclam* = cint(ord('!'))   
  K_quotedbl* = cint(ord('\"'))
  K_numbersign* = cint(ord('#'))
  K_dollar* = cint(ord('$'))
  K_percent* = cint(ord('%'))
  K_ampersand* = cint(ord('&'))
  K_apostrophe* = cint(ord('\''))
  K_parentleft* = cint(ord('('))
  K_parentright* = cint(ord(')'))
  K_asterisk* = cint(ord('*'))
  K_plus* = cint(ord('+'))
  K_comma* = cint(ord(','))
  K_minus* = cint(ord('-'))
  K_period* = cint(ord('.'))
  K_slash* = cint(ord('/'))
  K_0* = cint(ord('0'))
  K_1* = cint(ord('1'))
  K_2* = cint(ord('2'))
  K_3* = cint(ord('3'))
  K_4* = cint(ord('4'))
  K_5* = cint(ord('5'))
  K_6* = cint(ord('6'))
  K_7* = cint(ord('7'))
  K_8* = cint(ord('8'))
  K_9* = cint(ord('9'))
  K_colon* = cint(ord(':'))
  K_semicolon* = cint(ord(';'))
  K_less* = cint(ord('<'))
  K_equal* = cint(ord('='))
  K_greater* = cint(ord('>'))   
  K_question* = cint(ord('?'))   
  K_at* = cint(ord('@'))   
  K_upperA* = cint(ord('A'))   
  K_upperB* = cint(ord('B'))   
  K_upperC* = cint(ord('C'))   
  K_upperD* = cint(ord('D'))   
  K_upperE* = cint(ord('E'))   
  K_upperF* = cint(ord('F'))   
  K_upperG* = cint(ord('G'))   
  K_upperH* = cint(ord('H'))   
  K_upperI* = cint(ord('I'))   
  K_upperJ* = cint(ord('J'))   
  K_upperK* = cint(ord('K'))   
  K_upperL* = cint(ord('L'))   
  K_upperM* = cint(ord('M'))   
  K_upperN* = cint(ord('N'))   
  K_upperO* = cint(ord('O'))   
  K_upperP* = cint(ord('P'))   
  K_upperQ* = cint(ord('Q'))  
  K_upperR* = cint(ord('R'))  
  K_upperS* = cint(ord('S'))  
  K_upperT* = cint(ord('T'))  
  K_upperU* = cint(ord('U'))  
  K_upperV* = cint(ord('V')) 
  K_upperW* = cint(ord('W')) 
  K_upperX* = cint(ord('X'))  
  K_upperY* = cint(ord('Y'))  
  K_upperZ* = cint(ord('Z'))  
  K_bracketleft* = cint(ord('[')) 
  K_backslash* = cint(ord('\\'))  
  K_bracketright* = cint(ord(']'))  
  K_circum* = cint(ord('^'))   
  K_underscore* = cint(ord('_'))   
  K_grave* = cint(ord('`'))   
  K_lowera* = cint(ord('a'))  
  K_lowerb* = cint(ord('b'))   
  K_lowerc* = cint(ord('c')) 
  K_lowerd* = cint(ord('d'))   
  K_lowere* = cint(ord('e'))   
  K_lowerf* = cint(ord('f'))  
  K_lowerg* = cint(ord('g'))
  K_lowerh* = cint(ord('h')) 
  K_loweri* = cint(ord('i')) 
  K_lowerj* = cint(ord('j')) 
  K_lowerk* = cint(ord('k'))
  K_lowerl* = cint(ord('l'))
  K_lowerm* = cint(ord('m'))
  K_lowern* = cint(ord('n'))
  K_lowero* = cint(ord('o'))
  K_lowerp* = cint(ord('p'))
  K_lowerq* = cint(ord('q'))
  K_lowerr* = cint(ord('r'))
  K_lowers* = cint(ord('s'))
  K_lowert* = cint(ord('t'))
  K_loweru* = cint(ord('u'))
  K_lowerv* = cint(ord('v'))
  K_lowerw* = cint(ord('w'))
  K_lowerx* = cint(ord('x'))
  K_lowery* = cint(ord('y'))
  K_lowerz* = cint(ord('z'))  
  K_A* = cint(ord('a'))  
  K_B* = cint(ord('b'))   
  K_C* = cint(ord('c')) 
  K_D* = cint(ord('d'))   
  K_E* = cint(ord('e'))   
  K_F* = cint(ord('f'))  
  K_G* = cint(ord('g'))
  K_H* = cint(ord('h')) 
  K_I* = cint(ord('i')) 
  K_J* = cint(ord('j')) 
  K_K* = cint(ord('k'))
  K_L* = cint(ord('l'))
  K_M* = cint(ord('m'))
  K_N* = cint(ord('n'))
  K_O* = cint(ord('o'))
  K_P* = cint(ord('p'))
  K_Q* = cint(ord('q'))
  K_R* = cint(ord('r'))
  K_S* = cint(ord('s'))
  K_T* = cint(ord('t'))
  K_U* = cint(ord('u'))
  K_V* = cint(ord('v'))
  K_W* = cint(ord('w'))
  K_X* = cint(ord('x'))
  K_Y* = cint(ord('y'))
  K_Z* = cint(ord('z'))
  K_braceleft* = cint(ord('{'))
  K_bar* = cint(ord('|'))
  K_braceright* = cint(ord('}'))
  K_tilde* = cint(ord('~'))


  # Printable ASCii keys 
template iupIsprint*(c: expr): expr = 
    ((c) > 31 and (c) < 127)

# also define the escape sequences that have keys associated 
const 
  K_BS* = cint(ord('\b'))
  K_TAB* = cint(ord('\t'))
  K_LF* = cint(10)
  K_CRETURN* = cint(13)
  # backward compatible definitions 

template iupIsXkey*(c: expr): expr = 
    ((c) >= 128)
const 
    K_quoteleft* = K_grave
    K_quoteright* = K_apostrophe
  # IUP Extended Key Codes, range start at 128      


  # These use the same definition as X11 and GDK.
  #   This also means that any X11 or GDK definition can also be used. 
const 
    K_PAUSE* = 0x0000FF13
    K_ESC* = 0x0000FF1B
    K_HOME* = 0x0000FF50
    K_LEFT* = 0x0000FF51
    K_UP* = 0x0000FF52
    K_RIGHT* = 0x0000FF53
    K_DOWN* = 0x0000FF54
    K_PGUP* = 0x0000FF55
    K_PGDN* = 0x0000FF56
    K_END* = 0x0000FF57
    K_MIDDLE* = 0x0000FF0B
    K_Print* = 0x0000FF61
    K_INS* = 0x0000FF63
    K_Menu* = 0x0000FF67
    K_DEL* = 0x0000FFFF
    K_F1* = 0x0000FFBE
    K_F2* = 0x0000FFBF
    K_F3* = 0x0000FFC0
    K_F4* = 0x0000FFC1
    K_F5* = 0x0000FFC2
    K_F6* = 0x0000FFC3
    K_F7* = 0x0000FFC4
    K_F8* = 0x0000FFC5
    K_F9* = 0x0000FFC6
    K_F10* = 0x0000FFC7
    K_F11* = 0x0000FFC8
    K_F12* = 0x0000FFC9
  # no Shift/Ctrl/Alt 
const 
    K_LSHIFT* = 0x0000FFE1
    K_RSHIFT* = 0x0000FFE2
    K_LCTRL* = 0x0000FFE3
    K_RCTRL* = 0x0000FFE4
    K_LALT* = 0x0000FFE9
    K_RALT* = 0x0000FFEA
    K_NUM* = 0x0000FF7F
    K_SCROLL* = 0x0000FF14
    K_CAPS* = 0x0000FFE5
  # Also, these are the same as the Latin-1 definition 
const 
    K_lowerccedilla* = 0x000000E7
    K_upperCcedilla* = 0x000000C7
    K_acute* = 0x000000B4
    K_diaeresis* = 0x000000A8
  #****************************************************
  # Modifiers use last 4 bits. Since IUP 3.9           
  # These modifiers definitions are specific to IUP    
  #****************************************************
template iupIsShiftXkey*(c: expr): expr = 
    ((c) and 0x10000000)

template iupIsCtrlXkey*(c: expr): expr = 
    ((c) and 0x20000000)

template iupIsAltXkey*(c: expr): expr = 
    ((c) and 0x40000000)

template iupIsSysXkey*(c: expr): expr = 
    ((c) and 0x80000000)

template iupXkeyBase*(c: expr): expr = 
    ((c) and 0x0FFFFFFF)

template iupXkeyShift*(c: expr): expr = 
    ((c) or 0x10000000)       # Shift  
  
template iupXkeyCtrl*(c: expr): expr = 
    ((c) or 0x20000000)       # Ctrl   
  
template iupXkeyAlt*(c: expr): expr = 
    ((c) or 0x40000000)       # Alt    
  
template iupXkeySys*(c: expr): expr = 
    ((c) or 0x80000000)       # Sys (Win or Apple) 
  
  # These definitions are here for backward compatibility 
  #   and to simplify some key combination usage.
  #   But since IUP 3.9, modifiers can be combined with any key
  #   and they can be mixed togheter. 
const 
    K_sHOME* = iupXkeyShift(K_HOME)
    K_sUP* = iupXkeyShift(K_Up)
    K_sPGUP* = iupXkeyShift(K_Pgup)
    K_sLEFT* = iupXkeyShift(K_Left)
    K_sMIDDLE* = iupXkeyShift(K_Middle)
    K_sRIGHT* = iupXkeyShift(K_Right)
    K_sEND* = iupXkeyShift(K_End)
    K_sDOWN* = iupXkeyShift(K_Down)
    K_sPGDN* = iupXkeyShift(K_Pgdn)
    K_sINS* = iupXkeyShift(K_Ins)
    K_sDEL* = iupXkeyShift(K_Del)
    K_sSP* = iupXkeyShift(K_Sp)
    K_sTAB* = iupXkeyShift(K_TAB)
    K_sCR* = iupXkeyShift(K_CRETURN)
    K_sBS* = iupXkeyShift(K_Bs)
    K_sPAUSE* = iupXkeyShift(K_Pause)
    K_sESC* = iupXkeyShift(K_Esc)
    K_sF1* = iupXkeyShift(K_F1)
    K_sF2* = iupXkeyShift(K_F2)
    K_sF3* = iupXkeyShift(K_F3)
    K_sF4* = iupXkeyShift(K_F4)
    K_sF5* = iupXkeyShift(K_F5)
    K_sF6* = iupXkeyShift(K_F6)
    K_sF7* = iupXkeyShift(K_F7)
    K_sF8* = iupXkeyShift(K_F8)
    K_sF9* = iupXkeyShift(K_F9)
    K_sF10* = iupXkeyShift(K_F10)
    K_sF11* = iupXkeyShift(K_F11)
    K_sF12* = iupXkeyShift(K_F12)
    K_sPrint* = iupXkeyShift(K_Print)
    K_sMenu* = iupXkeyShift(K_Menu)
    K_cHOME* = iupXkeyCtrl(K_Home)
    K_cUP* = iupXkeyCtrl(K_Up)
    K_cPGUP* = iupXkeyCtrl(K_Pgup)
    K_cLEFT* = iupXkeyCtrl(K_Left)
    K_cMIDDLE* = iupXkeyCtrl(K_Middle)
    K_cRIGHT* = iupXkeyCtrl(K_Right)
    K_cEND* = iupXkeyCtrl(K_End)
    K_cDOWN* = iupXkeyCtrl(K_Down)
    K_cPGDN* = iupXkeyCtrl(K_Pgdn)
    K_cINS* = iupXkeyCtrl(K_Ins)
    K_cDEL* = iupXkeyCtrl(K_Del)
    K_cSP* = iupXkeyCtrl(K_Sp)
    K_cTAB* = iupXkeyCtrl(K_TAB)
    K_cCR* = iupXkeyCtrl(K_CRETURN)
    K_cBS* = iupXkeyCtrl(K_Bs)
    K_cPAUSE* = iupXkeyCtrl(K_Pause)
    K_cESC* = iupXkeyCtrl(K_Esc)
    K_cCcedilla* = iupXkeyCtrl(K_lowerccedilla)
    K_cF1* = iupXkeyCtrl(K_F1)
    K_cF2* = iupXkeyCtrl(K_F2)
    K_cF3* = iupXkeyCtrl(K_F3)
    K_cF4* = iupXkeyCtrl(K_F4)
    K_cF5* = iupXkeyCtrl(K_F5)
    K_cF6* = iupXkeyCtrl(K_F6)
    K_cF7* = iupXkeyCtrl(K_F7)
    K_cF8* = iupXkeyCtrl(K_F8)
    K_cF9* = iupXkeyCtrl(K_F9)
    K_cF10* = iupXkeyCtrl(K_F10)
    K_cF11* = iupXkeyCtrl(K_F11)
    K_cF12* = iupXkeyCtrl(K_F12)
    K_cPrint* = iupXkeyCtrl(K_Print)
    K_cMenu* = iupXkeyCtrl(K_Menu)
    K_mHOME* = iupXkeyAlt(K_Home)
    K_mUP* = iupXkeyAlt(K_Up)
    K_mPGUP* = iupXkeyAlt(K_Pgup)
    K_mLEFT* = iupXkeyAlt(K_Left)
    K_mMIDDLE* = iupXkeyAlt(K_Middle)
    K_mRIGHT* = iupXkeyAlt(K_Right)
    K_mEND* = iupXkeyAlt(K_End)
    K_mDOWN* = iupXkeyAlt(K_Down)
    K_mPGDN* = iupXkeyAlt(K_Pgdn)
    K_mINS* = iupXkeyAlt(K_Ins)
    K_mDEL* = iupXkeyAlt(K_Del)
    K_mSP* = iupXkeyAlt(K_Sp)
    K_mTAB* = iupXkeyAlt(K_TAB)
    K_mCR* = iupXkeyAlt(K_CRETURN)
    K_mBS* = iupXkeyAlt(K_Bs)
    K_mPAUSE* = iupXkeyAlt(K_Pause)
    K_mESC* = iupXkeyAlt(K_Esc)
    K_mCcedilla* = iupXkeyAlt(K_lowerccedilla)
    K_mF1* = iupXkeyAlt(K_F1)
    K_mF2* = iupXkeyAlt(K_F2)
    K_mF3* = iupXkeyAlt(K_F3)
    K_mF4* = iupXkeyAlt(K_F4)
    K_mF5* = iupXkeyAlt(K_F5)
    K_mF6* = iupXkeyAlt(K_F6)
    K_mF7* = iupXkeyAlt(K_F7)
    K_mF8* = iupXkeyAlt(K_F8)
    K_mF9* = iupXkeyAlt(K_F9)
    K_mF10* = iupXkeyAlt(K_F10)
    K_mF11* = iupXkeyAlt(K_F11)
    K_mF12* = iupXkeyAlt(K_F12)
    K_mPrint* = iupXkeyAlt(K_Print)
    K_mMenu* = iupXkeyAlt(K_Menu)
    K_yHOME* = iupXkeySys(K_Home)
    K_yUP* = iupXkeySys(K_Up)
    K_yPGUP* = iupXkeySys(K_Pgup)
    K_yLEFT* = iupXkeySys(K_Left)
    K_yMIDDLE* = iupXkeySys(K_Middle)
    K_yRIGHT* = iupXkeySys(K_Right)
    K_yEND* = iupXkeySys(K_End)
    K_yDOWN* = iupXkeySys(K_Down)
    K_yPGDN* = iupXkeySys(K_Pgdn)
    K_yINS* = iupXkeySys(K_Ins)
    K_yDEL* = iupXkeySys(K_Del)
    K_ySP* = iupXkeySys(K_Sp)
    K_yTAB* = iupXkeySys(K_TAB)
    K_yCR* = iupXkeySys(K_CRETURN)
    K_yBS* = iupXkeySys(K_Bs)
    K_yPAUSE* = iupXkeySys(K_Pause)
    K_yESC* = iupXkeySys(K_Esc)
    K_yCcedilla* = iupXkeySys(K_lowerccedilla)
    K_yF1* = iupXkeySys(K_F1)
    K_yF2* = iupXkeySys(K_F2)
    K_yF3* = iupXkeySys(K_F3)
    K_yF4* = iupXkeySys(K_F4)
    K_yF5* = iupXkeySys(K_F5)
    K_yF6* = iupXkeySys(K_F6)
    K_yF7* = iupXkeySys(K_F7)
    K_yF8* = iupXkeySys(K_F8)
    K_yF9* = iupXkeySys(K_F9)
    K_yF10* = iupXkeySys(K_F10)
    K_yF11* = iupXkeySys(K_F11)
    K_yF12* = iupXkeySys(K_F12)
    K_yPrint* = iupXkeySys(K_Print)
    K_yMenu* = iupXkeySys(K_Menu)
    K_sPlus* = iupXkeyShift(K_plus)
    K_sComma* = iupXkeyShift(K_comma)
    K_sMinus* = iupXkeyShift(K_minus)
    K_sPeriod* = iupXkeyShift(K_period)
    K_sSlash* = iupXkeyShift(K_slash)
    K_sAsterisk* = iupXkeyShift(K_asterisk)
    K_cA* = iupXkeyCtrl(K_A)
    K_cB* = iupXkeyCtrl(K_B)
    K_cC* = iupXkeyCtrl(K_C)
    K_cD* = iupXkeyCtrl(K_D)
    K_cE* = iupXkeyCtrl(K_E)
    K_cF* = iupXkeyCtrl(K_F)
    K_cG* = iupXkeyCtrl(K_G)
    K_cH* = iupXkeyCtrl(K_H)
    K_cI* = iupXkeyCtrl(K_I)
    K_cJ* = iupXkeyCtrl(K_J)
    K_cK* = iupXkeyCtrl(K_K)
    K_cL* = iupXkeyCtrl(K_L)
    K_cM* = iupXkeyCtrl(K_M)
    K_cN* = iupXkeyCtrl(K_N)
    K_cO* = iupXkeyCtrl(K_O)
    K_cP* = iupXkeyCtrl(K_P)
    K_cQ* = iupXkeyCtrl(K_Q)
    K_cR* = iupXkeyCtrl(K_R)
    K_cS* = iupXkeyCtrl(K_S)
    K_cT* = iupXkeyCtrl(K_T)
    K_cU* = iupXkeyCtrl(K_U)
    K_cV* = iupXkeyCtrl(K_V)
    K_cW* = iupXkeyCtrl(K_W)
    K_cX* = iupXkeyCtrl(K_X)
    K_cY* = iupXkeyCtrl(K_Y)
    K_cZ* = iupXkeyCtrl(K_Z)
    K_c1* = iupXkeyCtrl(K_1)
    K_c2* = iupXkeyCtrl(K_2)
    K_c3* = iupXkeyCtrl(K_3)
    K_c4* = iupXkeyCtrl(K_4)
    K_c5* = iupXkeyCtrl(K_5)
    K_c6* = iupXkeyCtrl(K_6)
    K_c7* = iupXkeyCtrl(K_7)
    K_c8* = iupXkeyCtrl(K_8)
    K_c9* = iupXkeyCtrl(K_9)
    K_c0* = iupXkeyCtrl(K_0)
    K_cPlus* = iupXkeyCtrl(K_plus)
    K_cComma* = iupXkeyCtrl(K_comma)
    K_cMinus* = iupXkeyCtrl(K_minus)
    K_cPeriod* = iupXkeyCtrl(K_period)
    K_cSlash* = iupXkeyCtrl(K_slash)
    K_cSemicolon* = iupXkeyCtrl(K_semicolon)
    K_cEqual* = iupXkeyCtrl(K_equal)
    K_cBracketleft* = iupXkeyCtrl(K_bracketleft)
    K_cBracketright* = iupXkeyCtrl(K_bracketright)
    K_cBackslash* = iupXkeyCtrl(K_backslash)
    K_cAsterisk* = iupXkeyCtrl(K_asterisk)
    K_mA* = iupXkeyAlt(K_A)
    K_mB* = iupXkeyAlt(K_B)
    K_mC* = iupXkeyAlt(K_C)
    K_mD* = iupXkeyAlt(K_D)
    K_mE* = iupXkeyAlt(K_E)
    K_mF* = iupXkeyAlt(K_F)
    K_mG* = iupXkeyAlt(K_G)
    K_mH* = iupXkeyAlt(K_H)
    K_mI* = iupXkeyAlt(K_I)
    K_mJ* = iupXkeyAlt(K_J)
    K_mK* = iupXkeyAlt(K_K)
    K_mL* = iupXkeyAlt(K_L)
    K_mM* = iupXkeyAlt(K_M)
    K_mN* = iupXkeyAlt(K_N)
    K_mO* = iupXkeyAlt(K_O)
    K_mP* = iupXkeyAlt(K_P)
    K_mQ* = iupXkeyAlt(K_Q)
    K_mR* = iupXkeyAlt(K_R)
    K_mS* = iupXkeyAlt(K_S)
    K_mT* = iupXkeyAlt(K_T)
    K_mU* = iupXkeyAlt(K_U)
    K_mV* = iupXkeyAlt(K_V)
    K_mW* = iupXkeyAlt(K_W)
    K_mX* = iupXkeyAlt(K_X)
    K_mY* = iupXkeyAlt(K_Y)
    K_mZ* = iupXkeyAlt(K_Z)
    K_m1* = iupXkeyAlt(K_1)
    K_m2* = iupXkeyAlt(K_2)
    K_m3* = iupXkeyAlt(K_3)
    K_m4* = iupXkeyAlt(K_4)
    K_m5* = iupXkeyAlt(K_5)
    K_m6* = iupXkeyAlt(K_6)
    K_m7* = iupXkeyAlt(K_7)
    K_m8* = iupXkeyAlt(K_8)
    K_m9* = iupXkeyAlt(K_9)
    K_m0* = iupXkeyAlt(K_0)
    K_mPlus* = iupXkeyAlt(K_plus)
    K_mComma* = iupXkeyAlt(K_comma)
    K_mMinus* = iupXkeyAlt(K_minus)
    K_mPeriod* = iupXkeyAlt(K_period)
    K_mSlash* = iupXkeyAlt(K_slash)
    K_mSemicolon* = iupXkeyAlt(K_semicolon)
    K_mEqual* = iupXkeyAlt(K_equal)
    K_mBracketleft* = iupXkeyAlt(K_bracketleft)
    K_mBracketright* = iupXkeyAlt(K_bracketright)
    K_mBackslash* = iupXkeyAlt(K_backslash)
    K_mAsterisk* = iupXkeyAlt(K_asterisk)
    K_yA* = iupXkeySys(K_A)
    K_yB* = iupXkeySys(K_B)
    K_yC* = iupXkeySys(K_C)
    K_yD* = iupXkeySys(K_D)
    K_yE* = iupXkeySys(K_E)
    K_yF* = iupXkeySys(K_F)
    K_yG* = iupXkeySys(K_G)
    K_yH* = iupXkeySys(K_H)
    K_yI* = iupXkeySys(K_I)
    K_yJ* = iupXkeySys(K_J)
    K_yK* = iupXkeySys(K_K)
    K_yL* = iupXkeySys(K_L)
    K_yM* = iupXkeySys(K_M)
    K_yN* = iupXkeySys(K_N)
    K_yO* = iupXkeySys(K_O)
    K_yP* = iupXkeySys(K_P)
    K_yQ* = iupXkeySys(K_Q)
    K_yR* = iupXkeySys(K_R)
    K_yS* = iupXkeySys(K_S)
    K_yT* = iupXkeySys(K_T)
    K_yU* = iupXkeySys(K_U)
    K_yV* = iupXkeySys(K_V)
    K_yW* = iupXkeySys(K_W)
    K_yX* = iupXkeySys(K_X)
    K_yY* = iupXkeySys(K_Y)
    K_yZ* = iupXkeySys(K_Z)
    K_y1* = iupXkeySys(K_1)
    K_y2* = iupXkeySys(K_2)
    K_y3* = iupXkeySys(K_3)
    K_y4* = iupXkeySys(K_4)
    K_y5* = iupXkeySys(K_5)
    K_y6* = iupXkeySys(K_6)
    K_y7* = iupXkeySys(K_7)
    K_y8* = iupXkeySys(K_8)
    K_y9* = iupXkeySys(K_9)
    K_y0* = iupXkeySys(K_0)
    K_yPlus* = iupXkeySys(K_plus)
    K_yComma* = iupXkeySys(K_comma)
    K_yMinus* = iupXkeySys(K_minus)
    K_yPeriod* = iupXkeySys(K_period)
    K_ySlash* = iupXkeySys(K_slash)
    K_ySemicolon* = iupXkeySys(K_semicolon)
    K_yEqual* = iupXkeySys(K_equal)
    K_yBracketleft* = iupXkeySys(K_bracketleft)
    K_yBracketright* = iupXkeySys(K_bracketright)
    K_yBackslash* = iupXkeySys(K_backslash)
    K_yAsterisk* = iupXkeySys(K_asterisk)
#* \file
#  \brief initializes dial, gauge, colorbrowser, colorbar controls.
# 
#  See Copyright Notice in "iup.h"
