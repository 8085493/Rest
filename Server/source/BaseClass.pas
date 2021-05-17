unit BaseClass;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, Data.DBXJSONCommon,System.JSON,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TBaseSQL = class
    constructor Create(connection: TFDConnection);
    procedure SQLexecute(SQLtext: string);
    procedure SQLactivity(SQLtext: string);
    function GetValuesFieldString(fieldname: string): string;
    function GetValuesFieldBoolean(fieldname: string): Boolean;
    function GetValuesFieldInt(fieldname: string): Integer;
    function GetValuesFieldDouble(fieldname: string): Double;
    function GetDataSource: TDataSource;
    function EOF: Boolean;
    function RecordCount: Integer;
    procedure MoveNext;
    procedure setValues(field, values: string);
    procedure loadFromFile(filepath: string);
    procedure First;
  private
    function GetJsonRecord: TJSONObject;
    function GetJsonAllRecord: TJSONArray;
  protected
    Query: TFDQuery;
    DataSource: TDataSource;
    connectionBC: TFDConnection;
    function StrToBollMy(values: string): Boolean;
    function GetConnection: TFDConnection;
    function GetJsonQuery(IsNameArray : string): TJSONObject;

  end;

implementation

constructor TBaseSQL.Create(connection: TFDConnection);
begin
  Query := TFDQuery.Create(Application);
  Query.Connection := connection;
  DataSource := TDataSource.Create(Application);
  DataSource.DataSet := Query;
  connectionBC := connection;
end;

procedure TBaseSQL.SQLexecute(SQLtext: string);
begin
  try
    Query.SQL.Clear;
    Query.SQL.Text := SQLtext;
    Query.ExecSQL;

  except
    on e: Exception do
      ShowMessage(e.Message + ' ЗАПРОС ' + SQLtext);
  end;
end;

procedure TBaseSQL.SQLactivity(SQLtext: string);
begin
  try
    Query.SQL.Clear;
    Query.SQL.Text := SQLtext;
    Query.Active := True;
  except
    on e: exception do
      ShowMessage(e.Message + ' ЗАПРОС ' + SQLtext);
  end;
end;

function TBaseSQL.getValuesFieldString(fieldname: string): string;
begin
  try
    Result := Query.FieldByName(fieldname).AsString;
  except
    on e: Exception do
      Result := '';
  end;
end;

function TBaseSQL.getValuesFieldBoolean(fieldname: string): Boolean;
begin
  Result := Query.FieldByName(fieldname).AsBoolean;
end;

function TBaseSQL.getValuesFieldInt(fieldname: string): Integer;
begin
  Result := Query.FieldByName(fieldname).AsInteger;
end;

function TBaseSQL.getValuesFieldDouble(fieldname: string): Double;
begin
  Result := Query.FieldByName(fieldname).AsFloat;
end;

function TBaseSQL.getDataSource: TDataSource;
begin
  Result := DataSource;
end;

function TBaseSQL.GetJsonRecord : TJSONObject;
var
 i : Integer;
begin
  Result:=TJSONObject.Create;
    for I :=0 to Query.FieldCount-1  do
    begin
      Result.AddPair(Query.Fields[i].FieldName,GetValuesFieldString(Query.Fields[i].FieldName));
    end;

end;

function TBaseSQL.GetJsonAllRecord(): TJSONArray;
begin
 result := TJSONArray.Create;
  while not EOF do
  begin
    result.AddElement(GetJsonRecord);
    MoveNext;
  end;
end;


function TBaseSQL.GetJsonQuery(IsNameArray: string): TJSONObject;
begin
  result := TJSONObject.Create;
  result.AddPair(IsNameArray,GetJsonAllRecord());
end;

function TBaseSQL.EOF: Boolean;
begin
  Result := Query.Eof
end;

function TBaseSQL.RecordCount: Integer;
begin
  Result := Query.RecordCount;
end;

procedure TBaseSQL.MoveNext;
begin
  Query.Next;
end;

procedure TBaseSQL.setValues(field: string; values: string);
begin
  try
    Query.Edit;
    Query.FieldByName(field).AsString := values;
    Query.Post
  except
    on e: Exception do
      ShowMessage('Не верный тип данных');
  end;
end;

function TBaseSQL.StrToBollMy(values: string): Boolean;
begin
  try
    if StrToInt(values) > 0 then
      Result := True
    else
      Result := False;
  except
    on e: Exception do
      ShowMessage(e.Message);
  end;
end;


function TBaseSQL.getConnection: TFDConnection;
begin
  Result := connectionBC;
end;

procedure TBaseSQL.loadFromFile(filepath: string);
begin
  Query.SQL.LoadFromFile(filepath);
  Query.ExecSQL;
end;

procedure TBaseSQL.First;
begin
  Query.First;
end;

end.

