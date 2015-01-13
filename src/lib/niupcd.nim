#* \file
#  \brief User API
#  CD - Canvas Draw
#  Tecgraf: Computer Graphics Technology Group, PUC-Rio, Brazil
#  http://www.tecgraf.puc-rio.br/cd	
#  mailto:cd@tecgraf.puc-rio.br
# 

#*****************************************************************************
#Copyright (C) 1994-2014 Tecgraf, PUC-Rio.
#
#Permission is hereby granted, free of charge, to any person obtaining
#a copy of this software and associated documentation files (the
#"Software"), to deal in the Software without restriction, including
#without limitation the rights to use, copy, modify, merge, publish,
#distribute, sublicense, and/or sell copies of the Software, and to
#permit persons to whom the Software is furnished to do so, subject to
#the following conditions:
#
#The above copyright notice and this permission notice shall be
#included in all copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
#IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
#CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
#TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
#SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#****************************************************************************
# 

when defined(windows):
  const libcd* = "libiupcd.so.dll"
elif defined(macosx):
  const libcd* = "libiupcd.so.dylib"
else:
  const libcd* = "libiupcd.so" 

const 
  CD_NAME* = "CD - Canvas Draw"
  CD_DESCRIPTION* = "A 2D Graphics Library"
  CD_COPYRIGHT* = "Copyright (C) 1994-2014 Tecgraf, PUC-Rio."
  CD_VERSION* = "5.8"
  CD_VERSION_NUMBER* = 508000
  CD_VERSION_DATE* = "2014/07/25"
type 
  CdContext* = cint
  CdCanvas* = cint
  CdState* = cint
  CdImage* = cint
  PCdContext* = ptr CdContext
  PCdCanvas* = ptr CdCanvas
  PCdState* = ptr CdState
  PCdImage* = ptr CdImage 
# client images using bitmap structure 
type 
  CdBitmap* = object 
    w*: cint
    h*: cint
    `type`*: cint
    data*: pointer

# IUP Driver
type 
    PCD_IUP* = pointer 
      
proc cdContextIup*(): ptr CdContext {.cdecl, importc: "cdContextIup",dynlib: libcd.}
proc cdContextIupDBuffer*(): ptr CdContext {.cdecl, 
    importc: "cdContextIupDBuffer", dynlib: libcd.}
proc cdContextIupDBufferRGB*(): ptr CdContext {.cdecl, 
    importc: "cdContextIupDBufferRGB", dynlib: libcd.}

discard """ type
  TCD_IUP* = proc (closure: pointer): ptr CdContext {.cdecl,closure.} 
  
let CD_IUP* = cdContextIup() """

# library 
proc cdVersion*(): cstring {.cdecl, importc: "cdVersion", dynlib: libcd.}
proc cdVersionDate*(): cstring {.cdecl, importc: "cdVersionDate", 
                                 dynlib: libcd.}
proc cdVersionNumber*(): cint {.cdecl, importc: "cdVersionNumber", 
                                dynlib: libcd.}
# canvas init 
proc cdCreateCanvas*(context: PCdContext, data: pointer): PCdCanvas {.
    cdecl, importc: "cdCreateCanvas", dynlib: libcd.}
proc cdCreateCanvasf*(context: PCdContext, format: cstring): PCdCanvas {.
    varargs, cdecl, importc: "cdCreateCanvasf", dynlib: libcd.}
proc cdKillCanvas*(canvas: PCdCanvas) {.cdecl, importc: "cdKillCanvas", 
    dynlib: libcd.}
proc cdCanvasGetContext*(canvas: PCdCanvas): ptr CdContext {.cdecl, 
    importc: "cdCanvasGetContext", dynlib: libcd.}
proc cdCanvasActivate*(canvas: PCdCanvas): cint {.cdecl, 
    importc: "cdCanvasActivate", dynlib: libcd.}
proc cdCanvasDeactivate*(canvas: PCdCanvas) {.cdecl, 
    importc: "cdCanvasDeactivate", dynlib: libcd.}
proc cdUseContextPlus*(use: cint): cint {.cdecl, importc: "cdUseContextPlus", 
    dynlib: libcd.}
proc cdInitContextPlus*() {.cdecl, importc: "cdInitContextPlus", dynlib: libcd.}
# need an external library 
proc cdFinishContextPlus*() {.cdecl, importc: "cdFinishContextPlus", 
                              dynlib: libcd.}
# need an external library 
# context 
type 
  CdCallback* = proc (canvas: PCdCanvas): cint {.cdecl, varargs.}
proc cdContextRegisterCallback*(context: PCdContext, cb: cint; 
                                `func`: CdCallback): cint {.cdecl, 
    importc: "cdContextRegisterCallback", dynlib: libcd.}
proc cdContextCaps*(context: ptr CdContext): culong {.cdecl, 
    importc: "cdContextCaps", dynlib: libcd.}
proc cdContextIsPlus*(context: ptr CdContext): cint {.cdecl, 
    importc: "cdContextIsPlus", dynlib: libcd.}
proc cdContextType*(context: ptr CdContext): cint {.cdecl, 
    importc: "cdContextType", dynlib: libcd.}
# control 
proc cdCanvasSimulate*(canvas: PCdCanvas; mode: cint): cint {.cdecl, 
    importc: "cdCanvasSimulate", dynlib: libcd.}
proc cdCanvasFlush*(canvas: PCdCanvas) {.cdecl, importc: "cdCanvasFlush", 
    dynlib: libcd.}
proc cdCanvasClear*(canvas: PCdCanvas) {.cdecl, importc: "cdCanvasClear", 
    dynlib: libcd.}
