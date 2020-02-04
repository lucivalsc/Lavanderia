unit untSobre;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  ShellApi, jpeg, Windows,
{$ELSE}
  LCLIntf, LCLType, LMessages,
{$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type

		{ TfrmSobre }

  TfrmSobre = class(TForm)
    BitBtn1: TBitBtn;
    Bevel1: TBevel;
    Label1: TLabel;
    BitBtn2: TBitBtn;
    Shape1: TShape;
    Image1: TImage;
    Label2: TLabel;
    Label3: TLabel;
    myLabel3d5: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Shape2: TShape;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSobre: TfrmSobre;

implementation

{$IFnDEF FPC}
  {$R *.dfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

procedure TfrmSobre.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmSobre.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
  frmSobre:=Nil;
end;

procedure TfrmSobre.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_Escape then
  Close;
end;

end.
