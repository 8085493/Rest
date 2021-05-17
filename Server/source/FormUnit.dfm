object FormMain: TFormMain
  Left = 271
  Top = 114
  BorderStyle = bsSizeToolWin
  Caption = #1057#1077#1088#1074#1077#1088
  ClientHeight = 341
  ClientWidth = 325
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Trebuchet MS'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 18
  object Label2: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 194
    Width = 319
    Height = 144
    Align = alBottom
    Caption = 
      #1053#1072' '#1089#1083#1091#1095#1072#1081' '#1077#1089#1083#1080' '#1082#1090#1086' '#1090#1086' '#1079#1072#1087#1091#1089#1090#1080#1090'! '#13#10#1058#1072#1082' '#1089#1083#1086#1078#1080#1083#1086#1089#1100', '#1095#1090#1086' MsSQL '#1089#1077#1088#1074#1077 +
      #1088#1072' '#1091' '#1084#1077#1085#1103' '#1085#1077#1090', '#1072' '#1080#1089#1087#1086#1083#1100#1079#1091#1103' PgSql '#1074#1086#1079#1084#1086#1078#1085#1086' '#1042#1099' '#1089#1090#1086#1083#1082#1085#1091#1083#1080#1089#1100' '#1073#1099' '#1089' '#1090#1072 +
      #1082#1086#1081' '#1078#1077' '#1087#1088#1086#1073#1083#1077#1084#1086#1081'. '#1047#1072' '#1086#1089#1085#1086#1074#1091' '#1103' '#1074#1079#1103#1083' SQLite, '#1084#1086#1078#1077#1090' '#1080' '#1085#1077' '#1083#1091#1095#1096#1080#1081' '#1074#1099#1073 +
      #1086#1088' '#1085#1086' '#1079#1072#1090#1086' '#1073#1091#1076#1077#1090' '#1088#1072#1073#1086#1090#1072#1090#1100'.'#13#10#1044#1072#1085#1085#1099#1077' '#1080#1079' '#1092#1072#1081#1083#1072' User.sql '#1103' '#1087#1077#1088#1077#1085#1077#1089' '#1074 +
      ' SQLite, '#1073#1072#1079#1072' '#1083#1077#1078#1080#1090' '#1074' '#1082#1086#1088#1085#1077' '#1089' exe '#13#10
    WordWrap = True
    ExplicitTop = 204
    ExplicitWidth = 311
  end
  object PanelButton: TPanel
    Left = 0
    Top = 0
    Width = 325
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 233
    object ButtonStart: TButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 166
      Height = 35
      Align = alLeft
      Caption = #1047#1040#1055#1059#1057#1058#1048#1058#1068
      Enabled = False
      TabOrder = 0
      OnClick = ButtonStartClick
    end
    object ButtonStop: TButton
      AlignWithMargins = True
      Left = 175
      Top = 3
      Width = 147
      Height = 35
      Align = alClient
      Caption = #1054#1057#1058#1040#1053#1054#1042#1048#1058#1068
      TabOrder = 1
      OnClick = ButtonStopClick
      ExplicitLeft = 105
      ExplicitTop = 8
      ExplicitWidth = 75
      ExplicitHeight = 25
    end
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 44
    Width = 319
    Height = 82
    Align = alTop
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1089#1077#1088#1074#1077#1088#1072
    TabOrder = 1
    ExplicitLeft = 8
    ExplicitTop = 55
    ExplicitWidth = 185
    object Label1: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 23
      Width = 28
      Height = 18
      Align = alTop
      Caption = #1055#1086#1088#1090
    end
    object EditPort: TEdit
      Left = 2
      Top = 44
      Width = 315
      Height = 26
      Align = alTop
      TabOrder = 0
      Text = '8081'
      ExplicitLeft = 104
      ExplicitTop = 63
      ExplicitWidth = 121
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 132
    Width = 319
    Height = 62
    Align = alTop
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
    TabOrder = 2
    ExplicitLeft = 8
    ExplicitTop = 131
    ExplicitWidth = 185
    object ButtonSetting: TButton
      AlignWithMargins = True
      Left = 5
      Top = 23
      Width = 309
      Height = 25
      Align = alTop
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1092#1072#1081#1083
      TabOrder = 0
      OnClick = ButtonSettingClick
      ExplicitLeft = 24
      ExplicitTop = 80
      ExplicitWidth = 107
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 376
    Top = 312
  end
  object OpenDialog: TOpenDialog
    Filter = 'Sqllite|*.db'
    Left = 368
    Top = 192
  end
end