proc cdCanvasSaveState*(canvas: PCdCanvas): ptr CdState {.cdecl, 
    importc: "cdCanvasSaveState", dynlib: libcd.}
proc cdCanvasRestoreState*(canvas: PCdCanvas; state: ptr CdState) {.cdecl, 
    importc: "cdCanvasRestoreState", dynlib: libcd.}
proc cdReleaseState*(state: ptr CdState) {.cdecl, importc: "cdReleaseState", 
    dynlib: libcd.}
proc cdCanvasSetAttribute*(canvas: PCdCanvas; name: cstring; data: cstring) {.
    cdecl, importc: "cdCanvasSetAttribute", dynlib: libcd.}
proc cdCanvasSetfAttribute*(canvas: PCdCanvas; name: cstring; 
                            format: cstring) {.varargs, cdecl, 
    importc: "cdCanvasSetfAttribute", dynlib: libcd.}
proc cdCanvasGetAttribute*(canvas: PCdCanvas; name: cstring): cstring {.
    cdecl, importc: "cdCanvasGetAttribute", dynlib: libcd.}
# interpretation 
proc cdCanvasPlay*(canvas: PCdCanvas; context: PCdContext, xmin: cint; 
                   xmax: cint; ymin: cint; ymax: cint; data: pointer): cint {.
    cdecl, importc: "cdCanvasPlay", dynlib: libcd.}
# coordinate transformation 
proc cdCanvasGetSize*(canvas: PCdCanvas; width: ptr cint; height: ptr cint; 
                      widthMm: ptr cdouble; heightMm: ptr cdouble) {.cdecl, 
    importc: "cdCanvasGetSize", dynlib: libcd.}
proc cdCanvasUpdateYAxis*(canvas: PCdCanvas; y: ptr cint): cint {.cdecl, 
    importc: "cdCanvasUpdateYAxis", dynlib: libcd.}
proc cdfCanvasUpdateYAxis*(canvas: PCdCanvas; y: ptr cdouble): cdouble {.
    cdecl, importc: "cdfCanvasUpdateYAxis", dynlib: libcd.}
proc cdCanvasInvertYAxis*(canvas: PCdCanvas; y: cint): cint {.cdecl, 
    importc: "cdCanvasInvertYAxis", dynlib: libcd.}
proc cdfCanvasInvertYAxis*(canvas: PCdCanvas; y: cdouble): cdouble {.cdecl, 
    importc: "cdfCanvasInvertYAxis", dynlib: libcd.}
proc cdCanvasMM2Pixel*(canvas: PCdCanvas; mmDx: cdouble; mmDy: cdouble; 
                       dx: ptr cint; dy: ptr cint) {.cdecl, 
    importc: "cdCanvasMM2Pixel", dynlib: libcd.}
proc cdCanvasPixel2MM*(canvas: PCdCanvas; dx: cint; dy: cint; 
                       mmDx: ptr cdouble; mmDy: ptr cdouble) {.cdecl, 
    importc: "cdCanvasPixel2MM", dynlib: libcd.}
proc cdfCanvasMM2Pixel*(canvas: PCdCanvas; mmDx: cdouble; mmDy: cdouble; 
                        dx: ptr cdouble; dy: ptr cdouble) {.cdecl, 
    importc: "cdfCanvasMM2Pixel", dynlib: libcd.}
proc cdfCanvasPixel2MM*(canvas: PCdCanvas; dx: cdouble; dy: cdouble; 
                        mmDx: ptr cdouble; mmDy: ptr cdouble) {.cdecl, 
    importc: "cdfCanvasPixel2MM", dynlib: libcd.}
proc cdCanvasOrigin*(canvas: PCdCanvas; x: cint; y: cint) {.cdecl, 
    importc: "cdCanvasOrigin", dynlib: libcd.}
proc cdfCanvasOrigin*(canvas: PCdCanvas; x: cdouble; y: cdouble) {.cdecl, 
    importc: "cdfCanvasOrigin", dynlib: libcd.}
proc cdCanvasGetOrigin*(canvas: PCdCanvas; x: ptr cint; y: ptr cint) {.
    cdecl, importc: "cdCanvasGetOrigin", dynlib: libcd.}
proc cdfCanvasGetOrigin*(canvas: PCdCanvas; x: ptr cdouble; y: ptr cdouble) {.
    cdecl, importc: "cdfCanvasGetOrigin", dynlib: libcd.}
proc cdCanvasTransform*(canvas: PCdCanvas; matrix: ptr cdouble) {.cdecl, 
    importc: "cdCanvasTransform", dynlib: libcd.}
proc cdCanvasGetTransform*(canvas: PCdCanvas): ptr cdouble {.cdecl, 
    importc: "cdCanvasGetTransform", dynlib: libcd.}
proc cdCanvasTransformMultiply*(canvas: PCdCanvas; matrix: ptr cdouble) {.
    cdecl, importc: "cdCanvasTransformMultiply", dynlib: libcd.}
proc cdCanvasTransformRotate*(canvas: PCdCanvas; angle: cdouble) {.cdecl, 
    importc: "cdCanvasTransformRotate", dynlib: libcd.}
proc cdCanvasTransformScale*(canvas: PCdCanvas; sx: cdouble; sy: cdouble) {.
    cdecl, importc: "cdCanvasTransformScale", dynlib: libcd.}
proc cdCanvasTransformTranslate*(canvas: PCdCanvas; dx: cdouble; 
                                 dy: cdouble) {.cdecl, 
    importc: "cdCanvasTransformTranslate", dynlib: libcd.}
