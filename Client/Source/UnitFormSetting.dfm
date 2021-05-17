object FormSetting: TFormSetting
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1089#1077#1088#1074#1077#1088#1072
  ClientHeight = 126
  ClientWidth = 380
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Trebuchet MS'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 20
  object Label1: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 22
    Width = 374
    Height = 20
    Align = alBottom
    Caption = #1057#1077#1088#1074#1077#1088' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
    ExplicitLeft = -2
    ExplicitTop = 53
  end
  object EditServerAdress: TEdit
    AlignWithMargins = True
    Left = 3
    Top = 48
    Width = 374
    Height = 28
    Align = alBottom
    TabOrder = 0
    Text = 'http://localhost:8081'
    ExplicitLeft = -2
    ExplicitTop = 79
  end
  object ButtonConnect: TButton
    AlignWithMargins = True
    Left = 90
    Top = 82
    Width = 200
    Height = 41
    Margins.Left = 90
    Margins.Right = 90
    Align = alBottom
    Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100#1089#1103
    TabOrder = 1
    OnClick = ButtonConnectClick
    ExplicitLeft = -2
    ExplicitTop = 113
    ExplicitWidth = 374
  end
end
