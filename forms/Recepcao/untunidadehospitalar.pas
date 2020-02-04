unit untUnidadeHospitalar;

{$mode delphi}

interface

uses
  DB,
  untDM,
  //ZDataset,
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, ZDataset;

type

  { TfrmUnidadeHospitalar }

  TfrmUnidadeHospitalar = class(TForm)
    btnImprimir: TBitBtn;
    btnNovo: TBitBtn;
    btnSalvar: TBitBtn;
    edtCodigoUnidade: TEdit;
    edtDescricaoUnidade: TEdit;
    edtQuantidadeLeitos: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure btnSalvarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public
    procedure GravarRegistro(aTipoRegistro: string);
  end;

var
  frmUnidadeHospitalar: TfrmUnidadeHospitalar;

implementation

{$R *.lfm}

{ TfrmUnidadeHospitalar }

procedure TfrmUnidadeHospitalar.btnSalvarClick(Sender: TObject);
begin
  if edtDescricaoUnidade.Text = '' then
  begin
    MessageDlg('Descrição é um campo obrigatório', mtInformation, [mbOK], 0);
    edtDescricaoUnidade.SetFocus;
    Abort;
  end;
  if edtQuantidadeLeitos.Text = '' then
  begin
    MessageDlg('Quantidade de leitos é um campo obrigatório',
      mtInformation, [mbOK], 0);
    edtCodigoUnidade.SetFocus;
    Abort;
  end;
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

procedure TfrmUnidadeHospitalar.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TfrmUnidadeHospitalar.GravarRegistro(aTipoRegistro: string);
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
        edtCodigoUnidade.Text :=
          IntToStr(DM.GetGenerator('CD_UNIDADE_HOSPITALAR', 'UNIDADE_HOSPITALAR'));

        {coloca o componente em modo de edição}
        Close;
        SQL.Clear;
        SQL.Add(
          'INSERT INTO UNIDADE_HOSPITALAR( ' +
          'CD_UNIDADE_HOSPITALAR, ' +
          'DS_UNIDADE_HOSPITALAR, ' + 'QT_LEITOS) ' +
          'VALUES(' + ':CD_UNIDADE_HOSPITALAR, ' +
          ':DS_UNIDADE_HOSPITALAR, ' + ':QT_LEITOS) '
          );
        ParamByName('CD_UNIDADE_HOSPITALAR').AsInteger :=
          StrToInt(edtCodigoUnidade.Text);
        ParamByName('DS_UNIDADE_HOSPITALAR').AsString := edtDescricaoUnidade.Text;
        ParamByName('QT_LEITOS').AsInteger :=
          StrToInt(edtQuantidadeLeitos.Text);

        {escreve a modificação no registro}
        ExecSQL;

        edtDescricaoUnidade.Text := '';
        edtCodigoUnidade.Text := '';
        edtQuantidadeLeitos.Text := '';

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
