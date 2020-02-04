unit untdm;

{$mode objfpc}{$H+}

interface

uses
  Windows,
  StdCtrls,
  Math,
  IdHTTP,
  Dialogs,
  IniFiles,
  DB,
  BufDataset,
  Classes, SysUtils, FileUtil, LR_Class, LR_DBSet, ZConnection, ZDataset, Forms,
  frxExportPDFLaz, frxExportImage, frxExportHTML, frxExportHTMLDiv,
  frxExportODF, frxClass, frxDesgn, frxDBSet;

type

  { TDM }

  TDM = class(TDataModule)
					CDS: TBufDataset;
					CDSCD_BARRAS: TStringField;
					CDSCD_DESTINO: TLongintField;
					CDSCD_DESTINOS_LEITO: TLongintField;
					CDSCD_DESTINOS_QUARTO: TLongintField;
					CDSCD_ORIGEM: TLongintField;
					CDSCD_ORIGEM_LEITO: TLongintField;
					CDSCD_ORIGEM_QUARTO: TLongintField;
					CDSCD_PRODUTO: TLongintField;
					CDSTP_MOVIMENTACAO: TStringField;
    DSPadrao: TDataSource;
    DSParametros: TDataSource;
    FDMemParametros: TBufDataset;
    CDSEvolucaoCD_ATENDIMENTO: TLongintField;
    CDSEvolucaoCD_EVOLUCAO: TLongintField;
    CDSEvolucaoDT_ANO_ATENDIMENTO: TLongintField;
    CDSEvolucaoDT_DIGITACAO: TStringField;
    CDSPrescricaoAtual: TBufDataset;
    CDSEvolucao: TBufDataset;
    CDSPrescricao: TBufDataset;
    CDSPrescricaoAtualCD_INTERVALO: TLongintField;
    CDSPrescricaoAtualCD_ITEM: TLongintField;
    CDSPrescricaoAtualCD_TIPO_ITEM: TLongintField;
    CDSPrescricaoAtualCD_UNIDADE_MEDIDA: TLongintField;
    CDSPrescricaoAtualCD_VIA_ADMINISTRACAO: TLongintField;
    CDSPrescricaoAtualDS_ITEM: TStringField;
    CDSPrescricaoAtualDS_ITEM1: TStringField;
    CDSPrescricaoAtualDS_SE_NECESSARIO: TStringField;
    CDSPrescricaoAtualHORA_INICIO: TTimeField;
    CDSPrescricaoAtualIN_CRITERIO_MEDICO: TStringField;
    CDSPrescricaoAtualIN_INICIO_IMEDIATO: TStringField;
    CDSPrescricaoAtualIN_SE_NECESSARIO: TStringField;
    CDSPrescricaoAtualNR_DOSES: TFloatField;
    CDSPrescricaoAtualNR_VEZES: TLongintField;
    CDSPrescricaoAtualOBSERVACAO: TStringField;
    CDSPrescricaoAtualSC_ITEM: TStringField;
    CDSPrescricaoCD_ATENDIMENTO: TLongintField;
    CDSPrescricaoCD_PRESCRICAO: TLongintField;
    CDSPrescricaoDT_ANO_ATENDIMENTO: TLongintField;
    CDSPrescricaoDT_DIGITACAO: TStringField;
    DSCDSPrescricaoAtual: TDataSource;
    DSEvolucao: TDataSource;
    DSPrescricao: TDataSource;
    FDMemParametrosCD_TIPO_ATRIBUTO: TLongintField;
    FDMemParametrosDS_PARAMETRO: TStringField;
    FDMemParametrosTITULO_PARAMETRO: TStringField;
    FDMemTableDadosModeloSC_CENTRO_CUSTO: TStringField;
    FDMemTableDadosLoteCD_PROCEDIMENTO: TLongintField;
    FDMemTableDadosLoteMEDICO: TStringField;
    FDMemTableDadosLoteNR_CONTA: TLongintField;
    FDMemTableDadosLotePLANO_SAUDE: TStringField;
    FDMemTableDadosLoteTIPO_CONTA: TStringField;
    FDMemTableDadosModeloCD_MATERIAL: TLongintField;
    FDMemTableDadosModeloDT_ATENDIMENTO: TStringField;
    FDMemTableDadosModeloIN_TIPO: TLongintField;
    FDMemTableDadosModeloQT_MATERIAL: TStringField;
    FDMemTableModeloDS_MODELO: TStringField;
    FDMemTableModeloDS_MODELO1: TStringField;
    FDMemTableSenhaSENHA: TStringField;
    FDPrazoEntregaCD_DES_DEFINICAO_FAT: TLongintField;
    FDPrazoEntregaCD_PLANO_SAUDE: TLongintField;
    FDPrazoEntregaCONTAS_ABERTAS_OLD: TLongintField;
    FDPrazoEntregaDS_DES_DEFINICAO_FAT: TStringField;
    FDPrazoEntregaDS_LOCAL_PRONTUARIO: TStringField;
    FDPrazoEntregaDS_OBSERVACAO: TStringField;
    FDPrazoEntregaDS_PLANO_SAUDE: TStringField;
    FDPrazoEntregaDT_ABERTURA: TStringField;
    FDPrazoEntregaDT_ANO: TLongintField;
    FDPrazoEntregaDT_ENTREGA: TStringField;
    FDPrazoEntregaDT_MOV_PRONTUARIO: TStringField;
    FDPrazoEntregaNM_PACIENTE: TStringField;
    FDPrazoEntregaNR_FIA_BAA: TLongintField;
    FDPrazoEntregaPERIODICIDADE: TStringField;
    FDPrazoEntregaTOTAL: TLongintField;
    frDBDataSet1: TfrDBDataSet;
    frReport1: TfrReport;
    frxBMPExport1: TfrxBMPExport;
    frxDBDataset1: TfrxDBDataset;
    frxDesigner1: TfrxDesigner;
    frxHTML4DivExport1: TfrxHTML4DivExport;
    frxHTML5DivExport1: TfrxHTML5DivExport;
    frxHTMLExport1: TfrxHTMLExport;
    frxJPEGExport1: TfrxJPEGExport;
    frxODSExport1: TfrxODSExport;
    frxODTExport1: TfrxODTExport;
    frxPDFExport1: TfrxPDFExport;
    frxPNGExport1: TfrxPNGExport;
    frxReport1: TfrxReport;
    frxTIFFExport1: TfrxTIFFExport;
    OpenDialog1: TOpenDialog;
    ZConnection1: TZConnection;
    ZQPadrao: TZQuery;
				ZQuery1: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
  private

  public
    //Gerenciador de relatorios
    CD_RELATORIO: integer;
    PASTA_LOCAL: string;

    //Crack serial
    SERIAL_CODIGO: string;

    //Variaveis fixas
    CD_MEDICO, CD_USUARIO: integer;
    NM_MEDICO_LOGADO: string;

    //Variaveis não fixas
    CD_PACIENTE, CD_ATENDIMENTO, DT_ANO_ATENDIMENTO: integer;

    //Variaveis não fixas do paciente
    NM_PACIENTE: string;

    function LerIni(Chave1, Chave2: string; ValorPadrao: string = ''): string;
    function GetGenerator(Coluna, Tabela: string): integer; overload;
    function GetGenerator(aColunaId, aColunaFiltro, aTabela: string;
      aFiltro: integer): integer; overload;
    function DataOk(Dt: string): boolean;
    function IsValidCPF(pCPF: string): boolean;
    function LimparCPF(aCPF: string): string;
    function ComboBoxRetornar(aCB: TComboBox): integer;
    function CalculaIdade(DataIni, DataFim: TDateTime): string;

    procedure ConectarBanco(Conexao: TZConnection);
    procedure IdHTTP(aIdHTTP: TIdHTTP);

    function Criptografar(Acao, Texto: string): string;
    function MacEndereco: string;

    function BaixarArquivo: string; overload; //Modelo de relatório vazio
    function BaixarArquivo(aCD_RELATORIO: integer): string;
      overload; //Relatório trabalhado
  end;

