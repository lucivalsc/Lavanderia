unit untMotivoBaixa;

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
  BufDataset, Grids, DBGrids, ExtCtrls, ZDataset, ZConnection,
{$IFnDEF FPC}
  Vcl.ExtCtrls, Vcl.DBGrids, Vcl.Grids, Vcl.ToolWin, Vcl.ComCtrls, Vcl.Buttons, Vcl.StdCtrls, FireDAC.Comp.UI, FireDAC.Phys.FB, FireDAC.Phys.IBBase, FireDAC.Phys, FireDAC.Comp.Client, FireDAC.Comp.DataSet, Data.DB, FireDAC.DApt, FireDAC.Stan.Async, FireDAC.DApt.Intf, FireDAC.Phys.Intf, FireDAC.DatS, FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.Stan.Option, FireDAC.Stan.Intf, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.UI.Intf, Vcl.Dialogs, Vcl.Forms, Vcl.Controls, Vcl.Graphics, System.Classes, System.Variants, System.SysUtils, Winapi.Messages, Winapi.Windows,
{$ELSE}
{$ENDIF}
  untPadrao,
  DB;

type
  TfrmMotivoBaixa = class(TfrmPadrao)
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMotivoBaixa: TfrmMotivoBaixa;

implementation

{$IFnDEF FPC}
  {$R *.dfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

procedure TfrmMotivoBaixa.btnSalvarClick(Sender: TObject);
var
  CODIGO: String;

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
          //CODIGO:=GeraCodigo('SELECT MAX(CD_MOTIVO_BAIXA) CD_CADASTRO '+
          //                    'FROM MOTIVO_BAIXA');
          //
          //Gravar('INSERT INTO MOTIVO_BAIXA '+
          //        'VALUES( '+
          //        QuotedStr(IntToStr(StrToIntDef(CODIGO, 0) + 1)) + ', '+
          //        QuotedStr(edtDescricao.Text) + ')');
          //
          //edtCodigo.Text:='';
          //edtDescricao.Text:='';
        end;
      end;
    end;

    if btnSalvar.Caption = 'Atualizar' then
    begin
      with FDQGravar do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM MOTIVO_BAIXA '+
                'WHERE CD_MOTIVO_BAIXA = ' + QuotedStr(edtCodigo.Text));
        Open();

        if FieldByName('DS_MOTIVO_BAIXA').AsString <> edtDescricao.Text then
        begin
          SQL.Clear;
          SQL.Add('UPDATE MOTIVO_BAIXA '+
                  'SET '+
                  'DS_MOTIVO_BAIXA = ' + QuotedStr(edtDescricao.Text) +
                  'WHERE CD_MOTIVO_BAIXA = ' + QuotedStr(edtCodigo.Text));
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

procedure TfrmMotivoBaixa.Button2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmMotivoBaixa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:=caFree;
  frmMotivoBaixa:=Nil;
end;

procedure TfrmMotivoBaixa.FormCreate(Sender: TObject);
begin
  inherited;
  Listar('SELECT CD_MOTIVO_BAIXA CD_CADASTRO, '+
         'DS_MOTIVO_BAIXA DS_CADASTRO FROM MOTIVO_BAIXA '+
         'ORDER BY DS_CADASTRO');
end;

end.