proc cdCanvasTransformPoint*(canvas: PCdCanvas; x: cint; y: cint; 
                             tx: ptr cint; ty: ptr cint) {.cdecl, 
    importc: "cdCanvasTransformPoint", dynlib: libcd.}
proc cdfCanvasTransformPoint*(canvas: PCdCanvas; x: cdouble; y: cdouble; 
                              tx: ptr cdouble; ty: ptr cdouble) {.cdecl, 
    importc: "cdfCanvasTransformPoint", dynlib: libcd.}
# clipping 
proc cdCanvasClip*(canvas: PCdCanvas; mode: cint): cint {.cdecl, 
    importc: "cdCanvasClip", dynlib: libcd.}
proc cdCanvasClipArea*(canvas: PCdCanvas; xmin: cint; xmax: cint; 
                       ymin: cint; ymax: cint) {.cdecl, 
    importc: "cdCanvasClipArea", dynlib: libcd.}
proc cdCanvasGetClipArea*(canvas: PCdCanvas; xmin: ptr cint; 
                          xmax: ptr cint; ymin: ptr cint; ymax: ptr cint): cint {.
    cdecl, importc: "cdCanvasGetClipArea", dynlib: libcd.}
proc cdfCanvasClipArea*(canvas: PCdCanvas; xmin: cdouble; xmax: cdouble; 
                        ymin: cdouble; ymax: cdouble) {.cdecl, 
    importc: "cdfCanvasClipArea", dynlib: libcd.}
proc cdfCanvasGetClipArea*(canvas: PCdCanvas; xmin: ptr cdouble; 
                           xmax: ptr cdouble; ymin: ptr cdouble; 
                           ymax: ptr cdouble): cint {.cdecl, 
    importc: "cdfCanvasGetClipArea", dynlib: libcd.}
# clipping region 
proc cdCanvasIsPointInRegion*(canvas: PCdCanvas; x: cint; y: cint): cint {.
    cdecl, importc: "cdCanvasIsPointInRegion", dynlib: libcd.}
proc cdCanvasOffsetRegion*(canvas: PCdCanvas; x: cint; y: cint) {.cdecl, 
    importc: "cdCanvasOffsetRegion", dynlib: libcd.}
proc cdCanvasGetRegionBox*(canvas: PCdCanvas; xmin: ptr cint; 
                           xmax: ptr cint; ymin: ptr cint; ymax: ptr cint) {.
    cdecl, importc: "cdCanvasGetRegionBox", dynlib: libcd.}
proc cdCanvasRegionCombineMode*(canvas: PCdCanvas; mode: cint): cint {.
    cdecl, importc: "cdCanvasRegionCombineMode", dynlib: libcd.}
# primitives 
proc cdCanvasPixel*(canvas: PCdCanvas; x: cint; y: cint; color: clong) {.
    cdecl, importc: "cdCanvasPixel", dynlib: libcd.}
proc cdCanvasMark*(canvas: PCdCanvas; x: cint; y: cint) {.cdecl, 
    importc: "cdCanvasMark", dynlib: libcd.}
proc cdCanvasBegin*(canvas: PCdCanvas; mode: cint) {.cdecl, 
    importc: "cdCanvasBegin", dynlib: libcd.}
proc cdCanvasPathSet*(canvas: PCdCanvas; action: cint) {.cdecl, 
    importc: "cdCanvasPathSet", dynlib: libcd.}
proc cdCanvasEnd*(canvas: PCdCanvas) {.cdecl, importc: "cdCanvasEnd", 
    dynlib: libcd.}
proc cdCanvasLine*(canvas: PCdCanvas; x1: cint; y1: cint; x2: cint; 
                   y2: cint) {.cdecl, importc: "cdCanvasLine", dynlib: libcd.}
proc cdCanvasVertex*(canvas: PCdCanvas; x: cint; y: cint) {.cdecl, 
    importc: "cdCanvasVertex", dynlib: libcd.}
proc cdCanvasRect*(canvas: PCdCanvas; xmin: cint; xmax: cint; ymin: cint; 
                   ymax: cint) {.cdecl, importc: "cdCanvasRect", dynlib: libcd.}
proc cdCanvasBox*(canvas: PCdCanvas; xmin: cint; xmax: cint; ymin: cint; 
                  ymax: cint) {.cdecl, importc: "cdCanvasBox", dynlib: libcd.}
proc cdCanvasArc*(canvas: PCdCanvas; xc: cint; yc: cint; w: cint; h: cint; 
                  angle1: cdouble; angle2: cdouble) {.cdecl, 
    importc: "cdCanvasArc", dynlib: libcd.}
proc cdCanvasSector*(canvas: PCdCanvas; xc: cint; yc: cint; w: cint; 
                     h: cint; angle1: cdouble; angle2: cdouble) {.cdecl, 
    importc: "cdCanvasSector", dynlib: libcd.}
proc cdCanvasChord*(canvas: PCdCanvas; xc: cint; yc: cint; w: cint; 
                    h: cint; angle1: cdouble; angle2: cdouble) {.cdecl, 
    importc: "cdCanvasChord", dynlib: libcd.}
proc cdCanvasText*(canvas: PCdCanvas; x: cint; y: cint; s: cstring) {.
    cdecl, importc: "cdCanvasText", dynlib: libcd.}
proc cdfCanvasLine*(canvas: PCdCanvas; x1: cdouble; y1: cdouble; 
                    x2: cdouble; y2: cdouble) {.cdecl, 
    importc: "cdfCanvasLine", dynlib: libcd.}
proc cdfCanvasVertex*(canvas: PCdCanvas; x: cdouble; y: cdouble) {.cdecl, 
    importc: "cdfCanvasVertex", dynlib: libcd.}
