object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 205
  Width = 344
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 96
    Top = 64
  end
  object FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink
    Left = 192
    Top = 64
  end
end
