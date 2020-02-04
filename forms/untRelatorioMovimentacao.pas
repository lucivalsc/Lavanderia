unit untRelatorioMovimentacao;

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
{$IFnDEF FPC}
  Vcl.ExtCtrls, Vcl.Mask, Vcl.StdCtrls, Vcl.Dialogs, Vcl.Forms, Vcl.Controls, Vcl.Graphics, System.Classes, System.Variants, System.SysUtils, Winapi.Messages, Winapi.Windows, FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.DApt.Intf, FireDAC.Phys.Intf, FireDAC.DatS, FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.Stan.Option, FireDAC.Stan.Intf, Mask,
{$ELSE}
  MaskEdit,
{$ENDIF}
  db;

type
  TfrmRelatorioMovimentacao = class(TForm)
    Button1: TButton;
    Button2: TButton;
    MaskEdit1: TMaskEdit;
    Label1: TLabel;
    MaskEdit2: TMaskEdit;
    Label2: TLabel;
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
  frmRelatorioMovimentacao: TfrmRelatorioMovimentacao;

implementation

{$IFnDEF FPC}
  {$R *.dfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

procedure TfrmRelatorioMovimentacao.Button1Click(Sender: TObject);
var
  FILTRO_ENTRADA, FILTRO_RELATORIO, TIPO_MOVIMENTACAO: String;

  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin
  try
    Conexao:=TZConnection.Create(Nil);
    DM.ConectarBanco(Conexao);

    FDQGravar:=TZQuery.Create(Nil);
    FDQGravar.Connection:=Conexao;

    if RadioGroup1.ItemIndex = 0 then
    begin
      FILTRO_ENTRADA:='AND M.TP_MOVIMENTACAO = ''E'' ';
      TIPO_MOVIMENTACAO:='Entrada';
    end
      else
      begin
        FILTRO_ENTRADA:='AND M.TP_MOVIMENTACAO = ''S'' ';
        TIPO_MOVIMENTACAO:='Saída';
      end;

    with FDQGravar do
    begin
      Close;
      SQL.Clear;
      SQL.Add(
              'SELECT '+
              QuotedStr(MaskEdit1.Text) + QuotedStr(' à ' + MaskEdit2.Text) + ' PERIODO, '+
              QuotedStr(TIPO_MOVIMENTACAO) + ' TIPO_MOVIMENTACAO, '+
              'M.CD_BARRAS, '+
              'D.CD_DESTINOS, '+
              'D.DS_DESTINOS, '+
              'A.DS_ARTIGO, '+
              'COUNT(*) TOTAL '+
              ' '+
              'FROM MOVIMENTACAO M '+
              ' '+
              'LEFT JOIN PRODUTOS P ON '+
              'M.CD_BARRAS = P.CD_BARRAS '+
              ' '+
              'LEFT JOIN DESTINOS D ON '+
              'D.CD_DESTINOS = M.CD_DESTINOS '+
              ' '+
              'LEFT JOIN ARTIGOS A ON '+
              'A.CD_ARTIGO = P.CD_ARTIGO '+
              ' '+
              'WHERE M.DT_MOVIMENTACAO BETWEEN :DT_INICIAL AND :DT_FINAL '+
              'AND M.CD_DESTINOS IS NOT NULL '+
              ' '+
              FILTRO_ENTRADA +

              'GROUP BY '+
              QuotedStr(MaskEdit1.Text) + QuotedStr(' à ' + MaskEdit2.Text) + ', '+
              QuotedStr(TIPO_MOVIMENTACAO) + ', '+
              'M.CD_BARRAS, '+
              'D.CD_DESTINOS, '+
              'D.DS_DESTINOS, '+
              'A.DS_ARTIGO ' +
              ' '+

              'ORDER BY D.CD_DESTINOS '
              );

      ParamByName('DT_INICIAL').Value :=  StrToDateTime(MaskEdit1.Text);
      ParamByName('DT_FINAL').Value   :=  StrToDateTime(MaskEdit2.Text);
      Open();

      if RecordCount > 0 then
      begin
        //DM.frxDBDataset1.DataSet:=FDQGravar;
        //DM.frxReport1.LoadFromFile(ExtractFilePath(ParamStr(0))  + '\Relatórios\RelatorioMovimentacaoDiaria.fr3');
        //DM.frxReport1.ShowReport();
      end else ShowMessage('Não existem dados para serem exibidos.');
    end;

    //FDQGravar.DisposeOf;
    //Conexao.DisposeOf;
    //DM.frxDBDataset1.DataSet:=DM.FDQuery1;

  except on E: Exception do
    begin
      //ShowMessage(E.Message);
      //FDQGravar.DisposeOf;
      //Conexao.DisposeOf;
    end;
  end;
end;

procedure TfrmRelatorioMovimentacao.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmRelatorioMovimentacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
  frmRelatorioMovimentacao:=Nil;
end;

end.
