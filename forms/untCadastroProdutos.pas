unit untCadastroProdutos;

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
  BufDataset, Grids, DBGrids, ExtCtrls, Buttons, ZDataset, ZConnection,
{$IFnDEF FPC}
  Data.Bind.DBScope, Data.Bind.Components, Vcl.Bind.DBEngExt, Data.Bind.EngExt, Vcl.Bind.Editors, System.Bindings.Outputs, System.Rtti, Vcl.Menus, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBGrids, Vcl.Grids, Vcl.Buttons, Data.DB, Vcl.Dialogs, Vcl.Forms, Vcl.Controls, Vcl.Graphics, System.Classes, System.Variants, System.SysUtils, Winapi.Messages, Winapi.Windows, FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.DApt.Intf, FireDAC.Phys.Intf, FireDAC.DatS, FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.Stan.Option, FireDAC.Stan.Intf, Vcl.Imaging.pngimage, Vcl.AppEvnts,
{$ELSE}
{$ENDIF}
  untSelecionarCadastro,
  untInventarioSituacao,
  DB;

type

		{ TfrmCadastroProdutos }

  TfrmCadastroProdutos = class(TForm)
					FDMemTableCadastro: TBufDataset;
					FDMemTableCadastroCD_BARRAS: TStringField;
					FDMemTableCadastroCD_FORNECEDOR: TLongintField;
					FDMemTableCadastroCD_MARCA: TLongintField;
					FDMemTableCadastroCD_PRODUTO: TLongintField;
					FDMemTableCadastroCD_TIPO_PRODUTO: TLongintField;
					FDMemTableCadastroDS_FORNECEDOR: TStringField;
					FDMemTableCadastroDS_MARCA: TStringField;
					FDMemTableCadastroDS_TIPO_PRODUTO: TStringField;
					FDMemTableCadastroSITUACAO: TStringField;
					FDMemTableCodigoBarras: TBufDataset;
					FDMemTableCodigoBarras2: TBufDataset;
					FDMemTableCodigoBarrasCD_ARTIGO: TLongintField;
					FDMemTableCodigoBarrasCD_ARTIGO1: TLongintField;
					FDMemTableCodigoBarrasCD_BARRAS: TStringField;
					FDMemTableCodigoBarrasCD_BARRAS1: TStringField;
					FDMemTableCodigoBarrasCD_PRODUTO: TLongintField;
					FDMemTableCodigoBarrasCD_PRODUTO1: TLongintField;
					FDMemTableCodigoBarrasDS_TIPO_PRODUTO: TStringField;
					FDMemTableCodigoBarrasDS_TIPO_PRODUTO1: TStringField;
					FDMemTableCodigoBarrasQUANTIDADE: TLongintField;
					FDMemTableCodigoBarrasQUANTIDADE1: TLongintField;
					FDMemTableInventarioQT_INVENTARIADA: TLongintField;
					BufTableListagem: TBufDataset;
					FDMemTableInventario: TBufDataset;
					BufTableListagemCD_CADASTRO: TLongintField;
					FDMemTableListagemCD_CADASTRO1: TLongintField;
					BufTableListagemCONTAGEM1: TLongintField;
					BufTableListagemCONTAGEM2: TLongintField;
					BufTableListagemCONTAGEM3: TLongintField;
					FDMemTableListagemCONTAGEM4: TLongintField;
					BufTableListagemDS_CADASTRO: TStringField;
					FDMemTableListagemDS_CADASTRO1: TStringField;
					BufTableListagemDT_INVENTARIO: TStringField;
					FDMemTableListagemDT_INVENTARIO1: TStringField;
					BufTableListagemNM_INVENTARIO: TStringField;
					FDMemTableListagemNM_INVENTARIO1: TStringField;
					BufTableListagemQT_ARTIGO: TLongintField;
					FDMemTableListagemQT_ARTIGO1: TLongintField;
					BufTableListagemTOTAL: TFloatField;
					FDMemTableListagemTOTAL1: TFloatField;
    PageControl1: TPageControl;
				SpeedButton2: TSpeedButton;
				SpeedButton3: TSpeedButton;
				SpeedButton4: TSpeedButton;
    tabListaProduto: TTabSheet;
    tabCadastroProduto: TTabSheet;
    edtCodigoProduto: TEdit;
    Label1: TLabel;
    edtDescricaoProduto: TEdit;
    Label2: TLabel;
    Panel1: TPanel;
    edtCodigoBarras: TEdit;
    Label4: TLabel;
    DBGrid1: TDBGrid;
    edtDescricaoFornecedor: TEdit;
    Label5: TLabel;
    edtDescricaoTipoProduto: TEdit;
    Label6: TLabel;
    edtDescricaoMarca: TEdit;
    Label7: TLabel;
    edtCodigoTipoProduto: TEdit;
    edtCodigoMarca: TEdit;
    edtCodigoFornecedor: TEdit;
    btnAdicionar: TButton;
    Panel2: TPanel;
    btnCancelar: TButton;
    btnInativar: TButton;
    DataSource1: TDataSource;
    Panel3: TPanel;
    Label12: TLabel;
    edtDescricaoArtigo: TEdit;
    DBGrid2: TDBGrid;
    Panel4: TPanel;
    DataSource2: TDataSource;
    lblQuantidadeArtigos: TLabel;
    Panel5: TPanel;
    PopupMenu1: TPopupMenu;
    Inventrio1: TMenuItem;
    Zerarquantidades1: TMenuItem;
    N1: TMenuItem;
    Salvarquantidades1: TMenuItem;
    Editarartigo1: TMenuItem;
    N2: TMenuItem;
    PopupMenu2: TPopupMenu;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    N4: TMenuItem;
    Criarinventrio1: TMenuItem;
    Button1: TButton;
    tabInventario: TTabSheet;
    panelPrincipalInventario: TPanel;
    Panel7: TPanel;
    btnBuscarProduto: TButton;
    Panel8: TPanel;
    btnAtualizarEstoque: TButton;
    Button10: TButton;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Edit1: TEdit;
    edtNomeUsuario: TEdit;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    edtInventarioCodigoBarrasInventario: TEdit;
    Button3: TButton;
    tabInventarioCodigoBarras: TTabSheet;
    Panel6: TPanel;
    Label17: TLabel;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel18: TPanel;
    edtInventarioCodigoBarras: TEdit;
    Panel22: TPanel;
    Button5: TButton;
    btnInvetarioInserir: TButton;
    N3: TMenuItem;
    Cancelar1: TMenuItem;
    btnSalvarContagem: TButton;
    DBGrid3: TDBGrid;
    DataSource3: TDataSource;
    lblInventarioDescricaoArtigo: TLabel;
    Button2: TButton;
    lblInventarioQuantidadeCodigos: TLabel;
    PopupMenuInventario: TPopupMenu;
    Inserirporcdigodebarras1: TMenuItem;
    DBGrid4: TDBGrid;
    DataSource4: TDataSource;
    edtCodigoBarrasDescricao: TEdit;
    Button4: TButton;
    ComboBox1: TComboBox;
    Label3: TLabel;
    N5: TMenuItem;
    Editar1: TMenuItem;
    Button6: TButton;
    edtInventarioDescricaoArtigo: TEdit;
    lblQuantidadeInventariada: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAdicionarClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure edtDescricaoArtigoChange(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnInativarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure Zerarquantidades1Click(Sender: TObject);
    procedure Editarartigo1Click(Sender: TObject);
    procedure Salvarquantidades1Click(Sender: TObject);
    procedure Limparfiltro1Click(Sender: TObject);
    procedure Cdigodebarras1Click(Sender: TObject);
    procedure Criarinventrio1Click(Sender: TObject);
    procedure btnBuscarProdutoClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Cancelar1Click(Sender: TObject);
    procedure edtInventarioCodigoBarrasChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnInvetarioInserirClick(Sender: TObject);
    procedure DBGrid4DblClick(Sender: TObject);
    procedure btnAtualizarEstoqueClick(Sender: TObject);
    procedure btnSalvarContagemClick(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Editar1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure edtInventarioCodigoBarrasInventarioChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure OcultarSheets(PageControl: TPageControl);
    procedure SelecionarCadastro;
    procedure ListarCampos(FDMemTable: TBufDataset; ORDENACAO: String);
    procedure ListarCodigoBarras;

    procedure SalvarDados;
    procedure AtualizarArtigo(QT_ARTIGO, CD_ARTIGO: String);
    procedure SalvarContagemInventario;
    procedure ListarContagem;

    procedure SituacaoArtigo(SITUACAO: String);
    procedure LimparCampos;
    procedure LimparCamposInventario;
    procedure CliqueBotaoFrame(Sender: TObject);


    procedure ListarSetores;
  end;

var
  frmCadastroProdutos: TfrmCadastroProdutos;

implementation

{$IFnDEF FPC}
  {$R *.dfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

procedure TfrmCadastroProdutos.btnAdicionarClick(Sender: TObject);
var
  CODIGO: String;
  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin
  try
    Conexao:=TZConnection.Create(Nil);
    DM.ConectarBanco(Conexao);

    FDQGravar:=TZQuery.Create(Nil);
    FDQGravar.Connection:=Conexao;

    if btnAdicionar.Caption = 'Adicionar' then
    begin
      if (edtCodigoBarras.Text = '') then exit else
        if (edtDescricaoTipoProduto.Text = '') then exit else
          if (edtDescricaoFornecedor.Text = '') then exit else
          begin

            with FDQGravar do
            begin
              Close;
              SQL.Clear;
              SQL.Add('SELECT MAX(CD_PRODUTO) CD_PRODUTO '+
                      'FROM PRODUTOS ');
              Open();

              CODIGO:=FieldByName('CD_PRODUTO').AsString;

              //Verificar se código de barras já está cadastrado
              Close;
              SQL.Clear;
              SQL.Add('SELECT CD_BARRAS '+
                      'FROM PRODUTOS '+
                      'WHERE CD_BARRAS = :CD_BARRAS');
              ParamByName('CD_BARRAS').AsString:=edtCodigoBarras.Text;
              Open();

            end;

            if trim(FDQGravar.FieldByName('CD_BARRAS').Text) = '' then
            begin
              //Gravar na memória
              with BufTableListagem do
              begin
                Append;
                FieldByName('CD_PRODUTO').AsInteger     :=  StrToIntDef(CODIGO, 0) + 1;;
                FieldByName('CD_BARRAS').AsString       :=  Trim(edtCodigoBarras.Text);
                FieldByName('CD_TIPO_PRODUTO').AsString :=  edtCodigoTipoProduto.Text;
                FieldByName('DS_TIPO_PRODUTO').AsString :=  edtDescricaoTipoProduto.Text;
                FieldByName('CD_MARCA').AsString        :=  edtCodigoMarca.Text;
                FieldByName('DS_MARCA').AsString        :=  edtDescricaoMarca.Text;
                FieldByName('CD_FORNECEDOR').AsString   :=  edtCodigoFornecedor.Text;
                FieldByName('DS_FORNECEDOR').AsString   :=  edtDescricaoFornecedor.Text;
                FieldByName('SITUACAO').AsString        :=  'ATIVO';
                Post;
                edtCodigoBarras.SetFocus;
              end;

              //Gravar direto no banco
              SalvarDados;

              //Aumentar quantidade no artigo
              AtualizarArtigo(IntToStr(BufTableListagem.FieldByName('TOTAL').AsInteger + 1),
                                 edtCodigoProduto.Text);
            end else ShowMessage('Código de barras existente no cadastro.');
          end;
    end else

    if btnAdicionar.Caption = 'Atualizar' then
    begin
      if (edtCodigoBarras.Text = '') then exit else
        if (edtDescricaoTipoProduto.Text = '') then exit else
          if (edtDescricaoFornecedor.Text = '') then exit else
          begin

            with FDQGravar do
            begin
              //Verificar se codigo de barras já está cadastrado
              Close;
              SQL.Clear;
              SQL.Add('SELECT CD_BARRAS '+
                      'FROM PRODUTOS '+
                      'WHERE CD_BARRAS = :CD_BARRAS');
              ParamByName('CD_BARRAS').AsString:=edtCodigoBarras.Text;
              Open();

            end;

            if Trim(FDQGravar.FieldByName('CD_BARRAS').Text) = '' then
            begin
              //Update no banco de dados atualizando o código
              with FDQGravar do
              begin
                //Verificar se codigo de barras já está cadastrado
                Close;
                SQL.Clear;
                SQL.Add('UPDATE PRODUTOS '+
                        'SET '+
                        'CD_BARRAS = :CD_BARRAS, '+
                        'CD_TIPO_PRODUTO = :CD_TIPO_PRODUTO, '+
                        'DS_TIPO_PRODUTO = :DS_TIPO_PRODUTO, '+
                        'CD_MARCA = :CD_MARCA, '+
                        'DS_MARCA = :DS_MARCA, '+
                        'CD_FORNECEDOR = :CD_FORNECEDOR, '+
                        'DS_FORNECEDOR = :DS_FORNECEDOR '+
                        'WHERE CD_PRODUTO = :CD_PRODUTO');

                //ParamByName('CD_PRODUTO').AsString          :=  BufTableListagem.ParamByName('CD_PRODUTO').AsString;
                ParamByName('CD_BARRAS').AsString           :=  edtCodigoBarras.Text;
                ParamByName('CD_TIPO_PRODUTO').AsString     :=  edtCodigoTipoProduto.Text;
                ParamByName('DS_TIPO_PRODUTO').AsString     :=  edtDescricaoTipoProduto.Text;
                ParamByName('CD_MARCA').AsString            :=  edtCodigoMarca.Text;
                ParamByName('DS_MARCA').AsString            :=  edtDescricaoMarca.Text;
                ParamByName('CD_FORNECEDOR').AsString       :=  edtCodigoFornecedor.Text;
                ParamByName('DS_FORNECEDOR').AsString       :=  edtDescricaoFornecedor.Text;
                ExecSQL;

              end;

              //Gravar na memória
              with BufTableListagem do
              begin
                Edit;
                FieldByName('CD_BARRAS').AsString       :=  edtCodigoBarras.Text;
                FieldByName('CD_TIPO_PRODUTO').AsString :=  edtCodigoTipoProduto.Text;
                FieldByName('DS_TIPO_PRODUTO').AsString :=  edtDescricaoTipoProduto.Text;
                FieldByName('CD_MARCA').AsString        :=  edtCodigoMarca.Text;
                FieldByName('DS_MARCA').AsString        :=  edtDescricaoMarca.Text;
                FieldByName('CD_FORNECEDOR').AsString   :=  edtCodigoFornecedor.Text;
                FieldByName('DS_FORNECEDOR').AsString   :=  edtDescricaoFornecedor.Text;
                //FieldByName('SITUACAO').AsString        :=  'ATIVO';
                Post;
                edtCodigoBarras.SetFocus;
              end;
            end else ShowMessage('Código de barras existente no cadastro.');
          end;
    end;

    FreeAndNil(FDQGravar);
    FreeAndNil(Conexao);

    btnAdicionar.Caption:='Adicionar';

  except on E: Exception do
    begin
      ShowMessage(E.Message);
      FreeAndNil(FDQGravar);
      FreeAndNil(Conexao);
    end;
  end;
end;

procedure TfrmCadastroProdutos.btnCancelarClick(Sender: TObject);
begin
  ListarCampos(BufTableListagem, '');
  FDMemTableCadastro.Filtered:=False;
  PageControl1.ActivePage:=tabListaProduto;
end;

procedure TfrmCadastroProdutos.btnInativarClick(Sender: TObject);
begin
  if FDMemTableCadastro.RecordCount > 0 then
  begin
    if btnInativar.Caption = 'INATIVAR' then
    begin
      FDMemTableCadastro.Edit;
      FDMemTableCadastroSITUACAO.AsString:='INATIVO';
      FDMemTableCadastro.Post;

      SituacaoArtigo('N');

      btnInativar.Caption := 'ATIVAR'
    end else

      if btnInativar.Caption = 'ATIVAR' then
      begin
        FDMemTableCadastro.Edit;
        FDMemTableCadastroSITUACAO.AsString:='ATIVO';
        FDMemTableCadastro.Post;

        SituacaoArtigo('S');

        btnInativar.Caption := 'INATIVAR'
      end;
  end;

  LimparCampos;
  ListarCodigoBarras;
end;

procedure TfrmCadastroProdutos.btnInvetarioInserirClick(Sender: TObject);
var
  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin
  try
    Conexao:=TZConnection.Create(Nil);
    DM.ConectarBanco(Conexao);

    FDQGravar:=TZQuery.Create(Nil);
    FDQGravar.Connection:=Conexao;

    with FDQGravar do
    begin
      Close;
      SQL.Clear;
      SQL.Add(
              'SELECT '+
              'CD_ARTIGO, '+
              'CD_BARRAS '+
              'FROM PRODUTOS '+
              'WHERE CD_BARRAS = :CD_BARRAS '
              );
      ParamByName('CD_BARRAS').AsString:=edtInventarioCodigoBarras.Text;
      Open;

      if FieldByName('CD_ARTIGO').AsString = FDMemTableInventario.FieldByName('CD_CADASTRO').AsString then
      begin
        if FDMemTableCodigoBarras2.Locate('CD_BARRAS', edtInventarioCodigoBarras.Text, []) then
        begin
          ShowMessage('Código de barras já encontra - se na lista.');
        end else
          begin
            with FDMemTableCodigoBarras do
            begin
              Append;
              FieldByName('CD_ARTIGO').AsString :=  FDMemTableInventario.FieldByName('CD_CADASTRO').AsString;
              FieldByName('CD_BARRAS').AsString :=  edtInventarioCodigoBarras.Text;
              FieldByName('DS_TIPO_PRODUTO').AsString :=  edtCodigoBarrasDescricao.Text;
              FieldByName('QUANTIDADE').AsString :=  '1';
              Post;
            end;

            with FDMemTableCodigoBarras2 do
            begin
              Append;
              FieldByName('CD_ARTIGO').AsString :=  FDMemTableInventario.FieldByName('CD_CADASTRO').AsString;
              FieldByName('CD_BARRAS').AsString :=  edtInventarioCodigoBarras.Text;
              FieldByName('DS_TIPO_PRODUTO').AsString :=  edtCodigoBarrasDescricao.Text;
              FieldByName('QUANTIDADE').AsString :=  '1';
              Post;
            end;

            edtInventarioCodigoBarras.Text:='';
            edtCodigoBarrasDescricao.Text:='';

            lblInventarioQuantidadeCodigos.Caption:='Qtde de itens: ' + IntToStr(FDMemTableCodigoBarras.RecordCount);
          end;
      end else ShowMessage('Código de barras digitado não faz parte desse artigo inventariado.');
    end;

    FreeAndNil(FDQGravar);
    FreeAndNil(Conexao);

  except on E: Exception do
    begin
      ShowMessage(E.Message);
      FreeAndNil(FDQGravar);
      FreeAndNil(Conexao);
    end;
  end;
end;

procedure TfrmCadastroProdutos.btnSalvarContagemClick(Sender: TObject);
begin
  if FDMemTableCodigoBarras2.RecordCount > 0 then
    SalvarContagemInventario;
end;

procedure TfrmCadastroProdutos.CliqueBotaoFrame(Sender: TObject);
begin

end;

procedure TfrmCadastroProdutos.Button10Click(Sender: TObject);
begin
  if not Assigned(frmInventarioSituacao) then
  begin
    frmInventarioSituacao:=TfrmInventarioSituacao.Create(Nil);
    frmInventarioSituacao.ShowModal;
  end;
end;

procedure TfrmCadastroProdutos.Button1Click(Sender: TObject);
var
  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin
  try
    Conexao:=TZConnection.Create(Nil);
    DM.ConectarBanco(Conexao);

    FDQGravar:=TZQuery.Create(Nil);
    FDQGravar.Connection:=Conexao;

    with FDQGravar do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT COUNT(*) TOTAL FROM INVENTARIO');
      Open;

      if FieldByName('TOTAL').AsString <> '0' then
      begin
        Case Application.MessageBox(Pchar(
          'Existe um inventário aberto, deseja continuar?'),
          'Aviso do Sistema', MB_YESNO)
          of
            IDYES  :
            begin
              btnBuscarProduto.Enabled    :=  False;
              btnAtualizarEstoque.Enabled :=  True;
              btnSalvarContagem.Enabled   :=  True;

              //Se tiver inventário pendente ele lista
              ListarContagem;

              ListarCampos(FDMemTableInventario, '');
              lblQuantidadeInventariada.Caption   :=  'Qtde Inventariada: ' +
              FDMemTableInventario.FieldByName('QT_INVENTARIADA').AsString;


              Close;
              SQL.Clear;
              SQL.Add('SELECT MAX(NR_INVENTARIO) NR_INVENTARIO FROM INVENTARIO');
              Open();

              NR_INVENTARIO:=StrToIntDef(FieldByName('NR_INVENTARIO').AsString, 0);

            end;

            IDNO :
            begin
              Close;
              SQL.Clear;
              SQL.Add('DELETE FROM INVENTARIO');
              ExecSQL;

              btnBuscarProduto.Enabled    :=  True;
              btnAtualizarEstoque.Enabled :=  False;
              btnSalvarContagem.Enabled   :=  False;

              //Cria os Fields
              FDMemTableInventario.Close;
              FDMemTableInventario.CreateDataSet;

              FDMemTableCodigoBarras.Close;
              FDMemTableCodigoBarras.CreateDataSet;

              FDMemTableCodigoBarras2.Close;
              FDMemTableCodigoBarras2.CreateDataSet;
              lblQuantidadeInventariada.Caption   :=  'Qtde Inventariada: ' +
                  FDMemTableInventario.FieldByName('QT_INVENTARIADA').AsString;
            end;
        end;

      end else
          begin
            //Cria os Fields
            FDMemTableInventario.Close;
            FDMemTableInventario.CreateDataSet;

            FDMemTableCodigoBarras.Close;
            FDMemTableCodigoBarras.CreateDataSet;

            FDMemTableCodigoBarras2.Close;
            FDMemTableCodigoBarras2.CreateDataSet;
          end;
    end;

    edtNomeUsuario.Text     :=  NM_USUARIO;
    LimparCamposInventario;
    PageControl1.ActivePage:=tabInventario;

    FreeAndNil(FDQGravar);
    FreeAndNil(Conexao);

  except on E: Exception do
    begin
      ShowMessage(E.Message);
      FreeAndNil(FDQGravar);
      FreeAndNil(Conexao);
    end;
  end;
end;

procedure TfrmCadastroProdutos.Button2Click(Sender: TObject);
begin
  PageControl1.ActivePage:=tabInventario;

  edtInventarioCodigoBarras.Text:='';
  edtCodigoBarrasDescricao.Text:='';
end;

procedure TfrmCadastroProdutos.btnAtualizarEstoqueClick(Sender: TObject);
var
  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin
  try
    Case Application.MessageBox(Pchar(
      'Este processo irá atualizar seu estoque, conforme valores informados na contagem.'+ #13 +
      'Tem certeza que deseja continuar?'),
      'Aviso do Sistema', MB_YESNO)
      of
        IDYES  :
        begin
          with FDMemTableInventario do
          begin
            First;
            if RecordCount > 0 then
            begin
              DisableControls;
              while not Eof do
              begin
                AtualizarArtigo(FieldByName('CONTAGEM1').AsString,
                                 FieldByName('CD_CADASTRO').AsString);
                Next
              end;
            end;
              EnableControls;
              First;
          end;

          Conexao:=TZConnection.Create(Nil);
          DM.ConectarBanco(Conexao);

          FDQGravar:=TZQuery.Create(Nil);
          FDQGravar.Connection:=Conexao;

          //Limpar
          with FDQGravar do
          begin
            Close;
            SQL.Clear;
            SQL.Add('DELETE FROM INVENTARIO');
            ExecSQL;
          end;

          //Salvar dados da contagem
          if FDMemTableCodigoBarras2.RecordCount > 0 then
            SalvarContagemInventario;

          ListarCampos(FDMemTableInventario, '');
          btnBuscarProduto.Enabled    :=  True;
          btnAtualizarEstoque.Enabled :=  False;
          btnSalvarContagem.Enabled   :=  False;

          ListarCampos(BufTableListagem, '');
        end;

        IDNO :
        begin

        end;
    end;

    FreeAndNil(FDQGravar);
    FreeAndNil(Conexao);

  except on E: Exception do
    begin
      ShowMessage(E.Message);
      FreeAndNil(FDQGravar);
      FreeAndNil(Conexao);
    end;
  end;
end;

procedure TfrmCadastroProdutos.btnBuscarProdutoClick(Sender: TObject);
var
  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin
  try
    Conexao:=TZConnection.Create(Nil);
    DM.ConectarBanco(Conexao);

    FDQGravar:=TZQuery.Create(Nil);
    FDQGravar.Connection:=Conexao;

    with FDQGravar do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT MAX(NR_INVENTARIO) NR_INVENTARIO FROM INVENTARIO');
      Open();

      NR_INVENTARIO:=StrToIntDef(FieldByName('NR_INVENTARIO').AsString, 0) + 1;

      ListarCampos(FDMemTableInventario, '');

      btnBuscarProduto.Enabled    :=  False;
      btnAtualizarEstoque.Enabled :=  True;
      btnSalvarContagem.Enabled   :=  True;
    end;

    FreeAndNil(FDQGravar);
    FreeAndNil(Conexao);

  except on E: Exception do
    begin
      ShowMessage(E.Message);
      FreeAndNil(FDQGravar);
      FreeAndNil(Conexao);
    end;
  end;
end;

procedure TfrmCadastroProdutos.Button3Click(Sender: TObject);
begin
  btnBuscarProduto.Enabled    :=  True;
  btnAtualizarEstoque.Enabled :=  False;
  btnSalvarContagem.Enabled   :=  False;
  PageControl1.ActivePage:=tabListaProduto;
end;

procedure TfrmCadastroProdutos.Button5Click(Sender: TObject);
begin
  with FDMemTableInventario do
  begin
    Edit;
    FieldByName('CONTAGEM1').AsString:=IntToStr(FDMemTableCodigoBarras.RecordCount);
    Post;
  end;
  PageControl1.ActivePage:=tabInventario;
  edtInventarioCodigoBarras.Text:='';
  edtCodigoBarrasDescricao.Text:='';
end;

procedure TfrmCadastroProdutos.Button6Click(Sender: TObject);
var
  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin
  try
    Conexao:=TZConnection.Create(Nil);
    DM.ConectarBanco(Conexao);

    FDQGravar:=TZQuery.Create(Nil);
    FDQGravar.Connection:=Conexao;

    with FDQGravar do
    begin
      Close;
      SQL.Clear;
      SQL.Add(
              'SELECT '+
              'P.CD_PRODUTO, '+
              'P.CD_ARTIGO, '+
              'P.CD_BARRAS, '+
              'A.DS_ARTIGO '+
              ' '+
              'FROM PRODUTOS P '+
              ' '+
              'INNER JOIN ARTIGOS A ON '+
              'A.CD_ARTIGO = P.CD_ARTIGO '+

              'WHERE P.CD_BARRAS = :CD_BARRAS '
              );
      ParamByName('CD_BARRAS').AsString:=edtInventarioCodigoBarrasInventario.Text;
      Open;

      CD_PRODUTO                        :=  FieldByName('CD_PRODUTO').Text;
      CD_ARTIGO                         :=  FieldByName('CD_ARTIGO').Text;
      edtInventarioDescricaoArtigo.Text :=  FieldByName('DS_ARTIGO').AsString;

      if RecordCount > 0 then
      begin
        if FDMemTableCodigoBarras2.Locate('CD_BARRAS', edtInventarioCodigoBarrasInventario.Text, []) then
        begin
          ShowMessage('Código de barras já encontra - se na lista.');
        end else
          begin
            with FDMemTableCodigoBarras do
            begin
              Append;
              FieldByName('CD_PRODUTO').AsString      :=  CD_PRODUTO;
              FieldByName('CD_ARTIGO').AsString       :=  CD_ARTIGO;
              FieldByName('CD_BARRAS').AsString       :=  edtInventarioCodigoBarrasInventario.Text;
              FieldByName('DS_TIPO_PRODUTO').AsString :=  edtInventarioDescricaoArtigo.Text;
              FieldByName('QUANTIDADE').AsString      :=  '1';
              Post;
            end;

            with FDMemTableCodigoBarras2 do
            begin
              Append;
              FieldByName('CD_PRODUTO').AsString      :=  CD_PRODUTO;
              FieldByName('CD_ARTIGO').AsString       :=  CD_ARTIGO;
              FieldByName('CD_BARRAS').AsString       :=  edtInventarioCodigoBarrasInventario.Text;
              FieldByName('DS_TIPO_PRODUTO').AsString :=  edtInventarioDescricaoArtigo.Text;
              FieldByName('QUANTIDADE').AsString      :=  '1';
              Post;
            end;

            //Somar contagem
            with FDMemTableInventario do
            begin
              //Localizar produto por descrição do item
              //Locate('CD_CADASTRO', CD_ARTIGO, [loCaseInsensitive]);
              Filtered  :=False;
              Filter    :='CD_CADASTRO LIKE ' + QuotedStr(CD_ARTIGO);
              Filtered  :=True;

              Edit;
              FieldByName('CONTAGEM1').AsInteger:=FieldByName('CONTAGEM1').AsInteger + 1;
              Post;

              Filtered  :=False;

              First;

              lblQuantidadeInventariada.Caption       :=  'Qtde Inventariada: ' + FieldByName('QT_INVENTARIADA').AsString;
            end;

            edtInventarioCodigoBarrasInventario.Text  :=  '';
            edtInventarioDescricaoArtigo.Text         :=  '';

            lblInventarioQuantidadeCodigos.Caption  :=  'Qtde de itens: ' + IntToStr(FDMemTableCodigoBarras.RecordCount);

          end;

      end;
    end;

    FreeAndNil(FDQGravar);
    FreeAndNil(Conexao);
  except on E: Exception do
    begin
      ShowMessage(E.Message);
      FreeAndNil(FDQGravar);
      FreeAndNil(Conexao);
    end;
  end;
end;

procedure TfrmCadastroProdutos.Cancelar1Click(Sender: TObject);
begin
  ListarCampos(BufTableListagem, '');
end;

procedure TfrmCadastroProdutos.Cdigodebarras1Click(Sender: TObject);
var
  MOTIVO: Boolean;
  ID: String;
begin
  MOTIVO:=InputQuery('Digite o texto de pesquisa.', 'Texto para pesquisa:', ID);
  if MOTIVO then
  begin
    FDMemTableCadastro.Filtered:=False;
    FDMemTableCadastro.Filter:=TMenuItem(Sender).Hint + ' LIKE ' + QuotedStr('%' + ID + '%');
    FDMemTableCadastro.Filtered:=True;
  end;
end;

procedure TfrmCadastroProdutos.Criarinventrio1Click(Sender: TObject);
var
  MOTIVO: Boolean;
  ID: String;
  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin
  try
    Conexao:=TZConnection.Create(Nil);
    DM.ConectarBanco(Conexao);

    FDQGravar:=TZQuery.Create(Nil);
    FDQGravar.Connection:=Conexao;


    MOTIVO:=InputQuery('Digite o nome para o inventário.', 'Nome do inventário:', ID);
    if MOTIVO then
    begin

      with FDQGravar do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM INVENTARIO WHERE NR_INVENTARIO = ' + QuotedStr(ID));
        Open();

        if FieldByName('NR_INVENTARIO').AsString = '' then
        begin
          DisableControls;
          BufTableListagem.First;
          BufTableListagem.DisableControls;
          while not BufTableListagem.Eof do
          begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO INVENTARIO( '+
                    'DT_INVENTARIO, '+
                    'NR_INVENTARIO, '+
                    'CD_ARTIGO, '+
                    'QT_ARTIGO, '+
                    'CONTAGEM_1, '+
                    'CONTAGEM_2, '+
                    'CONTAGEM_3) '+

                    'VALUES( '+
                    ':DT_INVENTARIO, '+
                    ':NR_INVENTARIO, '+
                    ':CD_ARTIGO, '+
                    ':QT_ARTIGO, '+
                    ':CONTAGEM_1, '+
                    ':CONTAGEM_2, '+
                    ':CONTAGEM_3) '
                    );

            ParamByName('DT_INVENTARIO').AsDateTime   :=  Now;
            ParamByName('NR_INVENTARIO').AsString     :=  UpperCase(ID);
            ParamByName('CD_ARTIGO').AsString         :=  BufTableListagem.FieldByName('CD_CADASTRO').AsString;
            ParamByName('QT_ARTIGO').AsString         :=  BufTableListagem.FieldByName('TOTAL').AsString;;
            ParamByName('CONTAGEM_1').IsNull;
            ParamByName('CONTAGEM_2').IsNull;
            ParamByName('CONTAGEM_3').IsNull;
            ExecSQL;
            BufTableListagem.Next;
          end;

          BufTableListagem.First;
          BufTableListagem.EnableControls;
          EnableControls;
          ShowMessage('Inventário criado com sucesso.');
        end else ShowMessage('Este inventário já existe.');
      end;

    end;

      FreeAndNil(FDQGravar);
      FreeAndNil(Conexao);

  except on E: Exception do
    begin
      ShowMessage(E.Message);
      FreeAndNil(FDQGravar);
      FreeAndNil(Conexao);
    end;
  end;
end;

procedure TfrmCadastroProdutos.DBGrid1CellClick(Column: TColumn);
begin
  if FDMemTableCadastro.RecordCount > 0 then
  begin
    if FDMemTableCadastroSITUACAO.AsString = 'ATIVO' then
      btnInativar.Caption:='INATIVAR' else
        btnInativar.Caption:='ATIVAR';
  end;
end;

procedure TfrmCadastroProdutos.DBGrid4DblClick(Sender: TObject);
begin
  edtInventarioCodigoBarras.Text:='';
  edtCodigoBarrasDescricao.Text:='';
  if FDMemTableInventario.RecordCount > 0 then
  begin
    FDMemTableCodigoBarras.Filtered :=  False;
    FDMemTableCodigoBarras.Filter   :=  'CD_ARTIGO = ' + FDMemTableInventario.FieldByName('CD_CADASTRO').AsString;
    FDMemTableCodigoBarras.Filtered :=  True;

    lblInventarioDescricaoArtigo.Caption:=FDMemTableInventario.FieldByName('CD_CADASTRO').AsString
                                          + ' - ' + FDMemTableInventario.FieldByName('DS_CADASTRO').AsString;

    lblInventarioQuantidadeCodigos.Caption:='Nr. de Itens: ' + IntToStr(FDMemTableCodigoBarras.RecordCount);
    PageControl1.ActivePage:=tabInventarioCodigoBarras;
  end;
end;

procedure TfrmCadastroProdutos.edtDescricaoArtigoChange(Sender: TObject);
begin
  if Trim(edtDescricaoArtigo.Text) <> '' then
  begin
	  BufTableListagem.Filtered   :=  False;
	  BufTableListagem.Filter     :=  'DS_CADASTRO = ' + QuotedStr('*' + edtDescricaoArtigo.Text + '*');
   BufTableListagem.FilterOptions:=[foCaseInsensitive];;
	  BufTableListagem.Filtered   :=  True;

   lblQuantidadeArtigos.Caption:= BufTableListagem.RecordCount.ToString + ' Artigo(s)';
		end else BufTableListagem.Filtered   :=  False;
end;

procedure TfrmCadastroProdutos.edtInventarioCodigoBarrasChange(Sender: TObject);
var
  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin
  try
    Conexao:=TZConnection.Create(Nil);
    DM.ConectarBanco(Conexao);

    FDQGravar:=TZQuery.Create(Nil);
    FDQGravar.Connection:=Conexao;

    with FDQGravar do
    begin
      Close;
      SQL.Clear;
      SQL.Add(
              'SELECT '+
              'P.CD_BARRAS, '+
              'A.DS_ARTIGO '+
              ' '+
              'FROM PRODUTOS P '+
              ' '+
              'INNER JOIN ARTIGOS A ON '+
              'A.CD_ARTIGO = P.CD_ARTIGO '+
              ' '+
              'WHERE P.CD_BARRAS = :CD_BARRAS '
              );

      ParamByName('CD_BARRAS').AsString:=edtInventarioCodigoBarras.Text;
      Open();

      if RecordCount > 0 then
        edtCodigoBarrasDescricao.Text:=FieldByName('DS_ARTIGO').Text
        else
    end;

    FreeAndNil(FDQGravar);
    FreeAndNil(Conexao);

  except on E: Exception do
    begin
      ShowMessage(E.Message);
      FreeAndNil(FDQGravar);
      FreeAndNil(Conexao);
    end;
  end;
end;

procedure TfrmCadastroProdutos.edtInventarioCodigoBarrasInventarioChange(
  Sender: TObject);
var
  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin
  try
    Conexao:=TZConnection.Create(Nil);
    DM.ConectarBanco(Conexao);

    FDQGravar:=TZQuery.Create(Nil);
    FDQGravar.Connection:=Conexao;

    with FDQGravar do
    begin
      Close;
      SQL.Clear;
      SQL.Add(
              'SELECT '+
              'P.CD_PRODUTO, '+
              'P.CD_BARRAS, '+
              'P.CD_ARTIGO, '+
              'A.DS_ARTIGO '+
              ' '+
              'FROM PRODUTOS P '+
              ' '+
              'INNER JOIN ARTIGOS A ON '+
              'A.CD_ARTIGO = P.CD_ARTIGO '+
              ' '+
              'WHERE P.CD_BARRAS = :CD_BARRAS '
              );

      ParamByName('CD_BARRAS').AsString:=edtInventarioCodigoBarrasInventario.Text;
      Open();

      if RecordCount > 0 then
      begin
        edtInventarioDescricaoArtigo.Text:=FieldByName('DS_ARTIGO').Text;
      end;
    end;

    FreeAndNil(FDQGravar);
    FreeAndNil(Conexao);

  except on E: Exception do
    begin
      ShowMessage(E.Message);
      FreeAndNil(FDQGravar);
      FreeAndNil(Conexao);
    end;
  end;
end;

procedure TfrmCadastroProdutos.Editar1Click(Sender: TObject);
begin
  btnAdicionar.Caption:='Atualizar';

  with FDMemTableCadastro do
  begin
     edtCodigoBarras.Text         :=  FieldByName('CD_BARRAS').AsString;
     edtCodigoTipoProduto.Text    :=  FieldByName('CD_TIPO_PRODUTO').AsString;
     edtDescricaoTipoProduto.Text :=  FieldByName('DS_TIPO_PRODUTO').AsString;
     edtCodigoMarca.Text          :=  FieldByName('CD_MARCA').AsString;
     edtDescricaoMarca.Text       :=  FieldByName('DS_MARCA').AsString;
     edtCodigoFornecedor.Text     :=  FieldByName('CD_FORNECEDOR').AsString;
     edtDescricaoFornecedor.Text  :=  FieldByName('DS_FORNECEDOR').AsString;
     edtCodigoBarras.SetFocus;
  end;
end;

procedure TfrmCadastroProdutos.Editarartigo1Click(Sender: TObject);
begin
  LimparCampos;

  edtCodigoProduto.Text     :=  BufTableListagemCD_CADASTRO.Text;
  edtDescricaoProduto.Text  :=  BufTableListagemDS_CADASTRO.Text;

  ListarCodigoBarras;

  PageControl1.ActivePage:=tabCadastroProduto;
end;

procedure TfrmCadastroProdutos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
  frmCadastroProdutos:=Nil;
end;

procedure TfrmCadastroProdutos.FormCreate(Sender: TObject);
begin
  OcultarSheets(PageControl1);
  ListarCampos(BufTableListagem, '');
  ListarSetores;
  lblQuantidadeArtigos.Caption        :=  BufTableListagem.RecordCount.ToString + ' Artigo(s)';
  lblQuantidadeInventariada.Caption   :=  'Qtde Inventariada: ' +
                                          FDMemTableInventario.FieldByName('QT_INVENTARIADA').AsString;

end;

procedure TfrmCadastroProdutos.LimparCampos;
begin
  edtCodigoProduto.Text:='';
  edtDescricaoProduto.Text:='';
  edtCodigoBarras.Text:='';
  edtDescricaoFornecedor.Text:='';
  edtDescricaoTipoProduto.Text:='';
  edtDescricaoMarca.Text:='';
  edtCodigoTipoProduto.Text:='';
  edtCodigoMarca.Text:='';
  edtCodigoFornecedor.Text:='';
end;

procedure TfrmCadastroProdutos.LimparCamposInventario;
begin

end;

procedure TfrmCadastroProdutos.Limparfiltro1Click(Sender: TObject);
begin
  FDMemTableCadastro.Filtered:=False;
end;

procedure TfrmCadastroProdutos.ListarCampos(FDMemTable: TBufDataset; ORDENACAO: String);
var
  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin
  FDMemTable.Close;
  FDMemTable.CreateDataSet;
  try
    Conexao:=TZConnection.Create(Nil);
    DM.ConectarBanco(Conexao);

    FDQGravar:=TZQuery.Create(Nil);
    FDQGravar.Connection:=Conexao;

    with FDQGravar do
    begin
      Close;
      SQL.Clear;
      SQL.Add(
              'SELECT '+
              'A.CD_ARTIGO, '+
              'A.DS_ARTIGO, '+
              'A.QT_ARTIGO, '+
              'COUNT(I.CD_BARRAS) QTDE '+
              'FROM ARTIGOS A '+
              ' '+
              'LEFT JOIN INVENTARIO I ON A.CD_ARTIGO = I.CD_ARTIGO '+

              'GROUP BY '+
              'A.CD_ARTIGO, '+
              'A.DS_ARTIGO, '+
              'A.QT_ARTIGO '+
              '  '+
              'ORDER BY DS_ARTIGO '

              + ORDENACAO
              );
      Open();

      First;
      if RecordCount > 0 then
      begin
        DisableControls;
        FDMemTable.DisableControls;
        while not Eof do
        begin
          FDMemTable.Append;
          FDMemTable.FieldByName('CD_CADASTRO').AsString  :=  FieldByName('CD_ARTIGO').AsString;
          FDMemTable.FieldByName('DS_CADASTRO').AsString  :=  FieldByName('DS_ARTIGO').AsString;
          FDMemTable.FieldByName('TOTAL').AsString        :=  FieldByName('QT_ARTIGO').AsString;
          FDMemTable.FieldByName('CONTAGEM1').AsString    :=  FieldByName('QTDE').AsString;
          FDMemTable.Post;
          Next
        end;
        EnableControls;
        FDMemTable.EnableControls;
      end;

      FDMemTable.First;
    end;

    FreeAndNil(FDQGravar);
    FreeAndNil(Conexao);

  except on E: Exception do
    begin
      ShowMessage(E.Message);
      FreeAndNil(FDQGravar);
      FreeAndNil(Conexao);
    end;
  end;
end;

procedure TfrmCadastroProdutos.ListarCodigoBarras;
var
  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin
  FDMemTableCadastro.Close;
  FDMemTableCadastro.CreateDataSet;

  try
    Conexao:=TZConnection.Create(Nil);
    DM.ConectarBanco(Conexao);

    FDQGravar:=TZQuery.Create(Nil);
    FDQGravar.Connection:=Conexao;

    with FDQGravar do
    begin
      Close;
      SQL.Clear;
      SQL.Add(
              'SELECT '+
              'A.CD_ARTIGO, '+
              'A.DS_ARTIGO, '+
              'P.CD_PRODUTO, '+
              'P.CD_BARRAS, '+
              'T.DS_TP_AQUISICAO, '+
              'M.DS_MARCA, '+
              'F.NM_FANTASIA, '+
              'CASE WHEN P.IN_ATIVO = ''S'' THEN ''ATIVO'' ELSE ''INATIVO'' END SITUACAO '+
              ' '+
              'FROM ARTIGOS A '+
              ' '+
              'INNER JOIN PRODUTOS P ON '+
              'P.CD_ARTIGO = A.CD_ARTIGO '+
              ' '+
              'INNER JOIN TP_AQUISICAO T ON '+
              'T.CD_TP_AQUISICAO = P.CD_TP_AQUISICAO '+
              ' '+
              'INNER JOIN MARCA M ON '+
              'M.CD_MARCA = P.CD_MARCA '+
              ' '+
              'INNER JOIN FORNECEDORES F ON '+
              'F.CD_FORNECEDORES = P.CD_FORNECEDORES '+
              ' '+
              'WHERE A.CD_ARTIGO = :CD_ARTIGO '+
              'AND P.IN_ATIVO = ''S'' '
              );
      ParamByName('CD_ARTIGO').AsInteger:=BufTableListagemCD_CADASTRO.AsInteger;
      Open();

      First;
      if RecordCount > 0 then
      begin
        DisableControls;
        FDMemTableCadastro.DisableControls;
        while not Eof do
        begin
          FDMemTableCadastro.Append;
          FDMemTableCadastro.FieldByName('CD_BARRAS').AsString        :=  FieldByName('CD_BARRAS').AsString;
          FDMemTableCadastro.FieldByName('DS_TIPO_PRODUTO').AsString  :=  FieldByName('DS_TP_AQUISICAO').AsString;
          FDMemTableCadastro.FieldByName('DS_MARCA').AsString         :=  FieldByName('DS_MARCA').AsString;
          FDMemTableCadastro.FieldByName('DS_FORNECEDOR').AsString    :=  FieldByName('NM_FANTASIA').AsString;
          FDMemTableCadastro.FieldByName('SITUACAO').AsString         :=  FieldByName('SITUACAO').AsString;
          FDMemTableCadastro.Post;
          Next
        end;
        EnableControls;
        FDMemTableCadastro.EnableControls;
      end;

      FDMemTableCadastro.First;

    end;

    FreeAndNil(FDQGravar);
    FreeAndNil(Conexao);

  except on E: Exception do
    begin
      ShowMessage(E.Message);
      FreeAndNil(FDQGravar);
      FreeAndNil(Conexao);
    end;
  end;
end;

procedure TfrmCadastroProdutos.ListarContagem;
var
  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin
  FDMemTableCodigoBarras.Close;
  FDMemTableCodigoBarras.CreateDataSet;

  FDMemTableCodigoBarras2.Close;
  FDMemTableCodigoBarras2.CreateDataSet;

  try
    Conexao:=TZConnection.Create(Nil);
    DM.ConectarBanco(Conexao);

    FDQGravar:=TZQuery.Create(Nil);
    FDQGravar.Connection:=Conexao;

    with FDQGravar do
    begin
      Close;
      SQL.Clear;
      SQL.Add(
              'SELECT '+
              'I.CD_ARTIGO, '+
              'I.CD_BARRAS, '+
              'A.DS_ARTIGO DS_TIPO_PRODUTO, '+
              'I.QT_ARTIGO, '+
              'I.CONTAGEM_1 QUANTIDADE '+
              ' '+
              'FROM PRODUTOS P '+
              ' '+
              'LEFT JOIN INVENTARIO I ON P.CD_BARRAS = I.CD_BARRAS '+
              'LEFT JOIN ARTIGOS A ON I.CD_ARTIGO = A.CD_ARTIGO '+
              ' '+
              'WHERE I.CD_BARRAS IS NOT NULL AND P.IN_ATIVO = ''S'' '
              );
      Open();

      First;
      DisableControls;
      FDMemTableCodigoBarras.DisableControls;
      FDMemTableCodigoBarras2.DisableControls;

      while not Eof do
      begin
        FDMemTableCodigoBarras.Append;
        FDMemTableCodigoBarras.FieldByName('CD_ARTIGO').AsString :=  FieldByName('CD_ARTIGO').AsString;
        FDMemTableCodigoBarras.FieldByName('CD_BARRAS').AsString :=  FieldByName('CD_BARRAS').AsString;
        FDMemTableCodigoBarras.FieldByName('DS_TIPO_PRODUTO').AsString :=  FieldByName('DS_TIPO_PRODUTO').AsString;
        FDMemTableCodigoBarras.FieldByName('QUANTIDADE').AsString :=  FieldByName('QUANTIDADE').AsString;
        FDMemTableCodigoBarras.Post;

        FDMemTableCodigoBarras2.Append;
        FDMemTableCodigoBarras2.FieldByName('CD_ARTIGO').AsString :=  FieldByName('CD_ARTIGO').AsString;
        FDMemTableCodigoBarras2.FieldByName('CD_BARRAS').AsString :=  FieldByName('CD_BARRAS').AsString;
        FDMemTableCodigoBarras2.FieldByName('DS_TIPO_PRODUTO').AsString :=  FieldByName('DS_TIPO_PRODUTO').AsString;
        FDMemTableCodigoBarras2.FieldByName('QUANTIDADE').AsString :=  FieldByName('QUANTIDADE').AsString;
        FDMemTableCodigoBarras2.Post;

        Next;
      end;

      FDMemTableCodigoBarras.EnableControls;
      FDMemTableCodigoBarras2.EnableControls;
    end;

    FreeAndNil(FDQGravar);
    FreeAndNil(Conexao);

  except on E: Exception do
    begin
      ShowMessage(E.Message);
      FreeAndNil(FDQGravar);
      FreeAndNil(Conexao);
    end;
  end;
end;

procedure TfrmCadastroProdutos.ListarSetores;
var
  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin
  //try
  //  Conexao:=TZConnection.Create(Nil);
  //  DM.ConectarBanco(Conexao);
  //
  //  FDQGravar:=TZQuery.Create(Nil);
  //  FDQGravar.Connection:=Conexao;
  //  with FDQGravar do
  //  begin
  //    Close;
  //    SQL.Clear;
  //    SQL.Add(
  //            'SELECT * FROM DESTINOS '+
  //            'ORDER BY DS_DESTINOS'
  //            );
  //    Open();
  //
  //    if RecordCount > 0 then
  //    begin
  //      FDMemTableSetores.Close;
  //      FDMemTableSetores.CreateDataSet;
  //
  //      First;
  //      DisableControls;
  //      while not Eof do
  //      begin
  //        FDMemTableSetores.Append;
  //        FDMemTableSetores.FieldByName('CD_DESTINOS').AsInteger :=  FieldByName('CD_DESTINOS').AsInteger;
  //        FDMemTableSetores.FieldByName('DS_DESTINOS').AsString  :=  FieldByName('DS_DESTINOS').AsString;
  //        FDMemTableSetores.Post;
  //        Next;
  //      end;
  //      FDMemTableSetores.First;
  //      First;
  //      EnableControls;
  //    end;
  //  end;
  //
  //  FreeAndNil(FDQGravar);
  //  FreeAndNil(Conexao);
  //  DM.frxDBDataset1.DataSet:=DM.FDQuery1;
  //
  //except on E: Exception do
  //  begin
  //    ShowMessage(E.Message);
  //    FreeAndNil(FDQGravar);
  //    FreeAndNil(Conexao);
  //  end;
  //end;
end;

procedure TfrmCadastroProdutos.OcultarSheets(PageControl: TPageControl);
var
  iPage: Integer;
begin
  for iPage := 0 to PageControl.PageCount - 1 do
    PageControl.Pages[iPage].TabVisible := False;

  if ( PageControl.PageCount > 0 ) then
    PageControl.ActivePage := PageControl.Pages[0];
end;

procedure TfrmCadastroProdutos.SalvarDados;
var
  CODIGO: String;
  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin
  try
    Conexao:=TZConnection.Create(Nil);
    DM.ConectarBanco(Conexao);

    FDQGravar:=TZQuery.Create(Nil);
    FDQGravar.Connection:=Conexao;

    if FDMemTableCadastro.RecordCount > 0 then
    begin

      with FDQGravar do
      begin
        //Define o código do produto na base de dados
        Close;
        SQL.Clear;
        SQL.Add('SELECT MAX(CD_PRODUTO) CD_PRODUTO '+
                'FROM PRODUTOS ');
        Open();

        CODIGO:=FieldByName('CD_PRODUTO').AsString;

        //Gravar na base de dados
        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO PRODUTOS '+
                'VALUES('+
                ':CD_PRODUTO, '+
                ':CD_ARTIGO, '+
                ':CD_FORNECEDORES, '+
                ':CD_MARCA, '+
                ':DT_ENTRADA_NF, '+
                ':NR_NOTA_FISCAL, '+
                ':VL_UNITARIO_NF, '+
                ':QT_PRODUTO_NF, '+
                ':DT_ENTRADA, '+
                ':CD_DESTINOS, '+
                ':CD_FUNCIONARIO, '+
                ':CD_TP_AQUISICAO, '+
                ':DT_BAIXA, '+
                ':CD_MOTIVO_BAIXA, '+
                ':IN_ATIVO, '+
                ':CD_BARRAS, '+
                ':CD_DESTINOS_ULTIMO, '+
                ':DT_DESTINOS_ULTIMO) ');

        ParamByName('CD_PRODUTO').AsInteger           :=  StrToIntDef(CODIGO, 0) + 1;
        ParamByName('CD_ARTIGO').AsInteger            :=  StrToInt(edtCodigoProduto.Text);
        ParamByName('CD_FORNECEDORES').AsInteger      :=  StrToInt(edtCodigoFornecedor.Text);
        ParamByName('CD_MARCA').AsInteger             :=  StrToInt(edtCodigoMarca.Text);
        ParamByName('DT_ENTRADA_NF').IsNull;
        ParamByName('NR_NOTA_FISCAL').IsNull;
        ParamByName('VL_UNITARIO_NF').IsNull;
        ParamByName('QT_PRODUTO_NF').IsNull;
        ParamByName('DT_ENTRADA').AsDateTime          :=  Now;
//        ParamByName('CD_DESTINOS').AsInteger          :=  FDMemTableSetores.FieldByName('CD_DESTINOS').AsInteger;
        ParamByName('CD_FUNCIONARIO').AsInteger       :=  StrToIntDef(CD_USUARIO, -1);
        ParamByName('CD_TP_AQUISICAO').AsInteger      :=  StrToInt(edtCodigoTipoProduto.Text);
        ParamByName('DT_BAIXA').IsNull;
        ParamByName('CD_MOTIVO_BAIXA').IsNull;
        ParamByName('IN_ATIVO').AsString              :=  'S';
        ParamByName('CD_BARRAS').AsString             :=  edtCodigoBarras.Text;
//        ParamByName('CD_DESTINOS_ULTIMO').AsInteger   :=  FDMemTableSetores.FieldByName('CD_DESTINOS').AsInteger;
        ParamByName('DT_DESTINOS_ULTIMO').AsDateTime  :=  Now;
        ExecSQL;
      end;
    end;

    FreeAndNil(FDQGravar);
    FreeAndNil(Conexao);

  except on E: Exception do
    begin
      ShowMessage(E.Message);
      FreeAndNil(FDQGravar);
      FreeAndNil(Conexao);
    end;
  end;
end;

procedure TfrmCadastroProdutos.SalvarContagemInventario;
var
  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin
  try
    Conexao:=TZConnection.Create(Nil);
    DM.ConectarBanco(Conexao);

    FDQGravar:=TZQuery.Create(Nil);
    FDQGravar.Connection:=Conexao;

    with FDQGravar do
    begin
//      Close;
//      SQL.Clear;
//      SQL.Add('DELETE FROM INVENTARIO');
//      ExecSQL;

      DisableControls;
      FDMemTableCodigoBarras2.First;
      FDMemTableCodigoBarras2.DisableControls;
      while not FDMemTableCodigoBarras2.Eof do
      begin
        try
          Close;
          SQL.Clear;
          SQL.Add('INSERT INTO INVENTARIO( '+
                  'CD_PRODUTO, '+
                  'CD_USUARIO, '+
                  'DT_INVENTARIO, '+
                  'CD_BARRAS, '+
                  'NR_INVENTARIO, '+
                  'CD_ARTIGO, '+
                  'QT_ARTIGO, '+
                  'CONTAGEM_1, '+
                  'CONTAGEM_2, '+
                  'CONTAGEM_3) '+

                  'VALUES( '+
                  ':CD_PRODUTO, '+
                  ':CD_USUARIO, '+
                  ':DT_INVENTARIO, '+
                  ':CD_BARRAS, '+
                  ':NR_INVENTARIO, '+
                  ':CD_ARTIGO, '+
                  ':QT_ARTIGO, '+
                  ':CONTAGEM_1, '+
                  ':CONTAGEM_2, '+
                  ':CONTAGEM_3) '
                  );

          ParamByName('CD_PRODUTO').AsString        :=  FDMemTableCodigoBarras2.FieldByName('CD_PRODUTO').AsString;
          ParamByName('CD_USUARIO').AsInteger       :=  StrToIntDef(CD_USUARIO, 0);
          ParamByName('DT_INVENTARIO').AsDateTime   :=  Now;
          ParamByName('CD_BARRAS').AsString         :=  FDMemTableCodigoBarras2.FieldByName('CD_BARRAS').AsString;
          ParamByName('NR_INVENTARIO').AsInteger    :=  NR_INVENTARIO;
          ParamByName('CD_ARTIGO').AsString         :=  FDMemTableCodigoBarras2.FieldByName('CD_ARTIGO').AsString;
          ParamByName('QT_ARTIGO').IsNull;
          ParamByName('CONTAGEM_1').AsString        :=  FDMemTableCodigoBarras2.FieldByName('QUANTIDADE').AsString;
          ParamByName('CONTAGEM_2').IsNull;
          ParamByName('CONTAGEM_3').IsNull;
          ExecSQL;
          FDMemTableCodigoBarras2.Next;

        except on E: Exception do
          begin
            //ShowMessage('Error ' + E.Message);
            FDMemTableCodigoBarras2.Next;
          end;
        end;
      end;

      FDMemTableCodigoBarras2.First;
      FDMemTableCodigoBarras2.EnableControls;
      EnableControls;
      ShowMessage('Dados salvos com sucesso.');
    end;

    FreeAndNil(FDQGravar);
    FreeAndNil(Conexao);

  except on E: Exception do
    begin
      //ShowMessage(E.Message);
      FreeAndNil(FDQGravar);
      FreeAndNil(Conexao);
    end;
  end;
end;

procedure TfrmCadastroProdutos.AtualizarArtigo(QT_ARTIGO, CD_ARTIGO: String);
var
  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin
  try
    Conexao:=TZConnection.Create(Nil);
    DM.ConectarBanco(Conexao);

    FDQGravar:=TZQuery.Create(Nil);
    FDQGravar.Connection:=Conexao;

    with FDQGravar do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE ARTIGOS '+
              'SET '+
              'QT_ARTIGO =:QT_ARTIGO '+
              'WHERE CD_ARTIGO = :CD_ARTIGO ');

      ParamByName('CD_ARTIGO').AsString     :=  CD_ARTIGO;
      ParamByName('QT_ARTIGO').AsString     :=  QT_ARTIGO;
      ExecSQL;
    end;

    FreeAndNil(FDQGravar);
    FreeAndNil(Conexao);

  except on E: Exception do
    begin
      ShowMessage(E.Message);
      FreeAndNil(FDQGravar);
      FreeAndNil(Conexao);
    end;
  end;
end;

procedure TfrmCadastroProdutos.Salvarquantidades1Click(Sender: TObject);
begin
  with BufTableListagem do
  begin
    First;
    if RecordCount > 0 then
    begin
      DisableControls;
      while not Eof do
      begin
        AtualizarArtigo(FieldByName('TOTAL').AsString,
                         FieldByName('CD_CADASTRO').AsString);
        Next
      end;
    end;
      EnableControls;
      First;
  end;
end;

procedure TfrmCadastroProdutos.SelecionarCadastro;
begin
  if not Assigned(frmSelecionarCadastro) then
  begin
    frmSelecionarCadastro:=TfrmSelecionarCadastro.Create(nil);
    with frmSelecionarCadastro do
    begin
      ShowModal;
    end;
  end;
end;

procedure TfrmCadastroProdutos.SituacaoArtigo(SITUACAO: String);
var
  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin
  try
    Conexao:=TZConnection.Create(Nil);
    DM.ConectarBanco(Conexao);

    FDQGravar:=TZQuery.Create(Nil);
    FDQGravar.Connection:=Conexao;

    with FDQGravar do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE PRODUTOS '+
              'SET '+
              'DT_BAIXA = :DT_BAIXA, '+
              'IN_ATIVO = :IN_ATIVO '+
              'WHERE CD_BARRAS = :CD_BARRAS ');

      ParamByName('DT_BAIXA').AsDateTime  :=  Now;
      ParamByName('CD_BARRAS').AsString   :=  FDMemTableCadastro.FieldByName('CD_BARRAS').AsString;
      ParamByName('IN_ATIVO').AsString    :=  SITUACAO;
      ExecSQL;
    end;

    FreeAndNil(FDQGravar);
    FreeAndNil(Conexao);

  except on E: Exception do
    begin
      ShowMessage(E.Message);
      FreeAndNil(FDQGravar);
      FreeAndNil(Conexao);
    end;
  end;
end;

procedure TfrmCadastroProdutos.SpeedButton2Click(Sender: TObject);
begin
  SQL_PESQUISA                  :=  TControl(Sender).Hint;

  SelecionarCadastro;

  if TControl(Sender).Tag = 0 then
  begin
    edtCodigoTipoProduto.Text     :=  CD_CADASTRO;
    edtDescricaoTipoProduto.Text  :=  DS_CADASTRO;
  end else
    if TControl(Sender).Tag = 1 then
    begin
      edtCodigoMarca.Text     :=  CD_CADASTRO;
      edtDescricaoMarca.Text  :=  DS_CADASTRO;
    end else
      if TControl(Sender).Tag = 2 then
      begin
        edtCodigoFornecedor.Text     :=  CD_CADASTRO;
        edtDescricaoFornecedor.Text  :=  DS_CADASTRO;
      end;
end;

procedure TfrmCadastroProdutos.Zerarquantidades1Click(Sender: TObject);
begin
  with BufTableListagem do
  begin
    First;
    if RecordCount > 0 then
    begin
      DisableControls;
      while not Eof do
      begin
        Edit;
        FieldByName('TOTAL').AsString:='0';
        Post;
        Next
      end;
      EnableControls;
      First;
    end;
  end;
end;

end.
