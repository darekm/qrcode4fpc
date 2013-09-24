{$IFDEF FPC}
{$DEFINE FPCIMAGE}
{$ENDIF}
unit qrcodeimg;

interface

uses
  qrCode,
  {$IFDEF FPCIMAGE}
  FPImage, BmpComn, fpreadbmp, fpwritebmp, fpwritepng,
  {$ELSE}
  graphics,

  pngimage,
  {$ENDIF}
  Classes;

{$H+}

type
  {$IFDEF FPCIMAGE}
  tFPBitmap = TFPmemoryImage;
  tFPGraphic = TFPCustomImage;
  {$ELSE}
  tFPBitmap = TBitmap;
  tFPGraphic = TGraphic;
  tFpColor = tColor;
  {$ENDIF}


  tQrCodeImg = class
  private
    fChunk: integer;
    fSpace, fSize: integer;
    bitmap: tFpBitmap;
    procedure setPoint(ax, ay: integer; aSet: boolean);
    procedure setSize(aSize: integer);
    procedure erase;
  public
    constructor Create;
    destructor Destroy; override;
    procedure parse(aMatrix: string);
    function bmp: ansistring;
    function png: ansistring;

    property size: integer read fSize;
  end;


implementation

  {$IFDEF FPCIMAGE}
const
  clBlack: tFpColor = (red: 0);
  clWhite: tFpColor = (red: $FFFF; green: $FFFF; Blue: $ffff; Alpha: $FFFF);

  {$ENDIF}


constructor tQrCodeImg.Create;
begin

  {$IFDEF FPCIMAGE}
  bitmap := tFpBitmap.Create(1, 1);
  bitmap.colors[0, 0] := clWhite;
  {$ELSE}
  bitmap:=tFpBitmap.create;
  {$ENDIF}
  fChunk := 4;
  fSpace := 20;
end;

destructor tQrCodeImg.Destroy;
begin
  bitmap.Free;
  inherited;

end;

procedure tQrCodeImg.setSize(aSize: integer);
begin
  fSize := aSize;
  Bitmap.Width := (fSize+2)*fChunk+2*fSpace;
  Bitmap.Height := (fSize+2)*fChunk+2*fSpace;
  erase;
end;


procedure tQrCodeImg.erase;
var
  x, y: integer;
begin
  {$IFDEF FPCIMAGE}

  for x := 0 to bitmap.Width-1 do
    for y := 0 to bitmap.Height-1 do
      bitmap.colors[x, y] := clWhite;
 {$ENDIF}
end;

procedure tQrCodeImg.setPoint(ax, ay: integer; aSet: boolean);
var
  xColor: tFpColor;
  xx, yy: integer;

begin
  {$IFNDEF FPCIMAGE}
  if aSet then xColor:=clBlack
          else xColor:=clWhite;
  for xx:=1 to fChunk do
    for yy:= 1 to fChunk do
      bitmap.canvas.pixels[ax*fChunk+xx+fSpace,ay*fChunk+yy+fSpace]:=xColor;
  {$ELSE}
  fillchar(xColor, sizeof(xcolor), 0);
  xColor.Alpha := AlphaOpaque;

  if aSet then
    xColor := clBlack
  else
  begin
    xColor := clWhite;
    //           xColor.Red:=$FFFF; xColor.Green:=$FFFF; xColor.Blue:=$FFFF;xColor.Alpha:= $FFFF;
  end;

  for xx := 1 to fChunk do
    for yy := 1 to fChunk do
      bitmap.colors[ax*fChunk+xx+fSpace, ay*fChunk+yy+fSpace] := xColor;
  {$ENDIF}
end;

procedure tQrCodeImg.parse;
var
  i:    integer;
  x, y: integer;

begin

  x := 0;
  for i := 1 to length(aMatrix) do
  begin
    case aMatrix[i] of
      '0', '1':
      begin
        Inc(x);
      end;
      #10:
      begin
        setSize(x);
        break;
      end;
    end;
  end;
  x := 0;
  y := 0;
  for i := 1 to length(aMatrix) do
  begin
    case aMatrix[i] of
      '0', '1':
      begin
        setPoint(x, y, aMatrix[i] = '1');
        Inc(x);
      end;
      #10:
      begin
        x := 0;
        Inc(y);
      end;
    end;
  end;

end;

  {$IFDEF FPCIMAGE}
function tQrCodeImg.bmp: string;
var
  stream: tStringStream;
  tw:     TFPWriterBMP;
begin
  stream := tStringStream.Create('');
  tw := TFPWriterBMP.Create;
  Tw.BitsPerPixel := 8;
  Bitmap.SaveToStream(Stream, tw);
  Result := stream.DataString;
  stream.Free;
  tw.Free;

end;

function tQrCodeImg.png: string;

var
  stream: tStringStream;
  tw:     TFPWriterPNG;
begin
  stream := tStringStream.Create('');
  tw := TFPWriterPNG.Create;
  Bitmap.SaveToStream(Stream, tw);
  Result := stream.DataString;
  stream.Free;
  tw.Free;

end;

{$ELSE}
function tQrCodeImg.bmp:string;
var
  stream : tStringStream;
begin
  stream:=tStringStream.create('');

  Bitmap.SaveToStream(Stream);
  result:=stream.DataString;
  stream.free;

end;


function tQrCodeImg.png;
var
  xPng : tPngObject;
  stream : tStringStream;
begin
  xPng:=tPngObject.create;
  xPng.assign(bitmap);

  stream:=tStringStream.create('');

  xPng.SaveToStream(Stream);
  result:=stream.DataString;
  stream.free;
  xPng.free;
end;
{$ENDIF}

end.
