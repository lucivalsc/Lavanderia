unit untPadrao;

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
  BufDataset, Grids, DBGrids, ExtCtrls, ZDataset, ZConnection,
  frxDBSet,
  DB;

type

  { TfrmPadrao }

  TfrmPadrao = class(TForm)
    BufDataset1: TBufDataset;
    BufDataset1CD_CADASTRO: TLongintField;
    BufDataset1DS_CADASTRO: TStringField;
    DataSource1: TDataSource;
    edtCodigo: TEdit;
    edtDescricao: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    lblQuantidadeArtigos: TLabel;
    PageControl1: TPageControl;
    tabPrincipal: TTabSheet;
    tabEdicao: TTabSheet;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    btnNovoRegistro: TButton;
    Panel3: TPanel;
    btnSalvar: TButton;
    Button1: TButton;
    Label3: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btnNovoRegistroClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure OcultarSheets(PageControl: TPageControl);
    procedure Listar(SQL_TEXTO: string);
    function GeraCodigo(SQL_TEXTO: string): string;
    procedure Gravar(SQL_TEXTO: string);
  end;

var
  frmPadrao: TfrmPadrao;

implementation

{$IFnDEF FPC}
  {$R *.dfm}

{$ELSE}
  {$R *.lfm}
{$ENDIF}

procedure TfrmPadrao.btnNovoRegistroClick(Sender: TObject);
begin
  edtCodigo.Text := '';
  edtDescricao.Text := '';
  btnSalvar.Caption := 'Salvar';
  PageControl1.ActivePage := tabEdicao;
end;

procedure TfrmPadrao.btnSalvarClick(Sender: TObject);
begin
  PageControl1.ActivePage := tabPrincipal;
end;

procedure TfrmPadrao.Button1Click(Sender: TObject);
begin
  PageControl1.ActivePage := tabPrincipal;
end;

procedure TfrmPadrao.DBGrid1DblClick(Sender: TObject);
begin
	  if not BufDataset1.IsEmpty then
	  begin
		    edtCodigo.Text := BufDataset1.FieldByName('CD_CADASTRO').AsString;
		    edtDescricao.Text := BufDataset1.FieldByName('DS_CADASTRO').AsString;
		    btnSalvar.Caption := 'Atualizar';
		    PageControl1.ActivePage := tabEdicao;
	  end else ShowMessage('Sem item para edição.');
end;

procedure TfrmPadrao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  Self := nil;
end;

procedure TfrmPadrao.FormCreate(Sender: TObject);
begin
  OcultarSheets(PageControl1);
end;

function TfrmPadrao.GeraCodigo(SQL_TEXTO: string): string;
var
  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin

  try
    Conexao := TZConnection.Create(nil);
    DM.ConectarBanco(Conexao);

    FDQGravar := TZQuery.Create(nil);
    FDQGravar.Connection := Conexao;

    Result := '';

    FDQGravar.Close;
    FDQGravar.SQL.Clear;
    FDQGravar.SQL.Add(SQL_TEXTO);
    FDQGravar.Open();

    Result := FDQGravar.FieldByName('CD_CADASTRO').AsString;

    FreeAndNil(FDQGravar);
    FreeAndNil(Conexao);

  except
    on E: Exception do
    begin
      ShowMessage(E.Message);
      FreeAndNil(FDQGravar);
      FreeAndNil(Conexao);
    end;
  end;
end;

procedure TfrmPadrao.Gravar(SQL_TEXTO: string);
var
  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin

  try
    Conexao := TZConnection.Create(nil);
    DM.ConectarBanco(Conexao);

    FDQGravar := TZQuery.Create(nil);
    FDQGravar.Connection := Conexao;

    FDQGravar.Close;
    FDQGravar.SQL.Clear;
    FDQGravar.SQL.Add(SQL_TEXTO);
    FDQGravar.ExecSQL;

    FreeAndNil(FDQGravar);
    FreeAndNil(Conexao);

  except
    on E: Exception do
    begin
      ShowMessage(E.Message);
      FreeAndNil(FDQGravar);
      FreeAndNil(Conexao);
    end;
  end;
end;

procedure TfrmPadrao.Listar(SQL_TEXTO: string);
var
  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin

  try
    Conexao:=TZConnection.Create(Nil);
    DM.ConectarBanco(Conexao);

    FDQGravar:=TZQuery.Create(Nil);
    FDQGravar.Connection:=Conexao;

    BufDataset1.Close;
    BufDataset1.CreateDataSet;

    FDQGravar.Close;
    FDQGravar.SQL.Clear;
    FDQGravar.SQL.Add(SQL_TEXTO);
    FDQGravar.Open;

    with FDQGravar do
    begin
      First;
      if RecordCount > 0 then
      begin
        DisableControls;
        BufDataset1.DisableControls;
        while not Eof do
        begin
          BufDataset1.Append;
          BufDataset1.FieldByName('CD_CADASTRO').AsInteger  :=  FieldByName('CD_CADASTRO').AsInteger;
          BufDataset1.FieldByName('DS_CADASTRO').AsString  :=  FieldByName('DS_CADASTRO').AsString;
          BufDataset1.Post;
          Next
        end;
        EnableControls;
        BufDataset1.EnableControls;
      end;

      BufDataset1.First;
    end;

    FreeAndNil(FDQGravar);
    FreeAndNil(Conexao);

    lblQuantidadeArtigos.Caption:=BufDataset1.RecordCount.ToString;

  except on E: Exception do
    begin
      ShowMessage(E.Message);
      FreeAndNil(FDQGravar);
      FreeAndNil(Conexao);
    end;
  end;
end;

procedure TfrmPadrao.OcultarSheets(PageControl: TPageControl);
var
  iPage: integer;
begin
  for iPage := 0 to PageControl.PageCount - 1 do
    PageControl.Pages[iPage].TabVisible := False;

  if (PageControl.PageCount > 0) then
    PageControl.ActivePage := PageControl.Pages[0];
end;

end.
