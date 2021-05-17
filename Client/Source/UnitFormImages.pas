unit UnitFormImages;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TFormImages = class(TForm)
    Image1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormImages: TFormImages;

implementation

{$R *.dfm}
// procedure TFormImages.SetLoadImages();
//var stream : TMemoryStream;
// Str : string;
//begin
// Str:=ClientModule.GetPhotoUser(15011);
// stream := TMemoryStream.Create;
// //ShowMessage(Str[1]);
// delete(Str,1,2);
// var L := length(Str);
// //Stream.WriteBuffer(L, SizeOf(L));
// stream.Size := Length(Str) div 2;
//    HexToBin(PChar(Str), stream.Memory^, stream.Size);
//   // Image1.Picture.LoadFromStream(stream);
// //Image1.Picture.Graphic:=TJPEGImage.Create;
// Image1.Picture.Graphic.LoadFromStream(stream);
//end;
end.
