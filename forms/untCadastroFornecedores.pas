unit untCadastroFornecedores;

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
  BufDataset, Grids, DBGrids, ExtCtrls, Buttons, rxctrls, ZDataset, ZConnection,
  DB;

type

  { TfrmCadastroFornecedores }

  TfrmCadastroFornecedores = class(TForm)
    btnPesquisar: TButton;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    edtCodigoFornecedor: TEdit;
    edtNomeFantasia: TEdit;
    edtRazaoSocial: TEdit;
    edtTelefone: TEdit;
    edtNomeContato: TEdit;
    edtEmail: TEdit;
    edtObservacao: TEdit;
    Label1: TLabel;
				Label2: TLabel;
				Label3: TLabel;
				Label4: TLabel;
				Label5: TLabel;
				Label6: TLabel;
				Label7: TLabel;
				Label8: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ToolBar1: TToolBar;
    spbUltimo: TSpeedButton;
    spbProximo: TSpeedButton;
    spbAnterior: TSpeedButton;
    spbPrimeiro: TSpeedButton;
    spbAlterar: TSpeedButton;
    spbSalvar: TSpeedButton;
    spbExcluir: TSpeedButton;
    spbCancelar: TSpeedButton;
    spbNovo: TSpeedButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    SpeedButton2: TSpeedButton;
    ToolButton6: TToolButton;
    DataSource1: TDataSource;
    PopupMenu1: TPopupMenu;
    Editar1: TMenuItem;
    ZQuery1: TZQuery;
				procedure btnPesquisarClick(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure DataSource1StateChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure spbNovoClick(Sender: TObject);
    procedure Editar1Click(Sender: TObject);
    procedure spbCancelarClick(Sender: TObject);
    procedure spbPrimeiroClick(Sender: TObject);
    procedure spbAnteriorClick(Sender: TObject);
    procedure spbProximoClick(Sender: TObject);
    procedure spbUltimoClick(Sender: TObject);
    procedure spbSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    TIPO_SALVAR: string;
    procedure OcultarSheets(PageControl: TPageControl);
    procedure ZerarComponentes;
    procedure PreencherDados;
  end;

var
  frmCadastroFornecedores: TfrmCadastroFornecedores;

implementation

{$IFnDEF FPC}
  {$R *.dfm}

{$ELSE}
  {$R *.lfm}
{$ENDIF}

procedure TfrmCadastroFornecedores.OcultarSheets(PageControl: TPageControl);
var
  iPage: integer;
begin
  for iPage := 0 to PageControl.PageCount - 1 do
    PageControl.Pages[iPage].TabVisible := False;

  if (PageControl.PageCount > 0) then
    PageControl.ActivePage := PageControl.Pages[0];

end;

procedure TfrmCadastroFornecedores.ZerarComponentes;
begin
  edtCodigoFornecedor.Text := '';
  edtNomeFantasia.Text := '';
  edtRazaoSocial.Text := '';
  edtTelefone.Text := '';
  edtNomeContato.Text := '';
  edtEmail.Text := '';
  edtObservacao.Text := '';
end;

procedure TfrmCadastroFornecedores.PreencherDados;
begin
  //ir para a tab de cadastro
  edtCodigoFornecedor.Text := ZQuery1.FieldByName('CD_FORNECEDORES').AsString;
  edtNomeFantasia.Text := ZQuery1.FieldByName('NM_FANTASIA').AsString;
  edtRazaoSocial.Text := ZQuery1.FieldByName('RAZAO_SOCIAL').AsString;
  edtTelefone.Text := ZQuery1.FieldByName('TELEFONE').AsString;
  edtNomeContato.Text := ZQuery1.FieldByName('NM_CONTATO').AsString;
  edtEmail.Text := ZQuery1.FieldByName('EMAIL').AsString;
  edtObservacao.Text := ZQuery1.FieldByName('OBSERVACAO').AsString;
end;

procedure TfrmCadastroFornecedores.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
  spbPrimeiro.Enabled := (spbAlterar.Enabled) and not
    ((Sender as TDataSource).DataSet.Bof);
  spbAnterior.Enabled := spbPrimeiro.Enabled;
  spbProximo.Enabled := (spbAlterar.Enabled) and not
    ((Sender as TDataSource).DataSet.EOF);
  spbUltimo.Enabled := spbProximo.Enabled;
end;

procedure TfrmCadastroFornecedores.btnPesquisarClick(Sender: TObject);
begin
   //
end;

procedure TfrmCadastroFornecedores.DataSource1StateChange(Sender: TObject);
begin
  spbNovo.Enabled := (Sender as TDataSource).State in [dsBrowse];
  spbSalvar.Enabled := (Sender as TDataSource).State in [dsEdit, dsInsert];
  spbCancelar.Enabled := spbSalvar.Enabled;
  spbAlterar.Enabled := (spbNovo.Enabled) and not
    ((Sender as TDataSource).DataSet.IsEmpty);
  spbExcluir.Enabled := spbAlterar.Enabled;
  //spbFechar.Enabled := spbNovo.Enabled;
end;

procedure TfrmCadastroFornecedores.Editar1Click(Sender: TObject);
begin
  PageControl1.ActivePage := PageControl1.Pages[1];
  PreencherDados;
  ZQuery1.Edit;
  TIPO_SALVAR := 'Editar';
end;

procedure TfrmCadastroFornecedores.FormCloseQuery(Sender: TObject;
  var CanClose: boolean);
begin
  if spbSalvar.Enabled then
  begin
    CanClose := False;
    MessageDlg('Salve ou cancele a operação corrente antes de fechar a janela',
      mtInformation, [mbOK], 0);
  end;
end;

procedure TfrmCadastroFornecedores.FormCreate(Sender: TObject);
begin
  OcultarSheets(PageControl1);
end;

procedure TfrmCadastroFornecedores.FormShow(Sender: TObject);
begin
  try
	    ZQuery1.Close;
	    ZQuery1.Open;
		except on E: Exception do
     ShowMessage(E.Message);
		end;
end;

procedure TfrmCadastroFornecedores.spbAnteriorClick(Sender: TObject);
begin
  ZQuery1.Prior;
  PreencherDados;
end;

procedure TfrmCadastroFornecedores.spbCancelarClick(Sender: TObject);
begin
  ZQuery1.Cancel;
  PageControl1.ActivePage := PageControl1.Pages[0];
end;

procedure TfrmCadastroFornecedores.spbNovoClick(Sender: TObject);
begin
  PageControl1.ActivePage := PageControl1.Pages[1];
  ZQuery1.Append;
  TIPO_SALVAR := 'Salvar';
  ZerarComponentes;
end;

procedure TfrmCadastroFornecedores.spbPrimeiroClick(Sender: TObject);
begin
  ZQuery1.First;
  PreencherDados;
end;

procedure TfrmCadastroFornecedores.spbProximoClick(Sender: TObject);
begin
  ZQuery1.Next;
  PreencherDados;
end;

procedure TfrmCadastroFornecedores.spbSalvarClick(Sender: TObject);
var
  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin
  if Trim(edtNomeFantasia.Text) = '' then
  begin
     ShowMessage('Nome fantasia é um campo obrigatório.');
     edtNomeFantasia.SetFocus;
     Abort;
  end;
  if Trim(edtTelefone.Text) = '' then
  begin
     ShowMessage('Telefone é um campo obrigatório.');
     edtTelefone.SetFocus;
     Abort;
  end;
  if Trim(edtNomeContato.Text) = '' then
  begin
     ShowMessage('Contato é um campo obrigatório.');
     edtNomeContato.SetFocus;
     Abort;
  end;

  try
    Conexao:=TZConnection.Create(Nil);
    DM.ConectarBanco(Conexao);

    FDQGravar:=TZQuery.Create(Nil);
    FDQGravar.Connection:=Conexao;

    try
		    if (TIPO_SALVAR = 'Salvar') and (trim(edtNomeFantasia.Text) <> '') then
		    begin
		     with FDQGravar do
		     begin
		       Close;
		       SQL.Clear;
		       SQL.Add('INSERT INTO FORNECEDORES(' +
                 'CD_FORNECEDORES, ' +
				             'NM_FANTASIA, ' +
                 'RAZAO_SOCIAL, ' +
				             'TELEFONE, ' +
                 'NM_CONTATO, ' +
                 'EMAIL, ' +
				             'OBSERVACAO) ' +

		               'VALUES(' +
				             ':CD_FORNECEDORES, ' +
		               ':NM_FANTASIA, ' +
				             ':RAZAO_SOCIAL, ' +
		               ':TELEFONE, ' +
				             ':NM_CONTATO, ' +
		               ':EMAIL, ' +
		               ':OBSERVACAO) ');

		       ParamByName('NM_FANTASIA').AsString   := edtNomeFantasia.Text;
		       ParamByName('RAZAO_SOCIAL').AsString  := edtRazaoSocial.Text;
		       ParamByName('TELEFONE').AsString      := edtTelefone.Text;
		       ParamByName('NM_CONTATO').AsString    := edtNomeContato.Text;
		       ParamByName('EMAIL').AsString         := edtEmail.Text;
		       ParamByName('OBSERVACAO').AsString    := edtObservacao.Text;
		       ExecSQL;
		     end;
		    end;


		    if TIPO_SALVAR = 'Editar' then
		    begin
			       with FDQGravar do
			       begin
			         SQL.Clear;
			         SQL.Add('UPDATE FORNECEDORES ' + 'SET ' +
					               'NM_FANTASIA =    :NM_FANTASIA,      ' +
					               'RAZAO_SOCIAL =   :RAZAO_SOCIAL,     ' +
					               'TELEFONE =       :TELEFONE,         ' +
					               'NM_CONTATO =     :NM_CONTATO,       ' +
					               'EMAIL =          :EMAIL,            ' +
					               'OBSERVACAO =     :OBSERVACAO        ' +
					               'WHERE CD_FORNECEDORES = :CD_FORNECEDORES ');

			         ParamByName('CD_FORNECEDORES').AsInteger := StrToInt(edtCodigoFornecedor.Text);
			         ParamByName('NM_FANTASIA').AsString      := edtNomeFantasia.Text;
			         ParamByName('RAZAO_SOCIAL').AsString     := edtRazaoSocial.Text;
			         ParamByName('TELEFONE').AsString         := edtTelefone.Text;
			         ParamByName('NM_CONTATO').AsString       := edtNomeContato.Text;
			         ParamByName('EMAIL').AsString            := edtEmail.Text;
			         ParamByName('OBSERVACAO').AsString       := edtObservacao.Text;
			         ExecSQL;
			       end;
		    end;

				finally
      begin
			      ZQuery1.Cancel;

			      ZQuery1.Close;
			      ZQuery1.Open();

			      btnPesquisarClick(Self);
			      PageControl1.ActivePage := PageControl1.Pages[0];

			      FreeAndNil(FDQGravar);
			      FreeAndNil(Conexao);
						end;
				end;

  except
    on E: Exception do
    begin
      ShowMessage(E.Message);
      FreeAndNil(FDQGravar);
      FreeAndNil(Conexao);
    end;
  end;
end;

procedure TfrmCadastroFornecedores.spbUltimoClick(Sender: TObject);
begin
  ZQuery1.Last;
  PreencherDados;
end;

end.
