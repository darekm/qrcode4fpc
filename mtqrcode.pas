unit mtqrcode;

interface

uses
  Forms,
  qrcode,
  qrcodeimg,
  Graphics,
  testframework;

type
  tmdQRcode = class(ttestCase)
  private

    function qrcode(aData: string): string;
  published
    //    procedure test1;
    procedure test2;
    procedure test3;
    procedure test4;
    procedure testEncode;
    procedure testGetAlphanumericCode;
    procedure testAppendAlphanumericBytes;
    procedure testIMG;
    procedure testUrl;

  end;

implementation


function tmdQrCode.qrcode(aData: string): string;

var
  qr: tQrCode;
begin
  qr := tQrCode.Create;
  qr.Encode_Mode := ALPHA_NUMERIC;
  //  qr.version:=6;
  qr.error_correction := 'H';
  //            String encoding = cboEncoding.Text ;
{            if (aencoding = 'Byte') then begin
                qr.EncodeMode := tQRCode.EBYTE;
            end else if (aencoding = 'AlphaNumeric') then begin
                qrEncodeMode := tQrCode.ALPHA_NUMERIC;
            end else if (encoding = 'Numeric') then begin
                qrCodeEncoder.QRCodeEncodeMode = QRCodeEncoder.ENCODE_MODE.NUMERIC;
            end;
}
{           try
                int scale = Convert.ToInt16(txtSize.Text);
                qrCodeEncoder.QRCodeScale = scale;
            except
             on ex:Exception do
                komunikat('Invalid size!');
                exit;
            end;
}
  //                int version = Convert.ToInt16(cboVersion.Text) ;
  //                qr.Version = version;

{            string errorCorrect = cboCorrectionLevel.Text;
            if (errorCorrect == "L")
                qrCodeEncoder.QRCodeErrorCorrect = QRCodeEncoder.ERROR_CORRECTION.L;
            else if (errorCorrect == "M")
                qrCodeEncoder.QRCodeErrorCorrect = QRCodeEncoder.ERROR_CORRECTION.M;
            else if (errorCorrect == "Q")
                qrCodeEncoder.QRCodeErrorCorrect = QRCodeEncoder.ERROR_CORRECTION.Q;
            else if (errorCorrect == "H")
                qrCodeEncoder.QRCodeErrorCorrect = QRCodeEncoder.ERROR_CORRECTION.H;
}
  Result := qr.Encode(adata);
  qr.Free;

end;


procedure tmdQRcode.test4;
begin
  qrcode('ABSDeee');
  qrcode('ABSDeee');
  checkEquals('0101', '0101', '123');
end;


procedure tmdQRcode.testEncode;
var
  qr: tQrCode;

  // Numbers are from http://www.swetake.com/qr/qr8.html
