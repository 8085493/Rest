unit ServerMethodsUnit;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer,System.Json, Datasnap.DSAuth;

type
{$METHODINFO ON}
  TServerMethods1 = class(TComponent)
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function GetListGroup(values : string): TJSONObject;
    function GetListUser(values : string): TJSONObject;
    function GetPhotoUser(IsIDUser : Integer) : TJSONObject;
  end;
{$METHODINFO OFF}

implementation


uses System.StrUtils,UnitDataBase,UnitSQLDataBase;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.GetListGroup(values: string): TJSONObject;
begin
   Result:= TGroupList.Create(DataModule1.FDConnection).GetInfoGroup(values);
end;

function TServerMethods1.GetListUser(values: string): TJSONObject;
begin
   Result:= TUsetList.Create(DataModule1.FDConnection).GetListUser(values);
end;


function TServerMethods1.GetPhotoUser(IsIDUser: Integer): TJSONObject;
begin
 Result := TUsetList.Create(DataModule1.FDConnection).GetPhotoUser(IsIDUser);
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;
end.

