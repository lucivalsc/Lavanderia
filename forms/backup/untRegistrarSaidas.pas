unit untRegistrarSaidas;

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
  DB;

type

		{ TfrmRegistrarSaidas }

  TfrmRegistrarSaidas = class(TForm)
					DataSource1: TDataSource;
					DBGrid1: TDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    cbOrigem: TComboBox;
    cbDestino: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Panel3: TPanel;
    edtCodigo: TEdit;
    edtDescricao: TEdit;
    Label3: TLabel;
    Button1: TButton;
    btnInserir: TButton;
    Button4: TButton;
    Label4: TLabel;
    cbTipoMovimentacao: TComboBox;
    Label5: TLabel;
    cbOrigemQuarto: TComboBox;
    Label6: TLabel;
    cbOrigemLeito: TComboBox;
    Label7: TLabel;
    cbDestinoQuarto: TComboBox;
    Label8: TLabel;
    Label9: TLabel;
    cbDestinoLeito: TComboBox;
    CDSDS_ARTIGO: TStringField;
    CDSDS_ORIGEM: TStringField;
    CDSDS_DESTINO: TStringField;
    CDSBTN_DELETAR: TStringField;
    Button2: TButton;
    Button3: TButton;
    PopupMenu1: TPopupMenu;
    RegistrarOcorrncias1: TMenuItem;
    Remover1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure cbOrigemLeitoExit(Sender: TObject);
    procedure cbDestinoLeitoExit(Sender: TObject);
    procedure cbOrigemExit(Sender: TObject);
    procedure cbOrigemQuartoExit(Sender: TObject);
    procedure cbDestinoQuartoExit(Sender: TObject);
    procedure cbDestinoExit(Sender: TObject);
    procedure edtCodigoChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure RegistrarOcorrncias1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Remover1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PreencherComboBox;
  end;

var
  frmRegistrarSaidas: TfrmRegistrarSaidas;

implementation