proc cdfCanvasRect*(canvas: PCdCanvas; xmin: cdouble; xmax: cdouble; 
                    ymin: cdouble; ymax: cdouble) {.cdecl, 
    importc: "cdfCanvasRect", dynlib: libcd.}
proc cdfCanvasBox*(canvas: PCdCanvas; xmin: cdouble; xmax: cdouble; 
                   ymin: cdouble; ymax: cdouble) {.cdecl, 
    importc: "cdfCanvasBox", dynlib: libcd.}
proc cdfCanvasArc*(canvas: PCdCanvas; xc: cdouble; yc: cdouble; w: cdouble; 
                   h: cdouble; angle1: cdouble; angle2: cdouble) {.cdecl, 
    importc: "cdfCanvasArc", dynlib: libcd.}
proc cdfCanvasSector*(canvas: PCdCanvas; xc: cdouble; yc: cdouble; 
                      w: cdouble; h: cdouble; angle1: cdouble; angle2: cdouble) {.
    cdecl, importc: "cdfCanvasSector", dynlib: libcd.}
proc cdfCanvasChord*(canvas: PCdCanvas; xc: cdouble; yc: cdouble; 
                     w: cdouble; h: cdouble; angle1: cdouble; angle2: cdouble) {.
    cdecl, importc: "cdfCanvasChord", dynlib: libcd.}
proc cdfCanvasText*(canvas: PCdCanvas; x: cdouble; y: cdouble; s: cstring) {.
    cdecl, importc: "cdfCanvasText", dynlib: libcd.}
# attributes 
proc cdCanvasSetBackground*(canvas: PCdCanvas; color: clong) {.cdecl, 
    importc: "cdCanvasSetBackground", dynlib: libcd.}
proc cdCanvasSetForeground*(canvas: PCdCanvas; color: clong) {.cdecl, 
    importc: "cdCanvasSetForeground", dynlib: libcd.}
proc cdCanvasBackground*(canvas: PCdCanvas; color: clong): clong {.cdecl, 
    importc: "cdCanvasBackground", dynlib: libcd.}
proc cdCanvasForeground*(canvas: PCdCanvas; color: clong): clong {.cdecl, 
    importc: "cdCanvasForeground", dynlib: libcd.}
proc cdCanvasBackOpacity*(canvas: PCdCanvas; opacity: cint): cint {.cdecl, 
    importc: "cdCanvasBackOpacity", dynlib: libcd.}
proc cdCanvasWriteMode*(canvas: PCdCanvas; mode: cint): cint {.cdecl, 
    importc: "cdCanvasWriteMode", dynlib: libcd.}
proc cdCanvasLineStyle*(canvas: PCdCanvas; style: cint): cint {.cdecl, 
    importc: "cdCanvasLineStyle", dynlib: libcd.}
proc cdCanvasLineStyleDashes*(canvas: PCdCanvas; dashes: ptr cint; 
                              count: cint) {.cdecl, 
    importc: "cdCanvasLineStyleDashes", dynlib: libcd.}
proc cdCanvasLineWidth*(canvas: PCdCanvas; width: cint): cint {.cdecl, 
    importc: "cdCanvasLineWidth", dynlib: libcd.}
proc cdCanvasLineJoin*(canvas: PCdCanvas; join: cint): cint {.cdecl, 
    importc: "cdCanvasLineJoin", dynlib: libcd.}
proc cdCanvasLineCap*(canvas: PCdCanvas; cap: cint): cint {.cdecl, 
    importc: "cdCanvasLineCap", dynlib: libcd.}
proc cdCanvasInteriorStyle*(canvas: PCdCanvas; style: cint): cint {.cdecl, 
    importc: "cdCanvasInteriorStyle", dynlib: libcd.}
proc cdCanvasHatch*(canvas: PCdCanvas; style: cint): cint {.cdecl, 
    importc: "cdCanvasHatch", dynlib: libcd.}
proc cdCanvasStipple*(canvas: PCdCanvas; w: cint; h: cint; 
                      stipple: ptr cuchar) {.cdecl, 
    importc: "cdCanvasStipple", dynlib: libcd.}
proc cdCanvasGetStipple*(canvas: PCdCanvas; n: ptr cint; m: ptr cint): ptr cuchar {.
    cdecl, importc: "cdCanvasGetStipple", dynlib: libcd.}
proc cdCanvasPattern*(canvas: PCdCanvas; w: cint; h: cint; 
                      pattern: ptr clong) {.cdecl, importc: "cdCanvasPattern", 
    dynlib: libcd.}
proc cdCanvasGetPattern*(canvas: PCdCanvas; n: ptr cint; m: ptr cint): ptr clong {.
    cdecl, importc: "cdCanvasGetPattern", dynlib: libcd.}
proc cdCanvasFillMode*(canvas: PCdCanvas; mode: cint): cint {.cdecl, 
    importc: "cdCanvasFillMode", dynlib: libcd.}
proc cdCanvasFont*(canvas: PCdCanvas; typeFace: cstring; style: cint; 
                   size: cint): cint {.cdecl, importc: "cdCanvasFont", 
    dynlib: libcd.}
proc cdCanvasGetFont*(canvas: PCdCanvas; typeFace: cstring; 
                      style: ptr cint; size: ptr cint) {.cdecl, 
    importc: "cdCanvasGetFont", dynlib: libcd.}
proc cdCanvasNativeFont*(canvas: PCdCanvas; font: cstring): cstring {.
    cdecl, importc: "cdCanvasNativeFont", dynlib: libcd.}
