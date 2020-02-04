unit untCadastroSalaAmbulatorio;

{$mode delphi}

interface

uses  
	  untDM,
	  ZDataset,
   Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

			{ TfrmCadastroSalaAmbulatorio }

   TfrmCadastroSalaAmbulatorio = class(TForm)
						btnImprimir: TBitBtn;
						btnNovo: TBitBtn;
						btnSalvar: TBitBtn;
						edtCodigoUnidade: TEdit;
						edtDescricaoUnidade: TEdit;
						Label1: TLabel;
						Label2: TLabel;
						procedure btnSalvarClick(Sender: TObject);
						procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
   private

   public
      procedure GravarRegistro(aTipoRegistro: String);

   end;

var
   frmCadastroSalaAmbulatorio: TfrmCadastroSalaAmbulatorio;

implementation

{$R *.lfm}

{ TfrmCadastroSalaAmbulatorio }

procedure TfrmCadastroSalaAmbulatorio.btnSalvarClick(Sender: TObject);
begin
  if edtDescricaoUnidade.Text = '' then
  begin
    MessageDlg('Descrição é um campo obrigatório', mtInformation, [mbOk], 0);
    edtDescricaoUnidade.SetFocus;
    Abort;
  end;

  try
     {chama a procedure para salvar os dados no banco de dados}
     GravarRegistro('Insert');
     MessageDlg('Registro salvo com sucesso', mtInformation, [mbOk], 0);

     {trata excessão no código acima - em caso de erro passa aki}
  except on e:exception do
        MessageDlg(e.message, mtError, [mbOk], 0);
  end;
end;

procedure TfrmCadastroSalaAmbulatorio.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

procedure TfrmCadastroSalaAmbulatorio.GravarRegistro(aTipoRegistro: String);
var
   zSQL: TZQuery;
begin
   {modifica os registros no clientDataSet e salva banco atraves do applyUpdates}
   try
      //zConexao:=TZConnection.Create(Nil);
      zSQL:=TZQuery.Create(Nil);
      zSQL.Connection:=DM.ZConnection1;

      with zSQL do
      begin
         if aTipoRegistro = 'Insert' then
         begin
            edtCodigoUnidade.Text:=IntToStr(DM.GetGenerator('CD_SALA', 'SALA'));

            {coloca o componente em modo de edição}
            Close;
            SQL.Clear;
            SQL.Add(
                    'INSERT INTO SALA( '+
                    'CD_SALA, '+
                    'DS_SALA) '+

                    'VALUES('+
                    ':CD_SALA, '+
                    ':DS_SALA) '
            );
            ParamByName('CD_SALA').AsInteger  :=	StrToInt(edtCodigoUnidade.Text);
            ParamByName('DS_SALA').AsString 		:=	edtDescricaoUnidade.Text;

            {escreve a modificação no registro}
            ExecSQL;

            edtDescricaoUnidade.Text     :='';
            edtCodigoUnidade.Text        :='';

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
      except on  e: exception do
      begin
         messageDlg('Não foi possível salvar registro' + E.Message, mtError, [mbOk], 0);
         FreeAndNil(zSQL);
      end;
   end;
end;

end.

