unit UnitSettingConnection;

interface

uses
  System.IniFiles, System.SysUtils;

type
  TSettingConnection = class(TIniFile)
  public
    var
      IsPathDataBase: string;
  public
    constructor Create();
    procedure SetLoadSetting();
    procedure SetSaveSetting();
  end;

implementation


{ TSettingConnection }

constructor TSettingConnection.Create;
begin
  inherited Create(ExtractFilePath(ParamStr(0)) + 'Setting.ini');
  SetLoadSetting();
end;

procedure TSettingConnection.SetLoadSetting;
begin
  IsPathDataBase := ReadString('SETTING', 'PathDataBase', '');
end;

procedure TSettingConnection.SetSaveSetting;
begin
  WriteString('SETTING', 'PathDataBase', IsPathDataBase);
end;

end.

