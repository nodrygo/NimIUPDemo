#* \file
#  \brief Scintilla control.
# 
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
  const libscintilla* = "libiup_scintilla.dll"
elif defined(macosx):
  const libscintilla* = "libiup_scintilla.dylib"
else:
  const libscintilla* = "libiup_scintilla.so" 
  
from niup import Ihandle ,PIhandle
  
proc iupScintillaOpen*() {.cdecl, importc: "IupScintillaOpen", 
                           dynlib: libscintilla.}
proc iupScintilla*(): ptr Ihandle {.cdecl, importc: "IupScintilla", 
                                    dynlib: libscintilla.}
when defined(SCINTILLA_H): 
  proc iupScintillaSendMessage*(ih: ptr Ihandle; iMessage: cuint; 
                                wParam: UptrT; lParam: SptrT): SptrT {.cdecl, 
      importc: "IupScintillaSendMessage", dynlib: libscintilla.}
