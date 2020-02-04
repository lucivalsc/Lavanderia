unit untQuarto;

{$mode delphi}

interface

uses
  DB,
  untDM,
  //ZDataset,
  untArquivo, Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
		Buttons, ZDataset;

type

  { TfrmQuarto }

  TfrmQuarto = class(TForm)
    btnImprimir: TBitBtn;
    btnNovo: TBitBtn;
    btnSalvar: TBitBtn;
    cbUnidade: TComboBox;
    cbTipoQuarto: TComboBox;
    edtNumeroQuarto: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure btnSalvarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormResize(Sender: TObject);
  private

  public
    procedure PreencherComboBox;
    procedure GravarRegistro(aTipoRegistro: string);

  end;

var
  frmQuarto: TfrmQuarto;

implementation

{$R *.lfm}

{ TfrmQuarto }

procedure TfrmQuarto.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TfrmQuarto.btnSalvarClick(Sender: TObject);
begin
  //if edtDescricaoUnidade.Text = '' then
  //begin
  //  MessageDlg('Descrição é um campo obrigatório', mtInformation, [mbOk], 0);
  //  edtDescricaoUnidade.SetFocus;
  //  Abort;
  //end;
  //if edtQuantidadeLeitos.Text = '' then
  //begin
  //  MessageDlg('Quantidade de leitos é um campo obrigatório', mtInformation, [mbOk], 0);
  //  edtCodigoUnidade.SetFocus;
  //  Abort;
  //end;
  try
    {chama a procedure para salvar os dados no banco de dados}
    GravarRegistro('Insert');
    MessageDlg('Registro salvo com sucesso', mtInformation, [mbOK], 0);

    {trata excessão no código acima - em caso de erro passa aki}
  except
    on e: Exception do
      MessageDlg(e.message, mtError, [mbOK], 0);
  end;
end;

procedure TfrmQuarto.FormResize(Sender: TObject);
begin
  PreencherComboBox;
end;

procedure TfrmQuarto.PreencherComboBox;
var
  I: integer;
begin
  for I := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TComboBox then
    begin
      if (Components[I] as TComboBox).Hint <> '' then
      begin
        TArquivo.ListarDadosComboBox((Components[I] as TComboBox),
          'SELECT ' +
          'CD_' + (Components[I] as TComboBox).Hint +
          ' CD_PADRAO, ' + 'DS_' +
          (Components[I] as TComboBox).Hint + ' DS_PADRAO ' +
          'FROM ' + (Components[I] as TComboBox).Hint);
      end;
    end;
  end;
end;

procedure TfrmQuarto.GravarRegistro(aTipoRegistro: string);
var
  zSQL: TZQuery;
begin
  {modifica os registros no clientDataSet e salva banco atraves do applyUpdates}
  try
    //zConexao:=TZConnection.Create(Nil);
    zSQL := TZQuery.Create(nil);
    zSQL.Connection := DM.ZConnection1;

    with zSQL do
    begin
      if aTipoRegistro = 'Insert' then
      begin

        {coloca o componente em modo de edição}
        Close;
        SQL.Clear;
        SQL.Add(
          'INSERT INTO QUARTO( ' + 'CD_UNIDADE_HOSPITALAR, ' +
          'CD_QUARTO, ' + 'DS_QUARTO, ' +
          'TIPO_QUARTO) ' + 'VALUES(' +
          ':CD_UNIDADE_HOSPITALAR, ' + ':CD_QUARTO, ' +
          ':DS_QUARTO, ' + ':TIPO_QUARTO) '
          );
        ParamByName('CD_UNIDADE_HOSPITALAR').AsInteger :=
          DM.ComboBoxRetornar(cbUnidade);
        ParamByName('CD_QUARTO').AsInteger :=
          DM.GetGenerator('CD_QUARTO', 'QUARTO');
        ParamByName('DS_QUARTO').AsString := edtNumeroQuarto.Text;
        ParamByName('TIPO_QUARTO').AsInteger := cbTipoQuarto.ItemIndex;

        {escreve a modificação no registro}
        ExecSQL;

        edtNumeroQuarto.Text := '';

      end;

      if aTipoRegistro = 'Update' then
      begin
        {coloca o componente em modo de edição}
        //Close;
        //SQL.Clear;
        //SQL.Add('UPDATE MEDICO SET '+
        //        'CD_USUARIO =           :CD_USUARIO, ' +
        //        'IN_ATIVO =             :IN_ATIVO ' +
        //        'WHERE CD_MEDICO = :CD_MEDICO ');

        {atualiza os valores dos campos no componente}

        {escreve a modificação no registro}
        ExecSQL;
      end;
    end;

    FreeAndNil(zSQL);

    {trata excessão no código acima - em caso de erro passa aki}
  except
    on  e: Exception do
    begin
      messageDlg('Não foi possível salvar registro' + E.Message,
        mtError, [mbOK], 0);
      FreeAndNil(zSQL);
    end;
  end;
end;

end.
