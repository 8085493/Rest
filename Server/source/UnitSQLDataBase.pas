unit UnitSQLDataBase;

interface
uses   BaseClass,   System.JSON,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

 type
  TGroupList= class(TBaseSQL)
     constructor Create(AConnection : TFDConnection);
     function GetInfoGroup(ValuesSearch : string) : TJSONObject;
  end;

  TUsetList= class(TBaseSQL)
     constructor Create(AConnection : TFDConnection);
     function GetListUser(ValuesSearch : string) : TJSONObject;
     function GetPhotoUser(IsIDUser : Integer) : TJSONObject;
  end;



implementation

{ TGroupList }

constructor TGroupList.Create(AConnection: TFDConnection);
begin
 inherited  Create(AConnection);
end;

function TGroupList.GetInfoGroup(ValuesSearch : string): TJSONObject;
var
  JSONObj : TJSONObject;
  ListResult : TList;
begin
  SQLactivity(
  'SELECT * FROM ('+
  'SELECT GroupList.GroupID, DisplayName,ifnull(CountUser,0) AS CountUser,ifnull(CountGroup,0) AS CountGroup,Parent.ParentID FROM GroupList '+
  'LEFT JOIN (SELECT COUNT(UserID) AS CountUser, GroupID FROM "UserTree" GROUP BY GroupID) CUser ON(CUser.GroupID=GroupList.GroupID) '+
  'LEFT JOIN (SELECT ParentID, COUNT(GroupID) AS CountGroup FROM "GroupTree" WHERE ParentID>0 GROUP BY ParentID) CGroup ON(CGroup.ParentID=GroupList.GroupID)'+
  'LEFT JOIN (SELECT * FROM GroupTree) Parent ON(Parent.GroupID=GroupList.GroupID)'+
  ')ResultTable WHERE DisplayName LIKE ''%'+LowerCase(ValuesSearch)+'%'' ORDER BY ParentID'
  );
  Result:=GetJsonQuery('GroupInfo');
end;

{ TUsetList }

constructor TUsetList.Create(AConnection: TFDConnection);
  begin
    inherited Create(AConnection);
  end;

function TUsetList.GetListUser(ValuesSearch: string): TJSONObject;
  begin
    SQLactivity('SELECT UserList.UserID,DisplayName,AccountEnabled,Phone,Address,Note,GroupID FROM UserList LEFT JOIN UserTree ON(UserTree.UserID=UserList.UserID)'+
    'WHERE DisplayName LIKE ''%'+ValuesSearch+'%'' OR  Address LIKE ''%'+ValuesSearch+'%'' OR  Phone LIKE ''%'+ValuesSearch+'%'' ' +
    ' ORDER BY GroupID');
    Result:=GetJsonQuery('ListUser');
  end;

function TUsetList.GetPhotoUser(IsIDUser: Integer): TJSONObject;
begin
  SQLactivity('SELECT Photo FROM UserList WHERE UserID IN('+IsIDUser.ToString+')');
  Result:=GetJsonQuery('Photo');
end;

end.
