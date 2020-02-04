unit untArquivo;

{$mode objfpc}{$H+}

interface

uses
  untdm,
  Math,
  Clipbrd, DateUtils,
  ZConnection, ZDataset,
  sqldb, DB, BufDataset, Windows, Variants, LCLType, Classes,
  SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids, ExtCtrls,
  Menus, Buttons, ComCtrls, MaskEdit, Types, Grids,
  IniFiles,
  FileUtil;

type

  { TArquivo }

  TArquivo = class
  public
    function LerIni(Chave1, Chave2: string; ValorPadrao: string = ''): string;
    procedure ConectarBanco(Conexao: TZConnection);
    class procedure ListarDadosComboBox(CDS: TComboBox; aSQL: string);
    function DataOk(Dt: string): boolean;
  end;

implementation


{ TArquivo }
function TArquivo.LerIni(Chave1, Chave2: string; ValorPadrao: string): string;
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

procedure TArquivo.ConectarBanco(Conexao: TZConnection);
begin
  try
    with Conexao do
    begin
      Connected := False;
      LoginPrompt := False;
      Database := LerIni('FIREBIRD', 'Database');
      HostName := LerIni('FIREBIRD', 'HostName');
      Password := LerIni('FIREBIRD', 'Password');
      Protocol := LerIni('FIREBIRD', 'Protocol');
      User := LerIni('FIREBIRD', 'User');
      Connected := True;
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create('Ocorreu uma Falha na configuração no Banco Firebird!');
      Conexao.Connected := False;
    end;
  end;
end;

class procedure TArquivo.ListarDadosComboBox(CDS: TComboBox; aSQL: string);
var
  //Conexão
  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin
  try
    Conexao := TZConnection.Create(nil);
    DM.ConectarBanco(Conexao);

    FDQGravar := TZQuery.Create(nil);
    FDQGravar.Connection := Conexao;

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
          CDS.Items.AddObject(FieldByName('DS_PADRAO').AsString,
            TObject(Pointer(FieldByName('CD_PADRAO').AsInteger)));
          Next;
        end;
        EnableControls;
      end;
    end;
    FreeAndNil(FDQGravar);
    FreeAndNil(Conexao);

  except
    on E: Exception do
    begin
      FreeAndNil(FDQGravar);
      FreeAndNil(Conexao);
      //ShowMessage(e.Message);
    end;
  end;
end;

function TArquivo.DataOk(Dt: string): boolean;
var
  Dia, Mes: byte;
  Ano: integer;

  function AnoBissesto(Year: integer): boolean;
  begin
    AnoBissesto := (ano mod 4 = 0) and (ano mod 100 <> 0) or (ano mod 400 = 0);
  end;

begin
  Result := False;
  if length(Trim(Dt)) = 8 then
  begin
    Dia := StrToIntDef(Copy(Dt, 1, 2), 0);
    Mes := StrToIntDef(Copy(Dt, 4, 2), 0);
    Ano := StrToInt(Copy(Dt, 7, 2));
    if ((Mes in [1, 3, 5, 7, 8, 10, 12]) and (Dia in [1..31])) or
      ((Mes in [4, 6, 9, 11]) and (Dia in [1..30])) or
      ((Mes = 2) and (AnoBissesto(Ano)) and (Dia in [1..29])) or
      ((Mes = 2) and (not AnoBissesto(Ano)) and (Dia in [1..28])) then
      Result := True;
  end;
end;

//Retornar o valor do ComboBox
//PtrInt(Pointer(ComboBox3.Items.Objects[ComboBox3.ItemIndex]))
end.
