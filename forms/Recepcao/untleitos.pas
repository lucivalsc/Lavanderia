unit untLeitos;

{$mode delphi}

interface

uses
	  //ZDataset,
	  untDM, untArquivo, Classes, SysUtils, Forms, Controls, Graphics, Dialogs,
			StdCtrls, Buttons, ZDataset;

type

		{ TfrmLeitos }

    TfrmLeitos = class(TForm)
				btnImprimir: TBitBtn;
				btnNovo: TBitBtn;
				btnSalvar: TBitBtn;
				cbUnidade: TComboBox;
				cbQuarto: TComboBox;
				cbSituacao: TComboBox;
				edtLeito: TEdit;
				Label1: TLabel;
				Label3: TLabel;
				Label4: TLabel;
				Label5: TLabel;
				procedure btnSalvarClick(Sender: TObject);
    procedure cbUnidadeChange(Sender: TObject);
				procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
				procedure FormResize(Sender: TObject);
    private

    public
      procedure PreencherComboBox; overload;
      procedure PreencherComboBox(aCD_PADRAO: Integer; aComboBox: TComboBox; aTABELA, aCOLUNA: String); overload;
      procedure GravarRegistro(aTipoRegistro: String);

    end;

var
    frmLeitos: TfrmLeitos;

implementation

{$R *.lfm}

{ TfrmLeitos }

procedure TfrmLeitos.cbUnidadeChange(Sender: TObject);
begin
	  PreencherComboBox(DM.ComboBoxRetornar(cbUnidade), cbQuarto, 'QUARTO', 'CD_UNIDADE_HOSPITALAR');
end;

procedure TfrmLeitos.btnSalvarClick(Sender: TObject);
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
      MessageDlg('Registro salvo com sucesso', mtInformation, [mbOk], 0);

      {trata excessão no código acima - em caso de erro passa aki}
   except on e:exception do
         MessageDlg(e.message, mtError, [mbOk], 0);
   end;
end;

procedure TfrmLeitos.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   CloseAction:=caFree;
end;

procedure TfrmLeitos.FormResize(Sender: TObject);
begin
   PreencherComboBox;
end;

procedure TfrmLeitos.PreencherComboBox;
var
   I: Integer;
begin
   try
	     for I:= 0 to  ComponentCount -1 do
	     begin
	        if Components[i] is TComboBox then
	        begin
	           if (Components[I] as TComboBox).Hint <> '' then
	           begin
	             (Components[I] as TComboBox).Items.Clear;
	             TArquivo.ListarDadosComboBox((Components[I] as TComboBox),
	                                          'SELECT ' +
	                                          'CD_' + (Components[I] as TComboBox).Hint + ' CD_PADRAO, ' +
	                                          'DS_' + (Components[I] as TComboBox).Hint + ' DS_PADRAO ' +
	                                          'FROM ' + (Components[I] as TComboBox).Hint);
	           end;
	        end;
	     end;

			except on  e: exception do
       ShowMessage(E.Message);
  	end;
end;

procedure TfrmLeitos.PreencherComboBox(aCD_PADRAO: Integer;
			aComboBox: TComboBox; aTABELA, aCOLUNA: String);
var
  I: Integer;
begin
     try
       aComboBox.Items.Clear;
       TArquivo.ListarDadosComboBox(aComboBox,
                                    'SELECT ' +
                                    'CD_' + aTABELA + ' CD_PADRAO, ' +
                                    'DS_' + aTABELA + ' DS_PADRAO ' +
                                    'FROM ' + aTABELA + ' ' +
                                    'WHERE ' + aCOLUNA + ' = ' + IntToStr(aCD_PADRAO)
                                    );

  			except on  e: exception do
       ShowMessage(E.Message);
  			end;
end;

procedure TfrmLeitos.GravarRegistro(aTipoRegistro: String);
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

            {coloca o componente em modo de edição}
            Close;
            SQL.Clear;
            SQL.Add(
                    'INSERT INTO LEITO( '+
                    'CD_QUARTO, '+
                    'CD_LEITO, '+
                    'DS_LEITO, '+
                    'SITUACAO) '+

                    'VALUES('+
                    ':CD_QUARTO, '+
                    ':CD_LEITO, '+
                    ':DS_LEITO, '+
                    ':SITUACAO) '
            );
            ParamByName('CD_QUARTO').AsInteger     :=	DM.ComboBoxRetornar(cbQuarto);
            ParamByName('CD_LEITO').AsInteger      :=	DM.GetGenerator('CD_LEITO', 'LEITO');
            ParamByName('DS_LEITO').AsString 		    :=	edtLeito.Text;
            ParamByName('SITUACAO').IsNull;

            {escreve a modificação no registro}
            ExecSQL;

            edtLeito.Text     :='';

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

