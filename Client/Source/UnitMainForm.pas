unit UnitMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, FireDAC.Stan.Intf, System.JSON, FireDAC.Stan.Option, JPEG,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ComCtrls, Vcl.ExtCtrls, dxGDIPlusClasses, acPNG;

type
  TFormMain = class(TForm)
    FDMemTableGroup: TFDMemTable;
    DataSourceUser: TDataSource;
    TreeView1: TTreeView;
    FDMemTableUser: TFDMemTable;
    DBGrid1: TDBGrid;
    Image1: TImage;
    Panel1: TPanel;
    Panel2: TPanel;
    EditSearchGroup: TEdit;
    Label1: TLabel;
    Panel3: TPanel;
    Label2: TLabel;
    EditSearchUser: TEdit;
    Panel4: TPanel;
    procedure TreeView1Changing(Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
    procedure Button2Click(Sender: TObject);
    procedure DataSourceUserDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure EditSearchGroupKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditSearchUserKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    isLoadImages: Boolean;
    procedure SetLoadGroup;
    procedure SetLoadUser;
    procedure SetLoadImages(IdUser: integer);
    procedure SetLoadGroupServer(Filter: string = '');
    procedure SetLoadUserServer(Filter: string = '');
    procedure CreateParams(var Params: TCreateParams); override;
    { Private declarations }
  public
    { Public declarations }
    procedure setLoadData();
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses
  ClientModuleUnit;

procedure TFormMain.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);

  with Params do
    ExStyle := ExStyle or WS_EX_APPWINDOW;
  Position := poScreenCenter;
  Constraints.MinWidth := Width;
  Constraints.MinHeight := Height;
end;

procedure TFormMain.Button2Click(Sender: TObject);
var
  stream: TMemoryStream;
  Str: string;
begin
  Str := ClientModule.GetPhotoUser(15011);
  stream := TMemoryStream.Create;
  delete(Str, 1, 2);
  var L := length(Str);
  stream.Size := Length(Str) div 2;
  HexToBin(PChar(Str), stream.Memory^, stream.Size);
  Image1.Picture.Graphic.LoadFromStream(stream);
end;

procedure TFormMain.SetLoadImages(IdUser: integer);
var
  stream: TMemoryStream;
  Str: string;
begin
  try
    Str := ClientModule.GetPhotoUser(IdUser);
    stream := TMemoryStream.Create;
    delete(Str, 1, 2);
    var L := length(Str);
    stream.Size := Length(Str) div 2;
    HexToBin(PChar(Str), stream.Memory^, stream.Size);
    Image1.Picture.Graphic := TJPEGImage.Create;
    Image1.Picture.Graphic.LoadFromStream(stream);
  except
    on E: Exception do


  end;

end;

procedure TFormMain.DataSourceUserDataChange(Sender: TObject; Field: TField);
begin
  if isLoadImages then
    if FDMemTableUser.RecordCount > 0 then
      SetLoadImages(FDMemTableUser.FieldByName('UserID').AsInteger)
    else
      Image1.Picture.LoadFromFile('default.png');
end;

procedure TFormMain.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if FDMemTableUser.FieldByName('AccountEnabled').AsInteger = 0 then
  begin
    TDBGrid(Sender).Canvas.Brush.Color :=clGray;
    TDBGrid(Sender).Canvas.Font.Color := clWhite;
  end;
  TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFormMain.EditSearchGroupKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    SetLoadGroupServer(EditSearchGroup.Text);
    SetLoadGroup();
    SetLoadUser();
  end;
end;

procedure TFormMain.EditSearchUserKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    { TODO : Из за того что sqlite и like не очень дружат фильтр делаю локалный. }
    FDMemTableUser.Filtered := False;
    FDMemTableUser.Filter := 'lower(DisplayName) LIKE ''%' + LowerCase(EditSearchUser.Text) + '%''';
    FDMemTableUser.Filtered := True;
  end;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  isLoadImages := False;
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TFormMain.SetLoadUserServer(Filter: string = '');
var
  AOrders: TJsonArray;
