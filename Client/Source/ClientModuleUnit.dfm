object ClientModule: TClientModule
  OldCreateOrder = False
  Height = 271
  Width = 415
  object RESTRequest: TRESTRequest
    Client = RESTClient
    Params = <>
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 152
    Top = 8
  end
  object RESTResponse: TRESTResponse
    ContentType = 'application/json; charset="UTF-8"'
    Left = 232
    Top = 120
  end
  object RESTClient: TRESTClient
    Params = <>
    Left = 232
    Top = 72
  end
end