proc cdCanvasTextAlignment*(canvas: PCdCanvas; alignment: cint): cint {.
    cdecl, importc: "cdCanvasTextAlignment", dynlib: libcd.}
proc cdCanvasTextOrientation*(canvas: PCdCanvas; angle: cdouble): cdouble {.
    cdecl, importc: "cdCanvasTextOrientation", dynlib: libcd.}
proc cdCanvasMarkType*(canvas: PCdCanvas; `type`: cint): cint {.cdecl, 
    importc: "cdCanvasMarkType", dynlib: libcd.}
proc cdCanvasMarkSize*(canvas: PCdCanvas; size: cint): cint {.cdecl, 
    importc: "cdCanvasMarkSize", dynlib: libcd.}
# vector text 
proc cdCanvasVectorText*(canvas: PCdCanvas; x: cint; y: cint; s: cstring) {.
    cdecl, importc: "cdCanvasVectorText", dynlib: libcd.}
proc cdCanvasMultiLineVectorText*(canvas: PCdCanvas; x: cint; y: cint; 
                                  s: cstring) {.cdecl, 
    importc: "cdCanvasMultiLineVectorText", dynlib: libcd.}
# vector text attributes 
proc cdCanvasVectorFont*(canvas: PCdCanvas; filename: cstring): cstring {.
    cdecl, importc: "cdCanvasVectorFont", dynlib: libcd.}
proc cdCanvasVectorTextDirection*(canvas: PCdCanvas; x1: cint; y1: cint; 
                                  x2: cint; y2: cint) {.cdecl, 
    importc: "cdCanvasVectorTextDirection", dynlib: libcd.}
proc cdCanvasVectorTextTransform*(canvas: PCdCanvas; matrix: ptr cdouble): ptr cdouble {.
    cdecl, importc: "cdCanvasVectorTextTransform", dynlib: libcd.}
proc cdCanvasVectorTextSize*(canvas: PCdCanvas; sizeX: cint; sizeY: cint; 
                             s: cstring) {.cdecl, 
    importc: "cdCanvasVectorTextSize", dynlib: libcd.}
proc cdCanvasVectorCharSize*(canvas: PCdCanvas; size: cint): cint {.cdecl, 
    importc: "cdCanvasVectorCharSize", dynlib: libcd.}
proc cdCanvasVectorFontSize*(canvas: PCdCanvas; sizeX: cdouble; 
                             sizeY: cdouble) {.cdecl, 
    importc: "cdCanvasVectorFontSize", dynlib: libcd.}
proc cdCanvasGetVectorFontSize*(canvas: PCdCanvas; sizeX: ptr cdouble; 
                                sizeY: ptr cdouble) {.cdecl, 
    importc: "cdCanvasGetVectorFontSize", dynlib: libcd.}
# vector text properties 
proc cdCanvasGetVectorTextSize*(canvas: PCdCanvas; s: cstring; x: ptr cint; 
                                y: ptr cint) {.cdecl, 
    importc: "cdCanvasGetVectorTextSize", dynlib: libcd.}
proc cdCanvasGetVectorTextBounds*(canvas: PCdCanvas; s: cstring; x: cint; 
                                  y: cint; rect: ptr cint) {.cdecl, 
    importc: "cdCanvasGetVectorTextBounds", dynlib: libcd.}
proc cdCanvasGetVectorTextBox*(canvas: PCdCanvas; x: cint; y: cint; 
                               s: cstring; xmin: ptr cint; xmax: ptr cint; 
                               ymin: ptr cint; ymax: ptr cint) {.cdecl, 
    importc: "cdCanvasGetVectorTextBox", dynlib: libcd.}
proc cdfCanvasVectorTextDirection*(canvas: PCdCanvas; x1: cdouble; 
                                   y1: cdouble; x2: cdouble; y2: cdouble) {.
    cdecl, importc: "cdfCanvasVectorTextDirection", dynlib: libcd.}
proc cdfCanvasVectorTextSize*(canvas: PCdCanvas; sizeX: cdouble; 
                              sizeY: cdouble; s: cstring) {.cdecl, 
    importc: "cdfCanvasVectorTextSize", dynlib: libcd.}
proc cdfCanvasGetVectorTextSize*(canvas: PCdCanvas; s: cstring; 
                                 x: ptr cdouble; y: ptr cdouble) {.cdecl, 
    importc: "cdfCanvasGetVectorTextSize", dynlib: libcd.}
proc cdfCanvasVectorCharSize*(canvas: PCdCanvas; size: cdouble): cdouble {.
    cdecl, importc: "cdfCanvasVectorCharSize", dynlib: libcd.}
proc cdfCanvasVectorText*(canvas: PCdCanvas; x: cdouble; y: cdouble; 
                          s: cstring) {.cdecl, importc: "cdfCanvasVectorText", 
    dynlib: libcd.}
proc cdfCanvasMultiLineVectorText*(canvas: PCdCanvas; x: cdouble; 
                                   y: cdouble; s: cstring) {.cdecl, 
    importc: "cdfCanvasMultiLineVectorText", dynlib: libcd.}
proc cdfCanvasGetVectorTextBounds*(canvas: PCdCanvas; s: cstring; 
                                   x: cdouble; y: cdouble; rect: ptr cdouble) {.
    cdecl, importc: "cdfCanvasGetVectorTextBounds", dynlib: libcd.}
proc cdfCanvasGetVectorTextBox*(canvas: PCdCanvas; x: cdouble; y: cdouble; 
                                s: cstring; xmin: ptr cdouble; 
                                xmax: ptr cdouble; ymin: ptr cdouble; 
                                ymax: ptr cdouble) {.cdecl, 
    importc: "cdfCanvasGetVectorTextBox", dynlib: libcd.}