begin
  AOrders := ClientModule.GetListUser(Filter);
  FDMemTableUser.EmptyDataSet;
  for var i := 0 to AOrders.Count - 1 do
  begin
    var fJSONObj := AOrders.Items[I] as TJSONObject;
    with FDMemTableUser do
    begin
      Insert;
      Fields[0].AsInteger := StrToInt(fJSONObj.GetValue('UserID').Value);
      Fields[1].AsString := fJSONObj.GetValue('DisplayName').Value;
      Fields[2].AsInteger := StrToInt(fJSONObj.GetValue('AccountEnabled').Value);
      Fields[3].AsString := (fJSONObj.GetValue('Phone').Value);
      Fields[4].AsString := (fJSONObj.GetValue('Address').Value);
      Fields[5].AsString := (fJSONObj.GetValue('Note').Value);
      Fields[6].AsInteger := StrToInt(fJSONObj.GetValue('GroupID').Value);
      Post;
    end;
  end;
  FDMemTableUser.First;
end;

procedure TFormMain.SetLoadGroupServer(Filter: string = '');
var
  AOrders: TJsonArray;
begin
  AOrders := ClientModule.GetGroupInfo(Filter);
  FDMemTableGroup.EmptyDataSet;
  for var i := 0 to AOrders.Count - 1 do
  begin
    var fJSONObj := AOrders.Items[I] as TJSONObject;
    with FDMemTableGroup do
    begin
      Insert;
      Fields[0].AsInteger := StrToInt(fJSONObj.GetValue('GroupID').Value);
      Fields[1].AsString := fJSONObj.GetValue('DisplayName').Value;
      Fields[2].AsInteger := StrToInt(fJSONObj.GetValue('CountUser').Value);
      Fields[3].AsInteger := StrToInt(fJSONObj.GetValue('CountGroup').Value);
      Fields[4].AsInteger := StrToInt(fJSONObj.GetValue('ParentID').Value);
      Post;
    end;
  end;
  FDMemTableGroup.First;
end;

procedure TFormMain.setLoadData;
begin
  SetLoadGroupServer();
  SetLoadGroup();

  SetLoadUserServer();
  SetLoadUser();

  isLoadImages := True;
end;

procedure TFormMain.SetLoadGroup();
var
  Node: TTreeNode;
  CountSearch: Integer;
const
  GroupName = '%s (Group: %s) (User %s)';
begin
  TreeView1.Items.Clear;
  while not FDMemTableGroup.Eof do
  begin
    var Title := Format(GroupName, [FDMemTableGroup.FieldByName('DisplayName').AsString, FDMemTableGroup.FieldByName('CountGroup').AsString, FDMemTableGroup.FieldByName('CountUser').AsString]);
    CountSearch := 0;

    for var i := 0 to TreeView1.Items.Count - 1 do
    begin
      if TreeView1.Items[i].ImageIndex = FDMemTableGroup.FieldByName('ParentID').AsInteger then
      begin
        Node := TreeView1.Items.AddChildFirst(TreeView1.Items[i], Title);
        Node.ImageIndex := FDMemTableGroup.FieldByName('GroupID').AsInteger;
        inc(CountSearch);
        Break;
      end;
    end;
    if CountSearch = 0 then
    begin
      Node := TreeView1.Items.Add(nil, Title);
      Node.ImageIndex := FDMemTableGroup.FieldByName('GroupID').AsInteger;
    end;

    FDMemTableGroup.Next;
  end;
end;

procedure TFormMain.SetLoadUser();
var
  Node: TTreeNode;
begin
  Node := TreeView1.Selected;
  if Node <> nil then
  begin
    FDMemTableUser.Filter := 'GroupID=' + intTostr(Node.ImageIndex);
    FDMemTableUser.Filtered := True;
  end
  else
  begin
    FDMemTableUser.Filter := 'GroupID=0';
    FDMemTableUser.Filtered := True;
  end;

end;

procedure TFormMain.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  SetLoadUser();
end;

procedure TFormMain.TreeView1Changing(Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
begin
  SetLoadUser();
end;

end.

