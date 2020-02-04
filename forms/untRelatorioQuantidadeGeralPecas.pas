unit untRelatorioQuantidadeGeralPecas;

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
  Vcl.Mask, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Dialogs, Vcl.Forms, Vcl.Controls, Vcl.Graphics, System.Classes, System.Variants, System.SysUtils, Winapi.Messages, Winapi.Windows, Mask,
{$ELSE}
  MaskEdit,
{$ENDIF}
  DB;

type
  TfrmRelatorioQuantidadeGeralPecas = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    RadioGroup1: TRadioGroup;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorioQuantidadeGeralPecas: TfrmRelatorioQuantidadeGeralPecas;

implementation

{$IFnDEF FPC}
  {$R *.dfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

procedure TfrmRelatorioQuantidadeGeralPecas.Button1Click(Sender: TObject);
var
  FILTRO_ENTRADA, FILTRO_RELATORIO: String;
begin
  with DM, DM.ZQuery1 do
  begin
    if RadioGroup1.ItemIndex = 0 then
      FILTRO_ENTRADA:='WHERE IN_ATIVO = ''S'' '
      else
        FILTRO_ENTRADA:='WHERE IN_ATIVO = ''N'' ';

    Close;
    SQL.Clear;
    SQL.Add(
            'SELECT '+
            'P.CD_ARTIGO, '+
            'A.DS_ARTIGO, '+
            'COUNT(*) TOTAL,  '+
            'CASE WHEN P.IN_ATIVO = ''S'' THEN ''ATIVAS'' ELSE ''INATIVAS'' END ATIVO '+
            'FROM PRODUTOS P '+

            'LEFT JOIN ARTIGOS A ON '+
            'P.CD_ARTIGO = A.CD_ARTIGO '+

            FILTRO_ENTRADA +

            'GROUP BY '+
            'P.CD_ARTIGO, '+
            'A.DS_ARTIGO, '+
            'CASE WHEN P.IN_ATIVO = ''S'' THEN ''ATIVAS'' ELSE ''INATIVAS'' END '+

            'ORDER BY DS_ARTIGO ');

    Open();

    if RecordCount > 0 then
    begin
      frxReport1.LoadFromFile(ExtractFilePath(ParamStr(0))  + '\Relatórios\RelatorioQuantidadeGeralPecas.fr3');
      frxReport1.ShowReport();
    end else
      ShowMessage('Não existem dados para serem exibidos.');
  end;
end;

procedure TfrmRelatorioQuantidadeGeralPecas.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmRelatorioQuantidadeGeralPecas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
  frmRelatorioQuantidadeGeralPecas:=Nil;
end;

end.
