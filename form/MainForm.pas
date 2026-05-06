unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Notification,
  Vcl.ExtCtrls, Vcl.Menus;

type
  TForm1 = class(TForm)
    NotificationCenterTest: TNotificationCenter;
    ShowNotification: TButton;
    TrayIcon1: TTrayIcon;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    ReOpen: TMenuItem;
    Exit: TMenuItem;
    TestItem: TMenuItem;
    Timer1: TTimer;
    procedure ShowNotificationClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ShowMinimizedNotification();
    procedure NotificationReceived(Sender: TObject; ANotification: TNotification);
    procedure FormCreate(Sender: TObject);
    procedure Restore1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure ExitClick(Sender: TObject);
    procedure ReOpenClick(Sender: TObject);
    procedure TestItemClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    TestTimes:Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // 拦截关闭操作，改为最小化到系统托盘
  Action := caNone;

    // 显示气球提示（可选）
//  TrayIcon1.BalloonTitle := '应用程序仍在运行';
//  TrayIcon1.BalloonHint := '程序已最小化到系统托盘。双击图标可恢复窗口。';
//  TrayIcon1.ShowBalloonHint;

  // 隐藏主窗体（可选，根据需求决定）
  Hide;//Show


  // 如果需要，可以在这里显示一个通知
//  ShowMinimizedNotification;
end;

// 首先在窗体创建时设置事件处理
procedure TForm1.FormCreate(Sender: TObject);
begin
//  // 确保应用程序在任务栏中有图标
//  ShowWindow(Application.Handle, SW_SHOW);
//  SetWindowLong(Application.Handle, GWL_EXSTYLE,
//                GetWindowLong(Application.Handle, GWL_EXSTYLE) and not WS_EX_TOOLWINDOW);

  // 初始化托盘图标
  TrayIcon1.Icon := Application.Icon;
  TrayIcon1.Hint := '我的应用程序';
  TrayIcon1.Visible := True; //显示系统图标

  NotificationCenterTest.OnReceiveLocalNotification := NotificationReceived;
  TestTimes := 0;
end;

// 然后实现通知接收处理
procedure TForm1.NotificationReceived(Sender: TObject; ANotification: TNotification);
begin
  if ANotification.Name = 'AppMinimized' then
  begin
//    // 恢复窗口
//    Show;
//    WindowState := wsNormal;
//    BringToFront;
    // 恢复窗口
    TrayIcon1DblClick(Sender);
  end;
end;

procedure TForm1.ShowMinimizedNotification;
var
  MyNotification: TNotification;
begin
  MyNotification := NotificationCenterTest.CreateNotification;
  try
    MyNotification.Name := 'AppMinimized';
    MyNotification.Title := '应用程序仍在运行';
    MyNotification.AlertBody := '程序已最小化到任务栏。点击此通知可恢复窗口。';
    MyNotification.EnableSound := True;

    NotificationCenterTest.PresentNotification(MyNotification);
  finally
    MyNotification.DisposeOf;
  end;
end;

procedure TForm1.ShowNotificationClick(Sender: TObject);
var
  MyNotification: TNotification;
begin
  // 通过通知中心创建一条通知
  MyNotification := NotificationCenterTest.CreateNotification;
  try
    MyNotification.Name := 'MyInstantNotification'; // 给通知一个名称
    MyNotification.Title := '提示'; // 通知标题（可选）
    MyNotification.AlertBody := '这是一条立即显示的通知消息！'; // 通知正文
    MyNotification.EnableSound := True; // 启用声音（可选）
    // MyNotification.Number := 5; // 设置角标数字（可选）

    // 立即呈现通知
    NotificationCenterTest.PresentNotification(MyNotification);
  finally
    MyNotification.DisposeOf; // 在 Delphi 中释放对象资源
  end;
end;

procedure TForm1.TestItemClick(Sender: TObject);
var
  MyNotification: TNotification;
begin
  Inc(TestTimes);
  // 通过通知中心创建一条通知
  MyNotification := NotificationCenterTest.CreateNotification;
  try
    MyNotification.Name := 'MyInstantNotificationName'; // 给通知一个名称
    MyNotification.Title := '提示'; // 通知标题（可选）
    MyNotification.AlertBody := format('这是一条立即显示的通知消息！%d',[TestTimes + 114514]); // 通知正文
    MyNotification.EnableSound := True; // 启用声音（可选）
    MyNotification.Number := TestTimes; // 设置角标数字（可选）

    // 立即呈现通知
    NotificationCenterTest.PresentNotification(MyNotification);
  finally
    MyNotification.DisposeOf; // 在 Delphi 中释放对象资源
  end;

  Timer1Timer(Sender);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  MyNotification: TNotification;
begin
  // 通过通知中心创建一条通知
  MyNotification := NotificationCenterTest.CreateNotification;
  try
    MyNotification.Name := '提醒'; // 给通知一个名称
    MyNotification.Title := '该歇会了'; // 通知标题（可选）
    MyNotification.AlertBody := '多喝热水'; // 通知正文
    MyNotification.EnableSound := True; // 启用声音（可选）
     MyNotification.Number := 114514; // 设置角标数字（可选）

    // 立即呈现通知
    NotificationCenterTest.PresentNotification(MyNotification);
  finally
    MyNotification.DisposeOf; // 在 Delphi 中释放对象资源
  end;
end;

procedure TForm1.TrayIcon1DblClick(Sender: TObject);
begin
  // 恢复窗口
  Show;
  WindowState := wsNormal;
  Application.Restore;
  BringToFront;
end;

procedure TForm1.ReOpenClick(Sender: TObject);
begin
  Restore1Click(Sender);
end;

procedure TForm1.Restore1Click(Sender: TObject);
begin
  // 从右键菜单恢复窗口
  TrayIcon1DblClick(Sender);
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  // 退出应用程序
  TrayIcon1.Visible := True;
  Application.Terminate;
end;

end.