type
    { TArquivo }

    TArquivo = class
    public
      class procedure ListarDadosComboBox(CDS: TComboBox; aSQL: String);
      function DataOk(Dt:String):Boolean;
    end;

var
  DM: TDM;

implementation

{$R *.lfm}

{ TArquivo }

class procedure TArquivo.ListarDadosComboBox(CDS: TComboBox; aSQL: String);
var
  //Conexão
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
      SQL.Add(aSQL);
      Open();

      if RecordCount > 0 then
      begin
        CDS.Items.Clear;

        First;
        DisableControls;
        while not EOF do
        begin
          CDS.Items.AddObject(FieldByName('DS_PADRAO').AsString, TObject(Pointer(FieldByName('CD_PADRAO').AsInteger)));
          Next;
        end;
        EnableControls;
      end;
    end;
    FreeAndNil(FDQGravar);
    FreeAndNil(Conexao);

  except on E: Exception do
    begin
      FreeAndNil(FDQGravar);
      FreeAndNil(Conexao);
      ShowMessage(E.Message);
    end;
  end;
end;

function TArquivo.DataOk(Dt: String): Boolean;
var
  Dia,Mes:Byte;
  Ano:Integer;
      function AnoBissesto(Year :Integer): boolean ;
      begin
         AnoBissesto:=(ano mod 4=0) and ( ano mod 100 <> 0) or (ano Mod 400 =0);
      end;
