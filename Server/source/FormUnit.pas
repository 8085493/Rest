unit FormUnit;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants, System.Classes, UnitSQLDataBase,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitSettingConnection,
  Vcl.AppEvnts, Vcl.StdCtrls, IdHTTPWebBrokerBridge, Web.HTTPApp, Vcl.ExtCtrls;

type
  TFormMain = class(TForm)
    ButtonStart: TButton;
    ButtonStop: TButton;
    EditPort: TEdit;
    Label1: TLabel;
    ApplicationEvents1: TApplicationEvents;
    OpenDialog: TOpenDialog;
    PanelButton: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    ButtonSetting: TButton;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure ButtonOpenBrowserClick(Sender: TObject);
    procedure ButtonSettingClick(Sender: TObject);
  private
    FServer: TIdHTTPWebBrokerBridge;
    procedure StartServer;
    procedure StopServer;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses
  WinApi.Windows, Winapi.ShellApi, Datasnap.DSSession, UnitDataBase;

procedure TFormMain.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  ButtonStart.Enabled := not FServer.Active;
  ButtonStop.Enabled := FServer.Active;
  EditPort.Enabled := not FServer.Active;
end;

procedure TFormMain.ButtonOpenBrowserClick(Sender: TObject);
var
  LURL: string;
begin
  StartServer;
  LURL := Format('http://localhost:%s', [EditPort.Text]);
  ShellExecute(0, nil, PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure TFormMain.ButtonSettingClick(Sender: TObject);
  var ASetting : TSettingConnection;
begin
  StopServer;
  if OpenDialog.Execute then
  begin
    ASetting := TSettingConnection.Create();
    ASetting.IsPathDataBase := OpenDialog.FileName;
    PanelButton.Visible := False;
    if DataModule1.Init(ASetting) then
      begin
        PanelButton.Visible := True;
        ASetting.SetSaveSetting;
      end
    else
      PanelButton.Visible := False;
  end;

end;

procedure TFormMain.ButtonStartClick(Sender: TObject);
begin
  StartServer;
end;

procedure TerminateThreads;
begin
  if TDSSessionManager.Instance <> nil then
    TDSSessionManager.Instance.TerminateAllSessions;
end;

procedure TFormMain.ButtonStopClick(Sender: TObject);
begin
  StopServer;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FServer := TIdHTTPWebBrokerBridge.Create(Self);
  if DataModule1.Init(TSettingConnection.Create) then
    PanelButton.Visible := True
  else
    PanelButton.Visible := False;
end;

procedure TFormMain.StartServer;
begin
  if not FServer.Active then
  begin
    FServer.Bindings.Clear;
    FServer.DefaultPort := StrToInt(EditPort.Text);
    FServer.Active := True;
  end;
end;

procedure TFormMain.StopServer;
begin
  TerminateThreads;
  FServer.Active := False;
  FServer.Bindings.Clear;
end;

end.

