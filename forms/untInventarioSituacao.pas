unit untInventarioSituacao;

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
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Dialogs, Vcl.Forms, Vcl.Controls, Vcl.Graphics, System.Classes, System.Variants, System.SysUtils, Winapi.Messages, Winapi.Windows, FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.DApt.Intf, FireDAC.Phys.Intf, FireDAC.DatS, FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.Stan.Option, FireDAC.Stan.Intf,
{$ELSE}
{$ENDIF}
  db;

type
  TfrmInventarioSituacao = class(TForm)
    Button1: TButton;
    Button2: TButton;
    RadioGroup1: TRadioGroup;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInventarioSituacao: TfrmInventarioSituacao;

implementation

{$IFnDEF FPC}
  {$R *.dfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

procedure TfrmInventarioSituacao.Button1Click(Sender: TObject);
var
  FDQGravar: TZQuery;
  Conexao: TZConnection;
  I: Integer;
  FILTRO_SQL: String;
begin

    try
      Conexao:=TZConnection.Create(Nil);
      DM.ConectarBanco(Conexao);

      FDQGravar:=TZQuery.Create(Nil);
      FDQGravar.Connection:=Conexao;

      with FDQGravar do
      begin
        case RadioGroup1.ItemIndex of
          0..1: FILTRO_SQL:='AND (CASE WHEN I.CONTAGEM_1 IS NOT NULL THEN -1 ELSE 0 END) LIKE :SITUACAO ';
          2: FILTRO_SQL:='';
        end;

        Close;
        SQL.Clear;
        SQL.Add(
                'SELECT '+
                'P.CD_BARRAS, '+
                'A.DS_ARTIGO, '+
                'P.CD_DESTINOS_ULTIMO, '+
                'D.DS_DESTINOS, '+
                'I.CD_BARRAS CD_BARRAS_INVENTARIO, '+
                'I.QT_ARTIGO, '+
                'I.CONTAGEM_1, '+
                'CASE WHEN I.CONTAGEM_1 IS NOT NULL THEN ''INVENTARIADO'' ELSE ''NÃO INVENTARIADO'' END SITUACAO '+
                ' '+
                'FROM PRODUTOS P '+
                ' '+
                'LEFT JOIN INVENTARIO I ON P.CD_BARRAS = I.CD_BARRAS '+
                'LEFT JOIN ARTIGOS A ON P.CD_ARTIGO = A.CD_ARTIGO '+
                'LEFT JOIN DESTINOS D ON P.CD_DESTINOS_ULTIMO = D.CD_DESTINOS ' +

                'WHERE P.IN_ATIVO = ''S'' '+

                FILTRO_SQL +

                'ORDER BY CASE WHEN I.CONTAGEM_1 IS NOT NULL THEN ''INVENTARIADO'' ELSE ''NÃO INVENTARIADO'' END, ' +
                'A.DS_ARTIGO '
                );

        case RadioGroup1.ItemIndex of
          0: ParamByName('SITUACAO').AsInteger:=-1;
          1: ParamByName('SITUACAO').AsInteger:=0;
        end;

        Open();

        if RecordCount > 0 then
        begin
          //DM.frxDBDataset1.DataSet:=FDQGravar;
          DM.frxReport1.LoadFromFile(ExtractFilePath(ParamStr(0)) + '\Relatórios\Inventario_Situacao.fr3');
          DM.frxReport1.ShowReport();
        end;

        //DM.frxDBDataset1.DataSet:=DM.FDQuery1;
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

procedure TfrmInventarioSituacao.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmInventarioSituacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=TCloseAction.caFree;
  frmInventarioSituacao:=Nil;
end;

end.
