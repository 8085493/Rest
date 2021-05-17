unit ClientModuleUnit;

interface

uses
  System.SysUtils, System.Classes, System.JSON, Datasnap.DSClientRest, Dialogs,
  UnitSetting, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope;

type
  TClientModule = class(TDataModule)
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    RESTClient: TRESTClient;
  private
    FInstanceOwner: Boolean;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    function GetGroupInfo(values: string): TJSONArray;
    function GetListUser(values: string): TJSONArray;
    function GetPhotoUser(IsIduser: Integer): string;
  end;

var
  ClientModule: TClientModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

constructor TClientModule.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

destructor TClientModule.Destroy;
begin

end;

function TClientModule.GetGroupInfo(values: string): TJSONArray;
begin

  RESTClient.BaseURL := ServerSetting;
  RESTRequest.Resource := 'datasnap/rest/TServerMethods1/GetListGroup/' + values;
  RESTRequest.Method := TRESTRequestMethod.rmGET;
  RESTRequest.Response := RESTResponse;
  try
    RESTRequest.Execute;
    if RESTRequest.Response.StatusCode = 200 then
    begin
      var fJSONObj := TJSonObject.ParseJSONValue(RESTResponse.Content) as TJSONObject;
      var fJSONArray := fJSONObj.GetValue('result') as TJSONArray;
      var fJSONObj1 := fJSONArray.Items[0] as TJSONObject;
      var fJSONArrayRecive := fJSONObj1.GetValue('GroupInfo') as TJSONArray;
      Result := fJSONArrayRecive;
    end;
  finally

  end;
end;

function TClientModule.GetListUser(values: string): TJSONArray;
begin
  RESTClient.BaseURL := ServerSetting;
  RESTRequest.Resource := 'datasnap/rest/TServerMethods1/GetListUser/' + values;
  RESTRequest.Method := TRESTRequestMethod.rmGET;
  RESTRequest.Response := RESTResponse;
  try
    RESTRequest.Execute;
    if RESTRequest.Response.StatusCode = 200 then
    begin
      var fJSONObj := TJSonObject.ParseJSONValue(RESTResponse.Content) as TJSONObject;
      var fJSONArray := fJSONObj.GetValue('result') as TJSONArray;
      var fJSONObj1 := fJSONArray.Items[0] as TJSONObject;
      var fJSONArrayRecive := fJSONObj1.GetValue('ListUser') as TJSONArray;
      Result := fJSONArrayRecive;
    end;
  finally

  end;
end;

function TClientModule.GetPhotoUser(IsIduser: Integer): string;
begin

  RESTClient.BaseURL := ServerSetting;
  RESTRequest.Resource := 'datasnap/rest/TServerMethods1/GetPhotoUser/' + IsIduser.ToString;
  RESTRequest.Method := TRESTRequestMethod.rmGET;
  RESTRequest.Response := RESTResponse;
  try
    RESTRequest.Execute;
    if RESTRequest.Response.StatusCode = 200 then
    begin
      RESTRequest.Execute;
      if RESTRequest.Response.StatusCode = 200 then
      begin
        var fJSONObj := TJSonObject.ParseJSONValue(RESTResponse.Content) as TJSONObject;
        var fJSONArray := fJSONObj.GetValue('result') as TJSONArray;
        var fJSONObj1 := fJSONArray.Items[0] as TJSONObject;
        var fJSONArrayRecive := fJSONObj1.GetValue('Photo') as TJSONArray;
        var AOrders := fJSONArrayRecive.Items[0] as TJSONObject;
        Result := AOrders.GetValue('Photo').Value;
      end;
    end;
  finally

  end;
end;

end.