{$IFnDEF FPC}
  {$R *.dfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

procedure TfrmRegistrarSaidas.Button1Click(Sender: TObject);
var
  CODIGO: String;
  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin
  //try
  //  Conexao:=TZConnection.Create(Nil);
  //  DM.ConectarBanco(Conexao);
  //
  //  FDQGravar:=TZQuery.Create(Nil);
  //  FDQGravar.Connection:=Conexao;
  //
  //  if CDS.RecordCount = 0 then
  //    ShowMessage('Digite um item antes de salvar.')
  //  else
  //  begin
  //    CDS.First;
  //    CDS.DisableControls;
  //
  //    while not CDS.Eof do
  //    begin
  //      with FDQGravar do
  //      begin
  //        Close;
  //        SQL.Clear;
  //        SQL.Add('INSERT INTO MOVIMENTACAO '+
  //                'VALUES('+
  //                ':CD_PRODUTO,        '+
  //                ':CD_BARRAS,         '+
  //                ':CD_ORIGEM,         '+
  //                ':CD_ORIGEM_QUARTO,  '+
  //                ':CD_ORIGEM_LEITO,   '+
  //                ':CD_DESTINOS,       '+
  //                ':CD_DESTINOS_QUARTO,'+
  //                ':CD_DESTINOS_LEITO, '+
  //                ':TP_MOVIMENTACAO,   '+
  //                ':DT_MOVIMENTACAO,   '+
  //                ':CD_FUNCIONARIO     )    ');
  //
  //        ParamByName('CD_PRODUTO').AsInteger         :=  CDS.FieldByName('CD_PRODUTO').AsInteger;
  //        ParamByName('CD_BARRAS').AsString           :=  CDS.FieldByName('CD_BARRAS').AsString;
  //        ParamByName('CD_ORIGEM').AsInteger          :=  CDS.FieldByName('CD_ORIGEM').AsInteger;
  //        ParamByName('CD_ORIGEM_QUARTO').AsInteger   :=  CDS.FieldByName('CD_ORIGEM_QUARTO').AsInteger;
  //        ParamByName('CD_ORIGEM_LEITO').AsInteger    :=  CDS.FieldByName('CD_ORIGEM_LEITO').AsInteger;
  //        ParamByName('CD_DESTINOS').AsInteger        :=  CDS.FieldByName('CD_DESTINO').AsInteger;
  //        ParamByName('CD_DESTINOS_QUARTO').AsInteger :=  CDS.FieldByName('CD_DESTINOS_QUARTO').AsInteger;
  //        ParamByName('CD_DESTINOS_LEITO').AsInteger  :=  CDS.FieldByName('CD_DESTINOS_LEITO').AsInteger;
  //        ParamByName('TP_MOVIMENTACAO').AsString     :=  CDS.FieldByName('TP_MOVIMENTACAO').AsString;
  //        ParamByName('DT_MOVIMENTACAO').AsDateTime   :=  Now;
  //        ParamByName('CD_FUNCIONARIO').AsInteger     :=  StrToIntDef(CD_USUARIO, -1);
  //        ExecSQL;
  //
  //        Close;
  //        SQL.Clear;
  //        SQL.Add('UPDATE PRODUTOS '+
  //                'SET '+
  //                'CD_DESTINOS_ULTIMO =:CD_DESTINOS_ULTIMO, '+
  //                'DT_DESTINOS_ULTIMO =:DT_DESTINOS_ULTIMO '+
  //                'WHERE CD_BARRAS = :CD_BARRAS ');
  //
  //        ParamByName('CD_BARRAS').AsString             :=  CDS.FieldByName('CD_BARRAS').AsString;
  //        ParamByName('CD_DESTINOS_ULTIMO').AsInteger   :=  CDS.FieldByName('CD_DESTINO').AsInteger;
  //        ParamByName('DT_DESTINOS_ULTIMO').AsDateTime  :=  Now;
  //        ExecSQL;
  //
  //        CDS.Next;
  //      end;
  //    end;
  //      CDS.EnableControls;
  //
  //      CDS.Close;
  //      CDS.CreateDataSet;
  //
  //      ShowMessage('Transferência ocorreu com sucesso.');
  //      edtCodigo.SetFocus;
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

procedure TfrmRegistrarSaidas.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmRegistrarSaidas.btnInserirClick(Sender: TObject);
var
  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin
(*  try
    Conexao:=TZConnection.Create(Nil);
    DM.ConectarBanco(Conexao);

    FDQGravar:=TZQuery.Create(Nil);
    FDQGravar.Connection:=Conexao;

    try

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
              'WHERE P.CD_BARRAS = :CD_BARRAS '+
              'AND IN_ATIVO = :IN_ATIVO '
              );
        ParamByName('CD_BARRAS').AsString:=edtCodigo.Text;
        ParamByName('IN_ATIVO').AsString:='N';
        Open();

        if RecordCount > 0 then
        begin
          edtCodigo.Text:='';
          edtDescricao.Text:='';
          ShowMessage('Produto inativo.');
          Exit
        end else
          begin
            if CDS.Locate('CD_BARRAS', edtCodigo.Text, [LoCaseInsensitive])  then
            begin
              ShowMessage('Item já encontra - se cadastrado.');
              edtCodigo.Text:='';
              edtDescricao.Text:='';
            end else
              if (cbOrigemLeito.ItemIndex <> -1) and
                    (cbDestinoLeito.ItemIndex <> -1) and
                      (edtDescricao.Text <> '') then
                begin
                  with CDS do
                  begin
                    Append;
                    //FieldByName('CD_ORIGEM').AsInteger          :=  FDQOrigem.FieldByName('CD_DESTINOS').AsInteger;
                    //FieldByName('CD_ORIGEM_QUARTO').AsInteger   :=  FDQOrigemQuarto.FieldByName('CD_QUARTO').AsInteger;
                    //FieldByName('CD_ORIGEM_LEITO').AsInteger    :=  FDQOrigemLeito.FieldByName('CD_LEITO').AsInteger;
                    //FieldByName('CD_DESTINO').AsInteger         :=  FDQDestino.FieldByName('CD_DESTINOS').AsInteger;
                    //FieldByName('CD_DESTINOS_QUARTO').AsInteger :=  FDQDestinoQuarto.FieldByName('CD_QUARTO').AsInteger;
                    //FieldByName('CD_DESTINOS_LEITO').AsInteger  :=  FDQDestinoLeito.FieldByName('CD_LEITO').AsInteger;
                    FieldByName('CD_PRODUTO').IsNull;

                    FieldByName('DS_ARTIGO').AsString           :=  edtDescricao.Text;
                    FieldByName('DS_ORIGEM').AsString           :=  cbOrigem.Text;
                    FieldByName('DS_DESTINO').AsString          :=  cbDestino.Text;

                    FieldByName('CD_BARRAS').AsString           :=  edtCodigo.Text;

                    if cbTipoMovimentacao.ItemIndex = 0 then
                      FieldByName('TP_MOVIMENTACAO').AsString   :=  'E'
                      else
                        FieldByName('TP_MOVIMENTACAO').AsString :=  'S';

                    Post;

                    edtCodigo.Text    :=  '';
                    edtDescricao.Text :=  '';
                  end;
                end;
          end;
      end;

    except on E: Exception do
      begin
        raise Exception.Create('Preencha todos os campos.');
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
  end; *)