begin
  qr := tQrCode.Create;
  qr.Encode_Mode := ALPHA_NUMERIC;
  //  qr.version:=6;
  qr.error_correction := 'H';
  qr.setData('ABCDE123');
  qr.encodemode;
  qr.encodeECC;
  checkEquals(#32#65#205#69#41#220#46#128#236, qr.getCodeWords);
  checkEquals(#32#65#205#69#41#220#46#128#236#42#159#74#221#244#169#239#150#138#70#237#85#224#96#74#219#61, qr.xCalculationECC);
  checkEquals(3, qr.getMask);

  qr.Free;

end;

procedure tmdQrCode.test3;
var
  sExpected: string;

begin
  // From http://www.swetake.com/qr/qr7.html
  Sexpected :=
    ' 1 1 1 1 1 1 1 0 0 1 1 0 0 0 1 1 1 1 1 1 1'#10 +
    ' 1 0 0 0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 1'#10 +
    ' 1 0 1 1 1 0 1 0 0 0 0 1 0 0 1 0 1 1 1 0 1'#10 +
    ' 1 0 1 1 1 0 1 0 0 1 1 0 0 0 1 0 1 1 1 0 1'#10 +
    ' 1 0 1 1 1 0 1 0 1 1 0 0 1 0 1 0 1 1 1 0 1'#10 +
    ' 1 0 0 0 0 0 1 0 0 0 1 1 1 0 1 0 0 0 0 0 1'#10 +
    ' 1 1 1 1 1 1 1 0 1 0 1 0 1 0 1 1 1 1 1 1 1'#10 +
    ' 0 0 0 0 0 0 0 0 1 1 0 1 1 0 0 0 0 0 0 0 0'#10 +
    ' 0 0 1 1 0 0 1 1 1 0 0 1 1 1 1 0 1 0 0 0 0'#10 +
    ' 1 0 1 0 1 0 0 0 0 0 1 1 1 0 0 1 0 1 1 1 0'#10 +
    ' 1 1 1 1 0 1 1 0 1 0 1 1 1 0 0 1 1 1 0 1 0'#10 +
    ' 1 0 1 0 1 1 0 1 1 1 0 0 1 1 1 0 0 1 0 1 0'#10 +
    ' 0 0 1 0 0 1 1 1 0 0 0 0 0 0 1 0 1 1 1 1 1'#10 +
    ' 0 0 0 0 0 0 0 0 1 1 0 1 0 0 0 0 0 1 0 1 1'#10 +
    ' 1 1 1 1 1 1 1 0 1 1 1 1 0 0 0 0 1 0 1 1 0'#10 +
    ' 1 0 0 0 0 0 1 0 0 0 0 1 0 1 1 1 0 0 0 0 0'#10 +
    ' 1 0 1 1 1 0 1 0 0 1 0 0 1 1 0 0 1 0 0 1 1'#10 +
    ' 1 0 1 1 1 0 1 0 1 1 0 1 0 0 0 0 0 1 1 1 0'#10 +
    ' 1 0 1 1 1 0 1 0 1 1 1 1 0 0 0 0 1 1 1 0 0'#10 +
    ' 1 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 1 0 1 0 0'#10 +
    ' 1 1 1 1 1 1 1 0 0 0 1 1 1 1 1 0 1 0 0 1 0'#10;
  checkEquals(Sexpected, qrcode('ABCDE123'), 'ABCDE123');

end;

procedure tmdQrCode.test2;
var
  sExpected: string;
begin
  //public void testEncode() throws WriterException {
  //    QRCode qrCode = new QRCode();
  //    Encoder.encode("ABCDEF", ErrorCorrectionLevel.H, qrCode);
  // The following is a valid QR Code that can be read by cell phones.
  Sexpected :=
{      '<<\n' +
      ' mode: ALPHANUMERIC\n' +
      ' ecLevel: H\n' +
      ' version: 1\n' +
      ' matrixWidth: 21\n' +
      ' maskPattern: 0\n' +
      ' numTotalBytes: 26\n' +
      ' numDataBytes: 9\n' +
      ' numECBytes: 17\n' +
      ' numRSBlocks: 1\n' +
      ' matrix:\n' +}
    ' 1 1 1 1 1 1 1 0 1 1 1 1 0 0 1 1 1 1 1 1 1'#10 +
    ' 1 0 0 0 0 0 1 0 0 1 1 1 0 0 1 0 0 0 0 0 1'#10 +
    ' 1 0 1 1 1 0 1 0 0 1 0 1 1 0 1 0 1 1 1 0 1'#10 +
    ' 1 0 1 1 1 0 1 0 1 1 1 0 1 0 1 0 1 1 1 0 1'#10 +
    ' 1 0 1 1 1 0 1 0 0 1 1 1 0 0 1 0 1 1 1 0 1'#10 +
    ' 1 0 0 0 0 0 1 0 0 1 0 0 0 0 1 0 0 0 0 0 1'#10 +
    ' 1 1 1 1 1 1 1 0 1 0 1 0 1 0 1 1 1 1 1 1 1'#10 +
    ' 0 0 0 0 0 0 0 0 0 0 1 0 1 0 0 0 0 0 0 0 0'#10 +
    ' 0 0 1 0 1 1 1 0 1 1 0 0 1 1 0 0 0 1 0 0 1'#10 +
    ' 1 0 1 1 1 0 0 1 0 0 0 1 0 1 0 0 0 0 0 0 0'#10 +
    ' 0 0 1 1 0 0 1 0 1 0 0 0 1 0 1 0 1 0 1 1 0'#10 +
    ' 1 1 0 1 0 1 0 1 1 1 0 1 0 1 0 0 0 0 0 1 0'#10 +
    ' 0 0 1 1 0 1 1 1 1 0 0 0 1 0 1 0 1 1 1 1 0'#10 +
    ' 0 0 0 0 0 0 0 0 1 0 0 1 1 1 0 1 0 1 0 0 0'#10 +
    ' 1 1 1 1 1 1 1 0 0 0 1 0 1 0 1 1 0 0 0 0 1'#10 +
    ' 1 0 0 0 0 0 1 0 1 1 1 1 0 1 0 1 1 1 1 0 1'#10 +
    ' 1 0 1 1 1 0 1 0 1 0 1 1 0 1 0 1 0 0 0 0 1'#10 +
    ' 1 0 1 1 1 0 1 0 0 1 1 0 1 1 1 1 0 1 0 1 0'#10 +
    ' 1 0 1 1 1 0 1 0 1 0 0 0 1 0 1 0 1 1 1 0 1'#10 +
    ' 1 0 0 0 0 0 1 0 0 1 1 0 1 1 0 1 0 0 0 1 1'#10 +
    ' 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 1 0 1 0 1'#10;

  checkEquals(Sexpected, qrcode('ABCDEF'), 'ABCDEF');
end;


procedure tmdQrCode.testGetAlphanumericCode;
// The first ten code points are numbers.
var
  i: integer;
begin
  for i := 0 to 9 do
  begin
    checkEquals(i, tQrCode.AlphanumericCode(char(byte('0') + i)));
  end;

  // The next 26 code points are capital alphabet letters.
  for i := 10 to 35 do
    checkEquals(i, tQrCode.AlphanumericCode(char(Ord('A') + i - 10)), 0, IntToStr(i));


  // Others are symbol letters
  checkEquals(36, tQrCode.AlphanumericCode(' '));
  checkEquals(37, tQrCode.AlphanumericCode('$'));
  checkEquals(38, tQrCode.AlphanumericCode('%'));
  checkEquals(39, tQrCode.AlphanumericCode('*'));
  checkEquals(40, tQrCode.AlphanumericCode('+'));
  checkEquals(41, tQrCode.AlphanumericCode('-'));
  checkEquals(42, tQrCode.AlphanumericCode('.'));
  checkEquals(43, tQrCode.AlphanumericCode('/'));
  checkEquals(44, tQrCode.AlphanumericCode(':'));
  // Should return -1 for other letters;
  checkEquals(-1, tQrCode.AlphanumericCode('a'));
  checkEquals(-1, tQrCode.AlphanumericCode('#'));
  checkEquals(-1, tQrCode.AlphanumericCode(#0));
end;

procedure tmdQrCode.testIMG;
var
  xMatrix: string;
  q: tQrCodeImg;
begin
  xMatrix :=
{      '<<\n' +
      ' mode: ALPHANUMERIC\n' +
      ' ecLevel: H\n' +
      ' version: 1\n' +
      ' matrixWidth: 21\n' +
      ' maskPattern: 0\n' +
      ' numTotalBytes: 26\n' +
      ' numDataBytes: 9\n' +
      ' numECBytes: 17\n' +
      ' numRSBlocks: 1\n' +
      ' matrix:\n' +}
    ' 1 1 1 1 1 1 1 0 1 1 1 1 0 0 1 1 1 1 1 1 1'#10 +
    ' 1 0 0 0 0 0 1 0 0 1 1 1 0 0 1 0 0 0 0 0 1'#10 +
    ' 1 0 1 1 1 0 1 0 0 1 0 1 1 0 1 0 1 1 1 0 1'#10 +
    ' 1 0 1 1 1 0 1 0 1 1 1 0 1 0 1 0 1 1 1 0 1'#10 +
    ' 1 0 1 1 1 0 1 0 0 1 1 1 0 0 1 0 1 1 1 0 1'#10 +
    ' 1 0 0 0 0 0 1 0 0 1 0 0 0 0 1 0 0 0 0 0 1'#10 +
    ' 1 1 1 1 1 1 1 0 1 0 1 0 1 0 1 1 1 1 1 1 1'#10 +
    ' 0 0 0 0 0 0 0 0 0 0 1 0 1 0 0 0 0 0 0 0 0'#10 +
    ' 0 0 1 0 1 1 1 0 1 1 0 0 1 1 0 0 0 1 0 0 1'#10 +
    ' 1 0 1 1 1 0 0 1 0 0 0 1 0 1 0 0 0 0 0 0 0'#10 +
    ' 0 0 1 1 0 0 1 0 1 0 0 0 1 0 1 0 1 0 1 1 0'#10 +
    ' 1 1 0 1 0 1 0 1 1 1 0 1 0 1 0 0 0 0 0 1 0'#10 +
    ' 0 0 1 1 0 1 1 1 1 0 0 0 1 0 1 0 1 1 1 1 0'#10 +
    ' 0 0 0 0 0 0 0 0 1 0 0 1 1 1 0 1 0 1 0 0 0'#10 +
    ' 1 1 1 1 1 1 1 0 0 0 1 0 1 0 1 1 0 0 0 0 1'#10 +
    ' 1 0 0 0 0 0 1 0 1 1 1 1 0 1 0 1 1 1 1 0 1'#10 +
    ' 1 0 1 1 1 0 1 0 1 0 1 1 0 1 0 1 0 0 0 0 1'#10 +
    ' 1 0 1 1 1 0 1 0 0 1 1 0 1 1 1 1 0 1 0 1 0'#10 +
    ' 1 0 1 1 1 0 1 0 1 0 0 0 1 0 1 0 1 1 1 0 1'#10 +
    ' 1 0 0 0 0 0 1 0 0 1 1 0 1 1 0 1 0 0 0 1 1'#10 +
    ' 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 1 0 1 0 1'#10;
  q := tQrCodeImg.Create;
  q.parse(xMatrix);
  checkEquals(q.size, 21);
  zapiszString(q.bmp, 'a.bmp');
  q.Free;

end;


procedure tmdQrCode.testUrl;
var
  ss: string;

begin
  //http://google.com/gwt/n?u=bluenile.com
  ss := qrcode('http://madar.com.pl');
  zapiszString(ss, 'b.qr');
  with tQrCodeImg.Create do
    try
      parse(ss);
      //  checkEquals( q.size,21);
      zapiszString(bmp, 'b.bmp');
      zapiszString(png, 'b.png');
    finally
      Free;
    end;

end;

procedure tmdQrCode.testAppendAlphanumericBytes;
begin
  // A = 10 = 0xa = 001010 in 6 bits
  //      BitArray bits = new BitArray();
  //      s:=.appendAlphanumericBytes("A", bits);
  //      assertEquals(" ..X.X." , bits.toString());

    {
      // AB = 10 * 45 + 11 = 461 = 0x1cd = 00111001101 in 11 bits
      BitArray bits = new BitArray();
      Encoder.appendAlphanumericBytes("AB", bits);
      assertEquals(" ..XXX..X X.X", bits.toString());
    }
    {
      // ABC = "AB" + "C" = 00111001101 + 001100
      BitArray bits = new BitArray();
      Encoder.appendAlphanumericBytes("ABC", bits);
      assertEquals(" ..XXX..X X.X..XX. ." , bits.toString());
    }
    {
      // Empty.
      BitArray bits = new BitArray();
      Encoder.appendAlphanumericBytes("", bits);
      assertEquals("" , bits.toString());
    }
    {
      // Invalid data.
      BitArray bits = new BitArray();
      try {
        Encoder.appendAlphanumericBytes("abc", bits);
      }
  //      catch (WriterException we) {
  // good
  //      }
  //    }
end;



initialization
  testframework.RegisterTest('QRcode unit', tmdQrCode.suite);

end.
