unit untRelatorioOcorrencias;

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
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, Data.DB, FireDAC.DApt, FireDAC.Stan.Async, FireDAC.DApt.Intf, FireDAC.Phys.Intf, FireDAC.DatS, FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.Stan.Option, FireDAC.Stan.Intf, Vcl.Mask, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Dialogs, Vcl.Forms, Vcl.Controls, Vcl.Graphics, System.Classes, System.Variants, System.SysUtils, Winapi.Messages, Winapi.Windows, Mask,
{$ELSE}
  MaskEdit,
{$ENDIF}
  DB;

type
  TfrmRelatorioOcorrencias = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    RadioGroup1: TRadioGroup;
    edtMaiorIgual: TEdit;
    Label3: TLabel;
    ComboBox1: TComboBox;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorioOcorrencias: TfrmRelatorioOcorrencias;

implementation

{$IFnDEF FPC}
  {$R *.dfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

procedure TfrmRelatorioOcorrencias.Button1Click(Sender: TObject);
const
  NUMERO_LAVAGENS: String =
                            'SELECT '+
                            'M.CD_PRODUTO, '+
                            'A.DS_ARTIGO, '+
                            'COUNT(*) TOTAL '+
                            'FROM MOVIMENTACAO M '+
                            ' '+
                            'LEFT JOIN PRODUTOS P ON '+
                            'P.CD_PRODUTO = M.CD_PRODUTO '+
                            ' '+
                            'LEFT JOIN ARTIGOS A ON '+
                            'A.CD_ARTIGO = P.CD_ARTIGO '+
                            ' '+
                            'WHERE M.CD_ORIGEM IN (SELECT CD_DESTINOS FROM DESTINOS WHERE IN_LAVAGEM = ''S'') '+
                            'AND DT_MOVIMENTACAO BETWEEN :DT_INICIAL AND :DT_FINAL '+
                            'GROUP BY M.CD_PRODUTO, A.DS_ARTIGO '+
                            'HAVING  COUNT(*) >= :MAIOR_IGUAL '+
                            'ORDER BY TOTAL '
                            ;
var
  FILTRO_ENTRADA: String;
begin
  if RadioGroup1.ItemIndex = 0 then
    FILTRO_ENTRADA:=''
    else
      if RadioGroup1.ItemIndex = 1 then
        FILTRO_ENTRADA:=NUMERO_LAVAGENS;

  try
    with DM, DM.ZQuery1 do
    begin
      Close;
      SQL.Clear;
      SQL.Add(FILTRO_ENTRADA);

      ParamByName('MAIOR_IGUAL').Value:=StrToIntDef(edtMaiorIgual.Text, 0);
      ParamByName('DT_INICIAL').Value:=StrToDateTime(MaskEdit1.Text);
      ParamByName('DT_FINAL').Value:=StrToDateTime(MaskEdit2.Text);
      Open();

      if RecordCount > 0 then
      begin
        //frxReport1.LoadFromFile({$IFNDEF UNICODE}gsAppPath +{$ENDIF} '\Relatorios\RelatorioQuantidadeLavagem.fr3');
        //frxReport1.ShowReport();
      end else
        ShowMessage('Não existem dados para serem exibidos.');
    end;

  except on E: Exception do

  end;
end;

procedure TfrmRelatorioOcorrencias.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmRelatorioOcorrencias.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
  frmRelatorioOcorrencias:=Nil;
end;

procedure TfrmRelatorioOcorrencias.RadioGroup1Click(Sender: TObject);
begin
  if RadioGroup1.ItemIndex = 1 then
  begin
    Label4.Visible:=False;
    ComboBox1.Visible:=False;
    Label3.Visible:=True;
    edtMaiorIgual.Visible:=True;
  end else
    if RadioGroup1.ItemIndex <> 1 then
    begin
      Label4.Visible:=True;
      ComboBox1.Visible:=True;
      Label3.Visible:=False;
      edtMaiorIgual.Visible:=False;
    end

end;

end.