end;

procedure TfrmRegistrarSaidas.Button4Click(Sender: TObject);
begin
  //Case Application.MessageBox(Pchar('Todos os itens serão excluídos. Tem certeza que deseja continuar?'),
  //                                  'Aviso do Sistema', MB_YESNO)
  //  of
  //    IDYES  :
  //          begin
  //            CDS.Close;
  //            CDS.CreateDataSet;
  //            edtCodigo.SetFocus;
  //          end;
  //
  //    IDNO: begin end;
  //end;
end;

procedure TfrmRegistrarSaidas.cbOrigemExit(Sender: TObject);
begin
  //FDQOrigemQuarto.Close;
  //FDQOrigemQuarto.ParamByName('CD_DESTINOS').AsInteger:=FDQOrigem.FieldByName('CD_DESTINOS').AsInteger;
  //FDQOrigemQuarto.Open();
  //
  //if FDQOrigemQuarto.FieldByName('DS_QUARTO').AsString = 'Não necessário' then
  //begin
  //  FDQOrigemLeito.Close;
  //  FDQOrigemLeito.ParamByName('CD_QUARTO').AsInteger:=FDQOrigemQuarto.FieldByName('CD_QUARTO').AsInteger;
  //  FDQOrigemLeito.Open();
  //end else
  //
end;

procedure TfrmRegistrarSaidas.cbOrigemLeitoExit(Sender: TObject);
begin
//  cbOrigem.ItemIndex:=FDQOrigemLeito.FieldByName('CD_UNIDADE').AsInteger - 1;
//  cbOrigem.ItemIndex:=FDQOrigemLeito.FieldByName('CD_QUARTO').AsInteger - 1;
end;

procedure TfrmRegistrarSaidas.cbOrigemQuartoExit(Sender: TObject);
begin
	  //try
	  //  if FDQOrigemQuarto.FieldByName('DS_QUARTO').AsString <> '' then
	  //  begin
	  //    FDQOrigemLeito.Close;
	  //    FDQOrigemLeito.ParamByName('CD_QUARTO').AsInteger:=FDQOrigemQuarto.FieldByName('CD_QUARTO').AsInteger;
	  //    FDQOrigemLeito.Open();
	  //  end;
	  //except
	  //  FDQOrigemQuarto.Close;
	  //  FDQOrigemLeito.Close;
	  //end;
end;

procedure TfrmRegistrarSaidas.cbDestinoExit(Sender: TObject);
begin
  //FDQDestinoQuarto.Close;
  //FDQDestinoQuarto.ParamByName('CD_DESTINOS').AsInteger:=FDQDestino.FieldByName('CD_DESTINOS').AsInteger;
  //FDQDestinoQuarto.Open();
  //
  //if FDQDestinoQuarto.FieldByName('DS_QUARTO').AsString = 'Não necessário' then
  //begin
  //  FDQDestinoLeito.Close;
  //  FDQDestinoLeito.ParamByName('CD_QUARTO').AsInteger:=FDQDestinoQuarto.FieldByName('CD_QUARTO').AsInteger;
  //  FDQDestinoLeito.Open();
  //end else
  //
end;

procedure TfrmRegistrarSaidas.cbDestinoLeitoExit(Sender: TObject);
begin
//  cbDestino.ItemIndex:=FDQDestinoLeito.FieldByName('CD_UNIDADE').AsInteger - 1;
 // cbDestino.ItemIndex:=FDQDestinoLeito.FieldByName('CD_QUARTO').AsInteger - 1;
end;

