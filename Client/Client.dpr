program Client;

uses
  Vcl.Forms,
  UnitMainForm in 'Source\UnitMainForm.pas' {FormMain},
  ClientModuleUnit in 'Source\ClientModuleUnit.pas' {ClientModule: TDataModule},
  Vcl.Themes,
  Vcl.Styles,
  UnitFormSetting in 'Source\UnitFormSetting.pas' {FormSetting},
  UnitSetting in 'Source\UnitSetting.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Light');
  Application.CreateForm(TFormSetting, FormSetting);
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TClientModule, ClientModule);
  Application.Run;
end.
