unit untCadastroMarca;

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
  untPadrao,
  DB;

type

		{ TfrmCadastroMarca }

  TfrmCadastroMarca = class(TfrmPadrao)
    procedure btnSalvarClick(Sender: TObject);
				procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroMarca: TfrmCadastroMarca;

implementation

{$IFnDEF FPC}
  {$R *.dfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

procedure TfrmCadastroMarca.btnSalvarClick(Sender: TObject);
var
  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin
  inherited;

  try
    Conexao:=TZConnection.Create(Nil);
    DM.ConectarBanco(Conexao);

    FDQGravar:=TZQuery.Create(Nil);
    FDQGravar.Connection:=Conexao;

    if btnSalvar.Caption = 'Salvar' then
    begin
      if Trim(edtDescricao.Text) = '' then
      ShowMessage('Digite uma descrição antes de prosseguir.')
      else
      begin
        with DM.ZQuery1 do
        begin
          Gravar('INSERT INTO MARCA (DS_MARCA) '+
                  'VALUES( '+
                  QuotedStr(edtDescricao.Text) + ')');

          edtCodigo.Text     :='';
          edtDescricao.Text  :='';
          ShowMessage('Gravado com sucesso.');
        end;
      end;
    end;

    if btnSalvar.Caption = 'Atualizar' then
    begin
      with FDQGravar do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM MARCA '+
                'WHERE CD_MARCA = ' + QuotedStr(edtCodigo.Text));
        Open();

        if FieldByName('DS_MARCA').AsString <> edtDescricao.Text then
        begin
          SQL.Clear;
          SQL.Add('UPDATE MARCA '+
                  'SET '+
                  'DS_MARCA = ' + QuotedStr(edtDescricao.Text) +
                  'WHERE CD_MARCA = ' + QuotedStr(edtCodigo.Text));
            ExecSQL;
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

procedure TfrmCadastroMarca.FormCreate(Sender: TObject);
begin
  inherited;
    Listar('SELECT CD_MARCA CD_CADASTRO, '+
           'DS_MARCA DS_CADASTRO FROM MARCA '+
           'ORDER BY DS_MARCA');
end;

end.