# properties 
proc cdCanvasGetFontDim*(canvas: PCdCanvas; maxWidth: ptr cint; 
                         height: ptr cint; ascent: ptr cint; descent: ptr cint) {.
    cdecl, importc: "cdCanvasGetFontDim", dynlib: libcd.}
proc cdCanvasGetTextSize*(canvas: PCdCanvas; s: cstring; width: ptr cint; 
                          height: ptr cint) {.cdecl, 
    importc: "cdCanvasGetTextSize", dynlib: libcd.}
proc cdCanvasGetTextBox*(canvas: PCdCanvas; x: cint; y: cint; s: cstring; 
                         xmin: ptr cint; xmax: ptr cint; ymin: ptr cint; 
                         ymax: ptr cint) {.cdecl, 
    importc: "cdCanvasGetTextBox", dynlib: libcd.}
proc cdCanvasGetTextBounds*(canvas: PCdCanvas; x: cint; y: cint; 
                            s: cstring; rect: ptr cint) {.cdecl, 
    importc: "cdCanvasGetTextBounds", dynlib: libcd.}
proc cdCanvasGetColorPlanes*(canvas: PCdCanvas): cint {.cdecl, 
    importc: "cdCanvasGetColorPlanes", dynlib: libcd.}
# color 
proc cdCanvasPalette*(canvas: PCdCanvas; n: cint; palette: ptr clong; 
                      mode: cint) {.cdecl, importc: "cdCanvasPalette", 
                                    dynlib: libcd.}
# client images 
proc cdCanvasGetImageRGB*(canvas: PCdCanvas; r: ptr cuchar; g: ptr cuchar; 
                          b: ptr cuchar; x: cint; y: cint; w: cint; h: cint) {.
    cdecl, importc: "cdCanvasGetImageRGB", dynlib: libcd.}
proc cdCanvasPutImageRectRGB*(canvas: PCdCanvas; iw: cint; ih: cint; 
                              r: ptr cuchar; g: ptr cuchar; b: ptr cuchar; 
                              x: cint; y: cint; w: cint; h: cint; xmin: cint; 
                              xmax: cint; ymin: cint; ymax: cint) {.cdecl, 
    importc: "cdCanvasPutImageRectRGB", dynlib: libcd.}
proc cdCanvasPutImageRectRGBA*(canvas: PCdCanvas; iw: cint; ih: cint; 
                               r: ptr cuchar; g: ptr cuchar; b: ptr cuchar; 
                               a: ptr cuchar; x: cint; y: cint; w: cint; 
                               h: cint; xmin: cint; xmax: cint; ymin: cint; 
                               ymax: cint) {.cdecl, 
    importc: "cdCanvasPutImageRectRGBA", dynlib: libcd.}
proc cdCanvasPutImageRectMap*(canvas: PCdCanvas; iw: cint; ih: cint; 
                              index: ptr cuchar; colors: ptr clong; x: cint; 
                              y: cint; w: cint; h: cint; xmin: cint; 
                              xmax: cint; ymin: cint; ymax: cint) {.cdecl, 
    importc: "cdCanvasPutImageRectMap", dynlib: libcd.}
# server images 
proc cdCanvasCreateImage*(canvas: PCdCanvas; w: cint; h: cint): ptr CdImage {.
    cdecl, importc: "cdCanvasCreateImage", dynlib: libcd.}
proc cdKillImage*(image: ptr CdImage) {.cdecl, importc: "cdKillImage", 
    dynlib: libcd.}
proc cdCanvasGetImage*(canvas: PCdCanvas; image: ptr CdImage; x: cint; 
                       y: cint) {.cdecl, importc: "cdCanvasGetImage", 
                                  dynlib: libcd.}
proc cdCanvasPutImageRect*(canvas: PCdCanvas; image: ptr CdImage; x: cint; 
                           y: cint; xmin: cint; xmax: cint; ymin: cint; 
                           ymax: cint) {.cdecl, 
    importc: "cdCanvasPutImageRect", dynlib: libcd.}
proc cdCanvasScrollArea*(canvas: PCdCanvas; xmin: cint; xmax: cint; 
                         ymin: cint; ymax: cint; dx: cint; dy: cint) {.cdecl, 
    importc: "cdCanvasScrollArea", dynlib: libcd.}
# bitmap 
proc cdCreateBitmap*(w: cint; h: cint; `type`: cint): ptr CdBitmap {.cdecl, 
    importc: "cdCreateBitmap", dynlib: libcd.}
proc cdInitBitmap*(w: cint; h: cint; `type`: cint): ptr CdBitmap {.varargs, 
    cdecl, importc: "cdInitBitmap", dynlib: libcd.}
proc cdKillBitmap*(bitmap: ptr CdBitmap) {.cdecl, importc: "cdKillBitmap", 
    dynlib: libcd.}
proc cdBitmapGetData*(bitmap: ptr CdBitmap; dataptr: cint): ptr cuchar {.
    cdecl, importc: "cdBitmapGetData", dynlib: libcd.}
proc cdBitmapSetRect*(bitmap: ptr CdBitmap; xmin: cint; xmax: cint; 
                      ymin: cint; ymax: cint) {.cdecl, 
    importc: "cdBitmapSetRect", dynlib: libcd.}
proc cdCanvasPutBitmap*(canvas: PCdCanvas; bitmap: ptr CdBitmap; x: cint; 
                        y: cint; w: cint; h: cint) {.cdecl, 
    importc: "cdCanvasPutBitmap", dynlib: libcd.}
