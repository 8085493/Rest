unit UnitDataBase;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, UnitSettingConnection, Vcl.Dialogs, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef;

type
  TDataModule1 = class(TDataModule)
    FDConnection: TFDConnection;
    FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink;
  private
    { Private declarations }
  public
    { Public declarations }
    function Init(ASetting: TSettingConnection): Boolean;
  end;

var
  DataModule1: TDataModule1;

implementation


{$R *.dfm}

function TDataModule1.Init(ASetting: TSettingConnection): Boolean;
begin
  Result := False;
  if (ASetting.IsPathDataBase.Length > 0) then
  begin
    with FDConnection.Params do
    begin
      Clear;
      Add('DriverID=SQLite');
      Add('Database=' + ASetting.IsPathDataBase);
    end;

    if FDConnection.Connected then
    begin
      FDConnection.Connected := false;
    end;

    try
      FDConnection.Connected := true;
      result := true;
    except
      on E: Exception do
        MessageDlg('Ошибка подключения к базе',mtError,[mbOK],1);
    end;
  end;
end;

end.