begin
      Result:=False;
      if length(Trim(Dt)) = 8 then
      begin
             Dia:=StrToIntDef(Copy(Dt,1,2),0);
             Mes:=StrToIntDef(Copy(Dt,4,2),0);
             Ano:=StrToInt(Copy(Dt,7,2));
             if ( (Mes in [1,3,5,7,8,10,12]) and (Dia in [1..31]) ) or
                ( (Mes in [4,6,9,11]) and (Dia in [1..30])        ) or
                ( (Mes = 2) and  (     AnoBissesto(Ano))  and  (Dia in [1..29]) )  or
                ( (Mes = 2) and  (not  AnoBissesto(Ano))  and  (Dia in [1..28]) )
             then
             Result:=True;
      end;
end;

{ TArquivoINI }

function TDM.MacEndereco: string;
var
  Lib: cardinal;
  Func: function(GUID: PGUID): longint; stdcall;
  GUID1, GUID2: TGUID;

begin
  //Result := '';
  //Lib := LoadLibrary('rpcrt4.dll');
  //if Lib <> 0 then
  //begin
  //  Func := windows.GetProcAddress(Lib, 'UuidCreateSequential');
  //  if Assigned(Func) then
  //  begin
  //    if (Func(GUID1) = 0) and
  //       (Func(GUID2) = 0) and
  //       (GUID1.D4[2] = GUID2.D4[2]) and
  //       (GUID1.D4[3] = GUID2.D4[3]) and
  //       (GUID1.D4[4] = GUID2.D4[4]) and
  //       (GUID1.D4[5] = GUID2.D4[5]) and
  //       (GUID1.D4[6] = GUID2.D4[6]) and
  //       (GUID1.D4[7] = GUID2.D4[7]) then
  //    begin
  //      Result :=
  //        IntToHex(GUID1.D4[2], 2) + '-' +
  //        IntToHex(GUID1.D4[3], 2) + '-' +
  //        IntToHex(GUID1.D4[4], 2) + '-' +
  //        IntToHex(GUID1.D4[5], 2) + '-' +
  //        IntToHex(GUID1.D4[6], 2) + '-' +
  //        IntToHex(GUID1.D4[7], 2);
  //    end;
  //  end;
  //end;
end;

function TDM.BaixarArquivo: string;
var
  BlobStream: TStream;
  FileStream: TFileStream;

  FDQuery: TZQuery;
begin
  try
    FDQuery := TZQuery.Create(nil);
    FDQuery.Connection := ZConnection1;

    with FDQuery do
    begin
      Close;
      SQL.Clear;
      SQL.add('SELECT CD_MODELO, MODELO ' + 'FROM MODELO ' +
        'WHERE CD_MODELO = :CD_MODELO ');
      ParamByName('CD_MODELO').AsInteger := 1;
      Open;

      if RecordCount > 0 then
      begin
        // Salvando o arquivo em disco
        try
          BlobStream := CreateBlobStream(FieldByName('MODELO') as TBlobField, bmRead);
          FileStream := TFileStream.Create(DM.PASTA_LOCAL + 'Modelo.fr3',
            fmCreate or fmOpenWrite);
          FileStream.CopyFrom(BlobStream, 0);
          Result := ('Documento salvo em disco...');
        finally
          // Liberando memoria
          FileStream.Free;
          BlobStream.Free;
        end;
      end;
    end;

    FreeAndNil(FDQuery);
  except
    on E: Exception do
    begin
      FreeAndNil(FDQuery);
      //ShowMessage(E.Message);
    end;
  end;
