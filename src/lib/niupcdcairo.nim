#* \file
#  \brief Cairo extra drivers.
#         Rendering PDF, PS, SVG and IMAGERGB.
# 
#  See Copyright Notice in cd.h
# 

when defined(windows):
  const libdcairo* = "libcdcairo.dll"
elif defined(macosx):
  const libdcairo* = "libcdcairo.dylib"
else:
  const libdcairo* = "libcdcairo.so" 

from niupcd import CdContext, PCdContext 

proc cdContextCairoNativeWindow*(): PCdContext {.cdecl, 
    importc: "cdContextCairoNativeWindow", dynlib: libdcairo.}
proc cdContextCairoImage*(): PCdContext {.cdecl, 
    importc: "cdContextCairoImage", dynlib: libdcairo.}
proc cdContextCairoDBuffer*(): PCdContext {.cdecl, 
    importc: "cdContextCairoDBuffer", dynlib: libdcairo.}
discard """ proc cdContextCairoPrinter*(): PCdContext {.cdecl, 
    importc: "cdContextCairoPrinter", dynlib: libdcairo.} """
proc cdContextCairoPS*(): PCdContext {.cdecl, importc: "cdContextCairoPS", 
    dynlib: libdcairo.}
proc cdContextCairoPDF*(): PCdContext {.cdecl, 
    importc: "cdContextCairoPDF", dynlib: libdcairo.}
proc cdContextCairoSVG*(): PCdContext {.cdecl, 
    importc: "cdContextCairoSVG", dynlib: libdcairo.}
proc cdContextCairoImageRGB*(): PCdContext {.cdecl, 
    importc: "cdContextCairoImageRGB", dynlib: libdcairo.}
     
discard """ const 
  CD_CAIRO_NATIVEWINDOW* = cdContextCairoNativeWindow
  CD_CAIRO_IMAGE* = cdContextCairoImage
  CD_CAIRO_DBUFFER* = cdContextCairoDBuffer
  #CD_CAIRO_PRINTER* = cdContextCairoPrinter
  CD_CAIRO_PS* = cdContextCairoPS
  CD_CAIRO_PDF* = cdContextCairoPDF
  CD_CAIRO_SVG* = cdContextCairoSVG
  CD_CAIRO_IMAGERGB* = cdContextCairoImageRGB """
