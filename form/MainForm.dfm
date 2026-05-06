object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object ShowNotification: TButton
    Left = 208
    Top = 320
    Width = 209
    Height = 25
    Caption = 'ShowNotification'
    TabOrder = 0
    OnClick = ShowNotificationClick
  end
  object NotificationCenterTest: TNotificationCenter
    Left = 8
    Top = 8
  end
  object TrayIcon1: TTrayIcon
    PopupMenu = PopupMenu1
    OnDblClick = TrayIcon1DblClick
    Left = 120
    Top = 8
  end
  object PopupMenu1: TPopupMenu
    Left = 200
    Top = 8
    object ReOpen: TMenuItem
      Caption = #36824#21407
      OnClick = ReOpenClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object TestItem: TMenuItem
      Caption = #27979#35797#29992#20363
      OnClick = TestItemClick
    end
    object Exit: TMenuItem
      Caption = #36864#20986
      OnClick = ExitClick
    end
  end
  object Timer1: TTimer
    Interval = 3600000
    OnTimer = Timer1Timer
    Left = 288
    Top = 8
  end
end