end;

function TDM.BaixarArquivo(aCD_RELATORIO: integer): string;
var
  BlobStream: TStream;
  FileStream: TFileStream;

  FDQuery: TZQuery;
begin
  try
    FDQuery := TZQuery.Create(nil);
    FDQuery.Connection := ZConnection1;

    with FDQuery do
    begin
      Close;
      SQL.Clear;
      SQL.add('SELECT CD_RELATORIO, DS_RELATORIO, SQL_RELATORIO, MODELO FROM RELATORIO '
        +
        'WHERE CD_RELATORIO = :CD_RELATORIO ');
      ParamByName('CD_RELATORIO').AsInteger := CD_RELATORIO;
      Open;

      if RecordCount > 0 then
      begin
        // Salvando o arquivo em disco
        try
          BlobStream := CreateBlobStream(FieldByName('MODELO') as TBlobField, bmRead);
          FileStream := TFileStream.Create(DM.PASTA_LOCAL + 'Modelo.fr3',
            fmCreate or fmOpenWrite);
          FileStream.CopyFrom(BlobStream, 0);
          Result := ('Documento salvo em disco...');
        finally
          // Liberando memoria
          FileStream.Free;
          BlobStream.Free;
        end;
      end;
    end;

    FreeAndNil(FDQuery);
  except
    on E: Exception do
    begin
      FreeAndNil(FDQuery);
      ShowMessage(E.Message);
    end;
  end;
end;

function TDM.Criptografar(Acao, Texto: string): string;
var
  KeyLen: integer;
  KeyPos: integer;
  OffSet: integer;
  Dest, Key: string;
  SrcPos: integer;
  SrcAsc: integer;
  TmpSrcAsc: integer;
  Range: integer;
begin
  //usar essa função
  if (Texto = '') then
  begin
    Result := '';
  end;
  Key :=
    'YUQL23KL23DF90WI5E1JAS467NMCXXL6JAOAUWWMCL0AOMM4A4VZYW9KHJUI2347EJHJKDF3424SKL K3LAKDJSL9RTIKJ';
  Dest := '';
  KeyLen := Length(Key);
  KeyPos := 0;
  //SrcPos := 0;
  //SrcAsc := 0;
  Range := 256;
  if (Acao = UpperCase('C')) then
  begin
    Randomize;
    OffSet := Random(Range);
    Dest := Format('%1.2x', [OffSet]);
    for SrcPos := 1 to Length(Texto) do
    begin
      Application.ProcessMessages;
      SrcAsc := (Ord(Texto[SrcPos]) + OffSet) mod 255;
      if KeyPos < KeyLen then
        KeyPos := KeyPos + 1
      else
        KeyPos := 1;
      SrcAsc := SrcAsc xor Ord(Key[KeyPos]);
      Dest := Dest + Format('%1.2x', [SrcAsc]);
      OffSet := SrcAsc;
    end;
  end
  else if (Acao = UpperCase('D')) then
  begin
    OffSet := StrToInt('$' + copy(Texto, 1, 2));
    SrcPos := 3;
    repeat
      SrcAsc := StrToInt('$' + copy(Texto, SrcPos, 2));
      if (KeyPos < KeyLen) then
        KeyPos := KeyPos + 1
      else
        KeyPos := 1;
      TmpSrcAsc := SrcAsc xor Ord(Key[KeyPos]);
      if TmpSrcAsc <= OffSet then
        TmpSrcAsc := 255 + TmpSrcAsc - OffSet
      else
        TmpSrcAsc := TmpSrcAsc - OffSet;
      Dest := Dest + Chr(TmpSrcAsc);
      OffSet := SrcAsc;
      SrcPos := SrcPos + 2;
    until (SrcPos >= Length(Texto));
  end;
  Result := Dest;
end;

function TDM.LerIni(Chave1, Chave2: string; ValorPadrao: string): string;
var
  Arquivo: string;
  FileINI: TIniFile;
