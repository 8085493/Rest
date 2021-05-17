unit UnitModelGroupList;

interface

type
  TGroupListItem = class
  const
    fGroupID = 'GroupID';
    fDisplayName='DisplayName';
    fCountUser='CountUser';
    fCountGroup='CountGroup';

  private
    GroupID: Integer;
    DisplayName: string;
    CountUser: Integer;
    CountGroup: Integer;
  public
    property IsGroupID: Integer read GroupID write GroupID;
    property IsDisplayName: string read DisplayName write DisplayName;
    property IsCountUser: Integer read CountUser write CountUser;
    property IsCountGroup: Integer read CountGroup write CountGroup;
    constructor Create(GroupID: Integer; DisplayName: string;CountUser,CountGroup : Integer); overload;
    constructor Create(); overload;
  end;

implementation

constructor TGroupListItem.Create(GroupID: Integer; DisplayName: string;CountUser,CountGroup : Integer);
begin
  Self.GroupID := GroupID;
  Self.DisplayName := DisplayName;
  Self.CountUser:=CountUser;
  self.CountGroup:=CountGroup;
end;

constructor TGroupListItem.Create;
begin

end;

end.

