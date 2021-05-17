unit UnitFormSetting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, UnitSetting, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TFormSetting = class(TForm)
    Label1: TLabel;
    EditServerAdress: TEdit;
    ButtonConnect: TButton;
    procedure ButtonConnectClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSetting: TFormSetting;

implementation

{$R *.dfm}

uses
  UnitMainForm;

procedure TFormSetting.ButtonConnectClick(Sender: TObject);
begin
  ServerSetting := EditServerAdress.Text;
  with TFormMain.Create(Application) do
  begin
    setLoadData();
    self.Hide;
    ShowModal();
    self.Show;
  end;
end;

end.