begin
  Arquivo := ExtractFilePath(ParamStr(0)) +
    Copy(ExtractFileName(Application.ExeName), 1,
    Pos('.', ExtractFileName(Application.ExeName)) - 1) + '.ini';
  Result := ValorPadrao;
  try
    FileIni := TIniFile.Create(Arquivo);
    if FileExists(Arquivo) then
      Result := FileIni.ReadString(Chave1, Chave2, ValorPadrao);
  finally
    FreeAndNil(FileIni)
  end;
end;

procedure TDM.ConectarBanco(Conexao: TZConnection);
begin
  try
    with Conexao do
    begin
      Connected   := False;
      LoginPrompt := False;
      Database    := LerIni('FIREBIRD', 'Database');
      HostName    := LerIni('FIREBIRD', 'HostName');
      Password    := LerIni('FIREBIRD', 'Password');
      Protocol    := LerIni('FIREBIRD', 'Protocol'); //firebirdd-2.5
      User        := LerIni('FIREBIRD', 'User');
      AutoCommit  := True;
      Connected   := True;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create('Ocorreu uma Falha na configuração no Banco Firebird!');
      Conexao.Connected := False;
    end;
  end;
end;

procedure TDM.IdHTTP(aIdHTTP: TIdHTTP);
begin
  with aIdHTTP do
  begin
    ProxyParams.ProxyPassword := LerIni('PROXY', 'Password');
    ProxyParams.ProxyPort := StrToInt(LerIni('PROXY', 'Port'));
    ProxyParams.ProxyServer := LerIni('PROXY', 'Server');
    ProxyParams.ProxyUsername := LerIni('PROXY', 'Username');
  end;
end;

function TDM.GetGenerator(Coluna, Tabela: string): integer;
var
  zSQL: TZQuery;
begin
  try
    zSQL := TZQuery.Create(nil);
    zSQL.Connection := ZConnection1;

    zSQL.Close;
    zSQL.SQL.Clear;
    zSQL.SQL.Add('select coalesce(max(' + Coluna + '), 0) + 1 codigo from ' + Tabela);
    zSQL.Open;

    Result := zSQL.FieldByName('codigo').AsInteger;

    FreeAndNil(zSQL);

  except
    on  e: Exception do
    begin
      MessageDlg('Não foi possível executar a consulta: ' + e.Message,
        mtError, [mbOK], 0);
      FreeAndNil(zSQL);
    end;
  end;
end;

function TDM.GetGenerator(aColunaId, aColunaFiltro, aTabela: string;
  aFiltro: integer): integer;
var
  zSQL: TZQuery;
begin
  try
    zSQL := TZQuery.Create(nil);
    zSQL.Connection := ZConnection1;

    zSQL.Close;
    zSQL.SQL.Clear;
    zSQL.SQL.Add('select coalesce(max(' + aColunaId + '), 0) + 1 codigo from ' +
      aTabela + ' ' + 'where ' + aColunaFiltro + ' = :CD ');
    zSQL.ParamByName('CD').AsInteger := aFiltro;
    zSQL.Open;

    Result := zSQL.FieldByName('codigo').AsInteger;

    FreeAndNil(zSQL);

  except
    on  e: Exception do
    begin
      MessageDlg('Não foi possível executar a consulta: ' + e.Message,
        mtError, [mbOK], 0);
      FreeAndNil(zSQL);
    end;
  end;
end;

function TDM.DataOk(Dt: string): boolean;
var
  Dia, Mes: byte;
  Ano: integer;

  function AnoBissesto(Year: integer): boolean;
  begin
    AnoBissesto := (ano mod 4 = 0) and (ano mod 100 <> 0) or (ano mod 400 = 0);
  end;

begin
  Result := False;
  if length(Trim(Dt)) = 10 then
  begin
    Dia := StrToIntDef(Copy(Dt, 1, 2), 0);
    Mes := StrToIntDef(Copy(Dt, 4, 2), 0);
    Ano := StrToInt(Copy(Dt, 7, 4));
    if ((Mes in [1, 3, 5, 7, 8, 10, 12]) and (Dia in [1..31])) or
      ((Mes in [4, 6, 9, 11]) and (Dia in [1..30])) or
      ((Mes = 2) and (AnoBissesto(Ano)) and (Dia in [1..29])) or
      ((Mes = 2) and (not AnoBissesto(Ano)) and (Dia in [1..28])) then
      Result := True;
  end;
end;