proc cdCanvasGetBitmap*(canvas: PCdCanvas; bitmap: ptr CdBitmap; x: cint; 
                        y: cint) {.cdecl, importc: "cdCanvasGetBitmap", 
                                   dynlib: libcd.}
proc cdBitmapRGB2Map*(bitmapRgb: ptr CdBitmap; bitmapMap: ptr CdBitmap) {.
    cdecl, importc: "cdBitmapRGB2Map", dynlib: libcd.}
# color 
proc cdEncodeColor*(red: cuchar; green: cuchar; blue: cuchar): clong {.cdecl, 
    importc: "cdEncodeColor", dynlib: libcd.}
proc cdDecodeColor*(color: clong; red: ptr cuchar; green: ptr cuchar; 
                    blue: ptr cuchar) {.cdecl, importc: "cdDecodeColor", 
    dynlib: libcd.}
proc cdDecodeAlpha*(color: clong): cuchar {.cdecl, importc: "cdDecodeAlpha", 
    dynlib: libcd.}
proc cdEncodeAlpha*(color: clong; alpha: cuchar): clong {.cdecl, 
    importc: "cdEncodeAlpha", dynlib: libcd.}
template cdAlpha*(s: expr): expr = 
  cast[cuchar]((not (((s) shr 24) and 0x000000FF)))

template cdReserved*(s: expr): expr = 
  cast[cuchar]((((s) shr 24) and 0x000000FF))

template cdRed*(s: expr): expr = 
  cast[cuchar]((((s) shr 16) and 0x000000FF))

template cdGreen*(s: expr): expr = 
  cast[cuchar]((((s) shr 8) and 0x000000FF))

template cdBlue*(s: expr): expr = 
  cast[cuchar]((((s) shr 0) and 0x000000FF))

# client image color convertion 
proc cdRGB2Map*(width: cint; height: cint; red: ptr cuchar; green: ptr cuchar; 
                blue: ptr cuchar; index: ptr cuchar; palSize: cint; 
                color: ptr clong) {.cdecl, importc: "cdRGB2Map", dynlib: libcd.}
# CD Values 
const 
  CD_QUERY* = - 1
const                       # bitmap type 
  CD_RGB* = 0               # these definitions are compatible with the IM library 
  CD_MAP* = 1
  CD_RGBA* = 0x00000100
const                       # bitmap data 
  CD_IRED* = 0
  CD_IGREEN* = 1
  CD_IBLUE* = 2
  CD_IALPHA* = 3
  CD_INDEX* = 4
  CD_COLORS* = 5
const                       # status report 
  CD_ERROR* = - 1
  CD_OK* = 0
const                       # clip mode 
  CD_CLIPOFF* = 0
  CD_CLIPAREA* = 1
  CD_CLIPPOLYGON* = 2
  CD_CLIPREGION* = 3
const                       # region combine mode 
  CD_UNION* = 0
  CD_INTERSECT* = 1
  CD_DIFFERENCE* = 2
  CD_NOTINTERSECT* = 3
const                       # polygon mode (begin...end) 
  CD_FILL* = 0
  CD_OPEN_LINES* = 1
  CD_CLOSED_LINES* = 2
  CD_CLIP* = 3
  CD_BEZIER* = 4
  CD_REGION* = 5
  CD_PATH* = 6
const 
  CD_POLYCUSTOM* = 10
const                       # path actions 
  CD_PATH_NEW* = 0
  CD_PATH_MOVETO* = 1
  CD_PATH_LINETO* = 2
  CD_PATH_ARC* = 3
  CD_PATH_CURVETO* = 4
  CD_PATH_CLOSE* = 5
  CD_PATH_FILL* = 6
  CD_PATH_STROKE* = 7
  CD_PATH_FILLSTROKE* = 8
  CD_PATH_CLIP* = 9
const                       # fill mode 
  CD_EVENODD* = 0
  CD_WINDING* = 1
const                       # line join  
  CD_MITER* = 0
  CD_BEVEL* = 1
  CD_ROUND* = 2
const                       # line cap  
  CD_CAPFLAT* = 0
  CD_CAPSQUARE* = 1
  CD_CAPROUND* = 2
const                       # background opacity mode 
  CD_OPAQUE* = 0
  CD_TRANSPARENT* = 1
const                       # write mode 
  CD_REPLACE* = 0
  CD_XOR* = 1
  CD_NOT_XOR* = 2
const                       # color allocation mode (palette) 
  CD_POLITE* = 0
  CD_FORCE* = 1
const                       # line style 
  CD_CONTINUOUS* = 0
  CD_DASHED* = 1
  CD_DOTTED* = 2
  CD_DASH_DOT* = 3
  CD_DASH_DOT_DOT* = 4
  CD_CUSTOM* = 5
const                       # marker type 
  CD_PLUS* = 0
  CD_STAR* = 1
  CD_CIRCLE* = 2
  CD_X* = 3
  CD_BOX* = 4
  CD_DIAMOND* = 5
  CD_HOLLOW_CIRCLE* = 6
  CD_HOLLOW_BOX* = 7
  CD_HOLLOW_DIAMOND* = 8
const                       # hatch type 
  CD_HORIZONTAL* = 0
  CD_VERTICAL* = 1
  CD_FDIAGONAL* = 2
  CD_BDIAGONAL* = 3
  CD_CROSS* = 4
  CD_DIAGCROSS* = 5
const                       # interior style 
  CD_SOLID* = 0
  CD_HATCH* = 1
  CD_STIPPLE* = 2
  CD_PATTERN* = 3
  CD_HOLLOW* = 4
