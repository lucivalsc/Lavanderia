unit untCadastroArtigos;

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
  Vcl.ExtCtrls, Vcl.DBGrids, Vcl.Grids, Vcl.ToolWin, Vcl.ComCtrls, Vcl.Buttons, Vcl.StdCtrls, FireDAC.Comp.UI, FireDAC.Phys.FB, FireDAC.Phys.IBBase, FireDAC.Phys, FireDAC.Comp.Client, FireDAC.Comp.DataSet, Data.DB, FireDAC.DApt, FireDAC.Stan.Async, FireDAC.DApt.Intf, FireDAC.Phys.Intf, FireDAC.DatS, FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.Stan.Option, FireDAC.Stan.Intf, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.UI.Intf, Vcl.Dialogs, Vcl.Forms, Vcl.Controls, Vcl.Graphics, System.Classes, System.Variants, System.SysUtils, Winapi.Messages, Winapi.Windows, JvExStdCtrls, JvEdit, JvValidateEdit,
{$ELSE}
{$ENDIF}
  untPadrao,
  DB;

type
  TfrmCadastroArtigos = class(TfrmPadrao)
    lblQuantidade: TLabel;
    edtQuantidade: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnNovoRegistroClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroArtigos: TfrmCadastroArtigos;

implementation

{$IFnDEF FPC}
  {$R *.dfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

procedure TfrmCadastroArtigos.btnNovoRegistroClick(Sender: TObject);
begin
  inherited;
  lblQuantidade.Visible:=True;
  edtQuantidade.Visible:=True;
end;

procedure TfrmCadastroArtigos.btnSalvarClick(Sender: TObject);
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
        with FDQGravar do
        begin
          //CODIGO:=GeraCodigo('SELECT MAX(CD_ARTIGO) CD_CADASTRO '+
          //                    'FROM ARTIGOS');

          //Gravar('INSERT INTO ARTIGOS '+
          //        'VALUES( '+
          //        QuotedStr(IntToStr(StrToIntDef(CODIGO, 0) + 1)) + ', '+
          //        QuotedStr(edtDescricao.Text) + ', '+
          //        QuotedStr(edtQuantidade.Text) + ')');
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
        SQL.Add('SELECT * FROM ARTIGOS '+
                'WHERE CD_ARTIGO = ' + QuotedStr(edtCodigo.Text));
        Open();

        if FieldByName('DS_ARTIGO').AsString <> edtDescricao.Text then
        begin
          SQL.Clear;
          SQL.Add('UPDATE ARTIGOS '+
                  'SET '+
                  'DS_ARTIGO = ' + QuotedStr(edtDescricao.Text) +
                  'WHERE CD_ARTIGO = ' + QuotedStr(edtCodigo.Text));
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

procedure TfrmCadastroArtigos.Button2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCadastroArtigos.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  lblQuantidade.Visible:=False;
  edtQuantidade.Visible:=False;
end;

procedure TfrmCadastroArtigos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:=caFree;
  frmCadastroArtigos:=Nil;
end;

procedure TfrmCadastroArtigos.FormCreate(Sender: TObject);
begin
  inherited;
  Listar('SELECT CD_ARTIGO CD_CADASTRO, '+
         'DS_ARTIGO DS_CADASTRO FROM ARTIGOS '+
         'ORDER BY DS_ARTIGO');
end;

end.
