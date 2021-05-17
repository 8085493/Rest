program Server;
{$APPTYPE GUI}

{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  Windows,
  FormUnit in 'source\FormUnit.pas' {FormMain},
  ServerMethodsUnit in 'source\ServerMethodsUnit.pas',
  WebModuleUnit in 'source\WebModuleUnit.pas' {WebModule1: TWebModule},
  Vcl.Themes,
  Vcl.Styles,
  UnitDataBase in 'source\UnitDataBase.pas' {DataModule1: TDataModule},
  UnitSettingConnection in 'source\UnitSettingConnection.pas',
  BaseClass in 'source\BaseClass.pas',
  UnitSQLDataBase in 'source\UnitSQLDataBase.pas';

{$R *.res}
 const
  APP_MUTEX_NAME = 'Server';
 var
  hMutex, rtMutex: longword;
begin
    hMutex := CreateMutex(nil, false, APP_MUTEX_NAME);
  rtMutex := 0;
  try
    rtMutex := GetLastError;
    ReleaseMutex(hMutex);
  finally
    if rtMutex = ERROR_ALREADY_EXISTS then
    begin
      Application.Terminate; // kill the application
    end;
  end;


  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  TStyleManager.TrySetStyle('Light');
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