const                       # text alignment 
  CD_NORTH* = 0
  CD_SOUTH* = 1
  CD_EAST* = 2
  CD_WEST* = 3
  CD_NORTH_EAST* = 4
  CD_NORTH_WEST* = 5
  CD_SOUTH_EAST* = 6
  CD_SOUTH_WEST* = 7
  CD_CENTER* = 8
  CD_BASE_LEFT* = 9
  CD_BASE_CENTER* = 10
  CD_BASE_RIGHT* = 11
const                       # style 
  CD_PLAIN* = 0
  CD_BOLD* = 1
  CD_ITALIC* = 2
  CD_UNDERLINE* = 4
  CD_STRIKEOUT* = 8
 
const                       # some font sizes 
  CD_SMALL* = 8
  CD_STANDARD* = 12
  CD_LARGE* = 18
# Context Capabilities 
const 
  CD_CAP_NONE* = 0x00000000
  CD_CAP_FLUSH* = 0x00000001
  CD_CAP_CLEAR* = 0x00000002
  CD_CAP_PLAY* = 0x00000004
  CD_CAP_YAXIS* = 0x00000008
  CD_CAP_CLIPAREA* = 0x00000010
  CD_CAP_CLIPPOLY* = 0x00000020
  CD_CAP_REGION* = 0x00000040
  CD_CAP_RECT* = 0x00000080
  CD_CAP_CHORD* = 0x00000100
  CD_CAP_IMAGERGB* = 0x00000200
  CD_CAP_IMAGERGBA* = 0x00000400
  CD_CAP_IMAGEMAP* = 0x00000800
  CD_CAP_GETIMAGERGB* = 0x00001000
  CD_CAP_IMAGESRV* = 0x00002000
  CD_CAP_BACKGROUND* = 0x00004000
  CD_CAP_BACKOPACITY* = 0x00008000
  CD_CAP_WRITEMODE* = 0x00010000
  CD_CAP_LINESTYLE* = 0x00020000
  CD_CAP_LINEWITH* = 0x00040000
  CD_CAP_FPRIMTIVES* = 0x00080000
  CD_CAP_HATCH* = 0x00100000
  CD_CAP_STIPPLE* = 0x00200000
  CD_CAP_PATTERN* = 0x00400000
  CD_CAP_FONT* = 0x00800000
  CD_CAP_FONTDIM* = 0x01000000
  CD_CAP_TEXTSIZE* = 0x02000000
  CD_CAP_TEXTORIENTATION* = 0x04000000
  CD_CAP_PALETTE* = 0x08000000
  CD_CAP_LINECAP* = 0x10000000
  CD_CAP_LINEJOIN* = 0x20000000
  CD_CAP_PATH* = 0x40000000
  CD_CAP_BEZIER* = 0x80000000
  CD_CAP_ALL* = 0xFFFFFFFF
# Context Types 
const 
  CD_CTX_WINDOW* = 0
  CD_CTX_DEVICE* = 1
  CD_CTX_IMAGE* = 2
  CD_CTX_FILE* = 3
# cdPlay definitions 
#const 
#  CD_SIZECB* = 0
type 
  CdSizeCB* = proc (canvas: PCdCanvas; w: cint; h: cint; wMm: cdouble; 
                    hMm: cdouble): cint {.cdecl.}
const 
  CD_ABORT* = 1
  CD_CONTINUE* = 0
# simulation flags 
const 
  CD_SIM_NONE* = 0x00000000
  CD_SIM_LINE* = 0x00000001
  CD_SIM_RECT* = 0x00000002
  CD_SIM_BOX* = 0x00000004
  CD_SIM_ARC* = 0x00000008
  CD_SIM_SECTOR* = 0x00000010
  CD_SIM_CHORD* = 0x00000020
  CD_SIM_POLYLINE* = 0x00000040
  CD_SIM_POLYGON* = 0x00000080
  CD_SIM_TEXT* = 0x00000100
  CD_SIM_ALL* = 0x0000FFFF
  CCD_SIM_LINES* = (CD_SIM_LINE or CD_SIM_RECT or CD_SIM_ARC or
      CD_SIM_POLYLINE)
  CSCD_SIM_FILLS* = (
    CD_SIM_BOX or CD_SIM_SECTOR or CD_SIM_CHORD or CD_SIM_POLYGON)
# some predefined colors for convenience 
const 
  CD_RED* = 0x00FF0000
  CD_DARK_RED* = 0x00800000
  CD_GREEN* = 0x0000FF00
  CD_DARK_GREEN* = 0x00008000
  CD_BLUE* = 0x000000FF
  CD_DARK_BLUE* = 0x00000080
  CD_YELLOW* = 0x00FFFF00
  CD_DARK_YELLOW* = 0x00808000
  CD_MAGENTA* = 0x00FF00FF
  CD_DARK_MAGENTA* = 0x00800080
  CD_CYAN* = 0x0000FFFF
  CD_DARK_CYAN* = 0x00008080
  CD_WHITE* = 0x00FFFFFF
  CD_BLACK* = 0x00000000
  CD_DARK_GRAY* = 0x00808080
  CD_GRAY* = 0x00C0C0C0
# some usefull conversion factors 
const 
  CD_MM2PT* = 2.834645669
  CD_RAD2DEG* = 57.295779513
  CD_DEG2RAD* = 0.01745329252
# paper sizes 
const 
  CD_A0* = 0
  CD_A1* = 1
  CD_A2* = 2
  CD_A3* = 3
  CD_A4* = 4
  CD_A5* = 5
  CD_LETTER* = 6
  CD_LEGAL* = 7