procedure TfrmRegistrarSaidas.cbDestinoQuartoExit(Sender: TObject);
begin
//try
//  if FDQDestinoQuarto.FieldByName('DS_QUARTO').AsString <> '' then
//  begin
//    FDQDestinoLeito.Close;
//    FDQDestinoLeito.ParamByName('CD_QUARTO').AsInteger:=FDQDestinoQuarto.FieldByName('CD_QUARTO').AsInteger;
//    FDQDestinoLeito.Open();
//  end;
//except
//  FDQDestinoQuarto.Close;
//  FDQDestinoLeito.Close;
//end;
end;

procedure TfrmRegistrarSaidas.FormCreate(Sender: TObject);
begin
  //CDS.Close;
  //CDS.CreateDataSet;
end;

procedure TfrmRegistrarSaidas.RegistrarOcorrncias1Click(Sender: TObject);
begin
  //if CDS.RecordCount > 0 then
  //begin
  //  if not Assigned(frmRegistrarOcorrencias) then
  //  begin
  //    frmRegistrarOcorrencias:=TfrmRegistrarOcorrencias.Create(Self);
  //    with frmRegistrarOcorrencias do
  //    begin
  //      FDQMotivoOcorrencias.Close;
  //      FDQMotivoOcorrencias.Open();
  //      edtCodigo.Text:=CDS.FieldByName('CD_BARRAS').AsString;
  //      ComboBox1.ItemIndex:=0;
  //      Show;
  //    end;
  //  end;
  //end;
end;

procedure TfrmRegistrarSaidas.Remover1Click(Sender: TObject);
begin
  //if (CDS.RecordCount > 0) then
  //    begin
  //      CDS.Delete;
  //      DBGrid1.SelectedIndex := DBGrid1.SelectedIndex - 1;
  //      edtCodigo.SetFocus;
  //    end;
end;

procedure TfrmRegistrarSaidas.PreencherComboBox;
var
   I: integer;
begin
   for I:= 0 to  ComponentCount -1 do
   begin
      if Components[i] is TComboBox then
      begin
         if (Components[I] as TComboBox).Hint <> '' then
         begin
           TArquivo.ListarDadosComboBox((Components[I] as TComboBox),
                                        'SELECT ' +
                                        'CD_' + (Components[I] as TComboBox).Hint + ' CD_PADRAO, ' +
                                        'DS_' + (Components[I] as TComboBox).Hint + ' DS_PADRAO ' +
                                        'FROM ' + (Components[I] as TComboBox).Hint);
         end;
      end;
   end;
end;

procedure TfrmRegistrarSaidas.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
//var
//  BUTTON: Integer;
//  R: TRect;
//  bcolor: TColor;
begin
 {
  //Inserir Botão
  if (Column.FieldName = 'BTN_DELETAR')
  and (CDS.RecordCount > 0) then
  begin
    DBGrid1.Canvas.FillRect(Rect);
    BUTTON := 0;
    R:=Rect;
    InflateRect(R,-1,-1); //Diminue o tamanho do Botão
    DrawFrameControl(DBGrid1.Canvas.Handle,R,BUTTON, BUTTON or BUTTON);
    bcolor := DBGrid1.Canvas.Brush.Color; // guarda a cor de fundo original
    DBGrid1.Canvas.Brush.Color := clBtnFace; // muda a cor de fundo
    DrawText(DBGrid1.Canvas.Handle, ' Remover ' , 9, R, DT_VCENTER or DT_CENTER);
    DBGrid1.Canvas.Brush.Color := bcolor; // devolve a cor original
  end;
  }
end;

procedure TfrmRegistrarSaidas.edtCodigoChange(Sender: TObject);
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
  //
  //  with FDQGravar do
  //  begin
  //    Close;
  //    SQL.Clear;
  //    SQL.Add(
  //            'SELECT '+
  //            'P.CD_BARRAS, '+
  //            'A.DS_ARTIGO '+
  //            ' '+
  //            'FROM PRODUTOS P '+
  //            ' '+
  //            'INNER JOIN ARTIGOS A ON '+
  //            'A.CD_ARTIGO = P.CD_ARTIGO '+
  //            ' '+
  //            'WHERE P.CD_BARRAS = :CD_BARRAS '+
  //            'AND IN_ATIVO = :IN_ATIVO '
  //            );
  //
  //    ParamByName('CD_BARRAS').AsString:=edtCodigo.Text;
  //    ParamByName('IN_ATIVO').AsString:='S';
  //    Open();
  //
  //    if RecordCount > 0 then
  //      edtDescricao.Text:=FieldByName('DS_ARTIGO').Text
  //      else edtDescricao.Text:='';
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
