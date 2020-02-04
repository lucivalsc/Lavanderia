unit untSelecionarCadastro;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  Menus,
  ComCtrls,
  StdCtrls,
  Dialogs,
  Forms,
  Controls,
  Graphics,
  Classes,
  Variants,
  SysUtils,
  Messages,
  Windows,
  untFunctions,
  untDM,
  BufDataset, Grids, DBGrids, ExtCtrls, Buttons, ZDataset, ZConnection, DB;

type
  TfrmSelecionarCadastro = class(TForm)
    cbTipoProduto: TComboBox;
    Label2: TLabel;
    Button5: TButton;
    Button6: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure OcultarSheets(PageControl: TPageControl);
  end;

var
  frmSelecionarCadastro: TfrmSelecionarCadastro;

implementation

{$IFnDEF FPC}
  {$R *.dfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

procedure TfrmSelecionarCadastro.OcultarSheets(PageControl: TPageControl);
var
  iPage: Integer;
begin
  for iPage := 0 to PageControl.PageCount - 1 do
  PageControl.Pages[iPage].TabVisible := False;

    if ( PageControl.PageCount > 0 ) then
    PageControl.ActivePage := PageControl.Pages[0];

      //PageControl.Style := tsButtons;
end;

procedure TfrmSelecionarCadastro.Button2Click(Sender: TObject);
begin
  CD_CADASTRO:='';
  DS_CADASTRO:='';
  Close;
end;

procedure TfrmSelecionarCadastro.Button6Click(Sender: TObject);
begin
  //CD_CADASTRO:=BufDataset1.FieldByName('CD_CADASTRO').AsString;
  //DS_CADASTRO:=BufDataset1.FieldByName('DS_CADASTRO').AsString;
  Close;
end;

procedure TfrmSelecionarCadastro.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
  frmSelecionarCadastro:=Nil;
end;

procedure TfrmSelecionarCadastro.FormCreate(Sender: TObject);
var
  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin
  //BufDataset1.Close;
  //BufDataset1.CreateDataSet;
  //try
  //  Conexao:=TZConnection.Create(Nil);
  //  DM.ConectarBanco(Conexao);
  //
  //  FDQGravar:=TZQuery.Create(Nil);
  //  FDQGravar.Connection:=Conexao;
  //
  //  with FDQGravar do
  //  begin
  //    Close;
  //    SQL.Clear;
  //    SQL.Add(SQL_PESQUISA);
  //    Open();
  //
  //    First;
  //    if RecordCount > 0 then
  //    begin
  //      while not Eof do
  //      begin
  //        BufDataset1.Append;
  //        BufDataset1.FieldByName('CD_CADASTRO').AsString:=FieldByName('CD_CADASTRO').AsString;
  //        BufDataset1.FieldByName('DS_CADASTRO').AsString:=FieldByName('DS_CADASTRO').AsString;
  //        BufDataset1.Post;
  //        Next
  //      end;
  //    end;
  //
  //    BufDataset1.First;
  //  end;
  //
  //  FreeAndNil(FDQGravar);
  //  FreeAndNil(Conexao);
  //
  //except on E: Exception do
  //  begin
  //    ShowMessage(E.Message);
  //    FreeAndNil(FDQGravar);
  //    FreeAndNil(Conexao);
  //  end;
  //end;
end;

end.