function TDM.IsValidCPF(pCPF: string): boolean;
var
  v: array[0..1] of word;
  cpf: array[0..10] of byte;
  I: byte;
begin
  try
    for I := 1 to 11 do
      cpf[i - 1] := StrToInt(pCPF[i]);
    //Nota: Calcula o primeiro dígito de verificação.
    v[0] := 10 * cpf[0] + 9 * cpf[1] + 8 * cpf[2];
    v[0] := v[0] + 7 * cpf[3] + 6 * cpf[4] + 5 * cpf[5];
    v[0] := v[0] + 4 * cpf[6] + 3 * cpf[7] + 2 * cpf[8];
    v[0] := 11 - v[0] mod 11;
    v[0] := IfThen(v[0] >= 10, 0, v[0]);
    //Nota: Calcula o segundo dígito de verificação.
    v[1] := 11 * cpf[0] + 10 * cpf[1] + 9 * cpf[2];
    v[1] := v[1] + 8 * cpf[3] + 7 * cpf[4] + 6 * cpf[5];
    v[1] := v[1] + 5 * cpf[6] + 4 * cpf[7] + 3 * cpf[8];
    v[1] := v[1] + 2 * v[0];
    v[1] := 11 - v[1] mod 11;
    v[1] := IfThen(v[1] >= 10, 0, v[1]);
    //Nota: Verdadeiro se os dígitos de verificação são os esperados.
    Result := ((v[0] = cpf[9]) and (v[1] = cpf[10]));
  except
    on E: Exception do
      Result := False;
  end;
end;

function TDM.LimparCPF(aCPF: string): string;
begin
  Result := StringReplace(StringReplace(StringReplace(aCPF, '_',
    '', [rfReplaceAll]), '-', '', [rfReplaceAll]), '.', '', [rfReplaceAll]);
end;

function TDM.ComboBoxRetornar(aCB: TComboBox): integer;
begin
  try
    Result := PtrInt(Pointer(aCB.Items.Objects[aCB.ItemIndex]));
  except
    on  e: Exception do
    begin
      Result := -1;
      //MessageDlg('Não foi possível retornar dados do ComboBox: ' + e.Message, mtError, [mbOk], 0);
    end;
  end;
end;

function TDM.CalculaIdade(DataIni, DataFim: TDateTime): string;
var
  Idade: string;
  Resto: integer;
  iDia, iMes, iAno, fDia, fMes, fAno: word;
  nDia, nMes, nAno, DiaBissexto: double;
begin
  DecodeDate(DataIni, iAno, iMes, iDia);
  DecodeDate(DataFim, fAno, fMes, fDia);
  nAno := fAno - iAno;
  if nAno > 0 then
    if fMes < iMes then
      nAno := nAno - 1
    else if (fMes = iMes) and (fDia < iDia) then
      nAno := nAno - 1;

  if fMes < iMes then
  begin
    nMes := 12 - (iMes - fMes);
    if fDia < iDia then
      nMes := nMes - 1;
  end
  else if fMes = iMes then
  begin
    nMes := 0;
    if fDia < iDia then
      nMes := 11;
  end
  else if fMes > iMes then
  begin
    nMes := fMes - iMes;
    if fDia < iDia then
      nMes := nMes - 1;
  end;
  nDia := 0;

  if fDia > iDia then
    nDia := fDia - iDia;
  if fDia < iDia then
    nDia := (DataFim - IncMonth(DataFim, -1)) - (iDia - fDia);
  Result := '';
  if nAno = 1 then
    Result := FloatToStr(nAno) + ' Ano '
  else if nAno > 1 then
    Result := FloatToStr(nAno) + ' Anos ';

  if nMes = 1 then
    Result := Result + FloatToStr(nMes) + ' Mês '
  else if nMes > 1 then
    Result := Result + FloatToStr(nMes) + ' Meses ';

  if nDia = 1 then
    Result := Result + FloatToStr(nDia) + ' Dia '
  else if nDia > 1 then
    Result := Result + FloatToStr(nDia) + ' Dias ';
end;

{ TDM }

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  try
    ConectarBanco(ZConnection1);
  except
    on  e: Exception do
    begin
      MessageDlg('Não foi possível executar a consulta: ' + e.Message,
        mtError, [mbOK], 0);
    end;
  end;
end;

end.
