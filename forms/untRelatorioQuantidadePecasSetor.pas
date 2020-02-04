unit untRelatorioQuantidadePecasSetor;

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
  Data.Bind.DBScope, Data.Bind.Components, Vcl.Bind.DBEngExt, Data.Bind.EngExt, Vcl.Bind.Editors, System.Bindings.Outputs, System.Rtti, Data.DB, Vcl.Mask, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Dialogs, Vcl.Forms, Vcl.Controls, Vcl.Graphics, System.Classes, System.Variants, System.SysUtils, Winapi.Messages, Winapi.Windows, FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.DApt.Intf, FireDAC.Phys.Intf, FireDAC.DatS, FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.Stan.Option, FireDAC.Stan.Intf,
{$ELSE}
{$ENDIF}
  DB;

type

		{ TfrmRelatorioQuantidadePecasSetor }

  TfrmRelatorioQuantidadePecasSetor = class(TForm)
					BufDataset1: TBufDataset;
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ListarSetores;
  end;

var
  frmRelatorioQuantidadePecasSetor: TfrmRelatorioQuantidadePecasSetor;

implementation

{$IFnDEF FPC}
  {$R *.dfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

procedure TfrmRelatorioQuantidadePecasSetor.Button1Click(Sender: TObject);
var
  FDQGravar: TZQuery;
  Conexao: TZConnection;
  FILTRO: String;
begin
  if ComboBox1.Text = 'TODOS OS SETORES' then
    FILTRO:=''
    else
      //FILTRO:=' AND P.CD_DESTINOS_ULTIMO = ' + QuotedStr(BufDataset.FieldByName('CD_DESTINOS').AsString);

  try
    Conexao:=TZConnection.Create(Nil);
    DM.ConectarBanco(Conexao);

    FDQGravar:=TZQuery.Create(Nil);
    FDQGravar.Connection:=Conexao;
    with FDQGravar do
    begin
      Close;
      SQL.Clear;
      SQL.Add(
              'SELECT '+
              'P.CD_DESTINOS_ULTIMO, '+
              'D.DS_DESTINOS, '+
              'A.DS_ARTIGO, '+
              'P.CD_BARRAS, '+
              'COUNT(*) TOTAL '+
              ' '+
              'FROM PRODUTOS P '+
              ' '+
              'LEFT JOIN DESTINOS D ON '+
              'D.CD_DESTINOS = P.CD_DESTINOS_ULTIMO '+
              ' '+
              'LEFT JOIN ARTIGOS A ON A.CD_ARTIGO = P.CD_ARTIGO '+
              ' '+
              'WHERE IN_ATIVO = ''S'' '+
              ' '+
              FILTRO +
              ' '+
              'GROUP BY '+
              'P.CD_DESTINOS_ULTIMO, '+
              'D.DS_DESTINOS, '+
              'A.DS_ARTIGO, '+
              'P.CD_BARRAS '+
              'ORDER BY D.DS_DESTINOS, A.DS_ARTIGO '
              );
      Open();

      if RecordCount > 0 then
      begin
        //DM.frxDBDataset1.DataSet:=FDQGravar;
        //DM.frxReport1.LoadFromFile(ExtractFilePath(ParamStr(0))  + '\Relatórios\RelatorioQuantidadePecasSetor.fr3');
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

procedure TfrmRelatorioQuantidadePecasSetor.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmRelatorioQuantidadePecasSetor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
  frmRelatorioQuantidadePecasSetor:=Nil;
end;

procedure TfrmRelatorioQuantidadePecasSetor.FormCreate(Sender: TObject);
begin
  ListarSetores;
end;

procedure TfrmRelatorioQuantidadePecasSetor.ListarSetores;
var
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
      SQL.Add(
              'SELECT * FROM DESTINOS '+
              'ORDER BY DS_DESTINOS'
              );
      Open();

      if RecordCount > 0 then
      begin
        BufDataset1.Close;
        BufDataset1.CreateDataSet;

        First;
        DisableControls;

        BufDataset1.Append;
        BufDataset1.FieldByName('CD_DESTINOS').AsInteger:=-1;
        BufDataset1.FieldByName('DS_DESTINOS').AsString:='TODOS OS SETORES';
        BufDataset1.Post;

        while not Eof do
        begin
          BufDataset1.Append;
          BufDataset1.FieldByName('CD_DESTINOS').AsInteger :=  FieldByName('CD_DESTINOS').AsInteger;
          BufDataset1.FieldByName('DS_DESTINOS').AsString  :=  FieldByName('DS_DESTINOS').AsString;
          BufDataset1.Post;
          Next;
        end;
        BufDataset1.First;
        First;
        EnableControls;
      end;
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

end.
