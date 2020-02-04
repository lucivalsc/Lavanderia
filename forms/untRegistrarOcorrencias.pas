unit untRegistrarOcorrencias;

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
  Data.Bind.DBScope, Data.Bind.Components, Vcl.Bind.DBEngExt, Data.Bind.EngExt, Vcl.Bind.Editors, System.Bindings.Outputs, System.Rtti, FireDAC.Comp.Client, FireDAC.Comp.DataSet, Data.DB, FireDAC.DApt, FireDAC.Stan.Async, FireDAC.DApt.Intf, FireDAC.Phys.Intf, FireDAC.DatS, FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.Stan.Option, FireDAC.Stan.Intf, Vcl.StdCtrls, Vcl.ToolWin, Vcl.ComCtrls, Vcl.Buttons, Vcl.Dialogs, Vcl.Forms, Vcl.Controls, Vcl.Graphics, System.Classes, System.Variants, System.SysUtils, Winapi.Messages, Winapi.Windows, Vcl.Mask, Mask,
{$ELSE}
  MaskEdit,
{$ENDIF}
  DB;

type
  TfrmRegistrarOcorrencias = class(TForm)
    Label1: TLabel;
    edtCodigo: TEdit;
    Label2: TLabel;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    Label4: TLabel;
    Label5: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodigoChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRegistrarOcorrencias: TfrmRegistrarOcorrencias;

implementation

{$IFnDEF FPC}
  {$R *.dfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

uses untPrincipal;

procedure TfrmRegistrarOcorrencias.Button1Click(Sender: TObject);
var
  CD_PRODUTO: Integer;
  FDQGravar: TZQuery;
  Conexao: TZConnection;
  ATIVO: String;
begin
  ATIVO:='S';
  if CheckBox1.Checked = True then
    ATIVO:='N'
    else
      ATIVO:='S';

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
              'CD_PRODUTO, '+
              'CD_BARRAS '+

              'FROM CODIGO_BARRAS '+

              'WHERE CD_BARRAS = :CD_BARRAS ');
      ParamByName('CD_BARRAS').AsString:=edtCodigo.Text;
      Open();

      CD_PRODUTO:=StrToIntDef(FieldByName('CD_PRODUTO').AsString, 0);

      if FieldByName('CD_PRODUTO').AsString <> '' then
      begin
        Close;
        SQL.Clear;
        SQL.Add('UPDATE PRODUTOS '+
                'SET '+
                'DT_BAIXA = :DT_BAIXA, '+
                'IN_ATIVO =:IN_ATIVO, '+
                'CD_MOTIVO_BAIXA =:CD_MOTIVO_BAIXA '+
                'WHERE CD_PRODUTO = :CD_PRODUTO ');

        ParamByName('DT_BAIXA').AsDateTime  :=  Now;
        ParamByName('CD_PRODUTO').AsInteger       :=  CD_PRODUTO;
        ParamByName('IN_ATIVO').AsString          :=  ATIVO;
//        ParamByName('CD_MOTIVO_BAIXA').AsInteger  :=  FDQMotivoOcorrencias.FieldByName('CD_MOTIVO_BAIXA').AsInteger;
        ExecSQL;

        //Gravar na tabela Ocorrências
        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO OCORRENCIAS '+
                'VALUES('+
                ':CD_BARRAS, '+
                ':CD_PRODUTO, '+
                ':CD_MOTIVO_BAIXA, '+
                ':CD_FUNCIONARIO, '+
                ':DT_REGISTRO, '+
                ':IN_ATIVO)');

        ParamByName('CD_BARRAS').AsInteger        :=  StrToInt(edtCodigo.Text);
        ParamByName('CD_PRODUTO').AsInteger       :=  CD_PRODUTO;
//        ParamByName('CD_MOTIVO_BAIXA').AsInteger  :=  FDQMotivoOcorrencias.FieldByName('CD_MOTIVO_BAIXA').AsInteger;
        ParamByName('DT_REGISTRO').AsDateTime     :=  Now;
        ParamByName('IN_ATIVO').AsString          :=  ATIVO;
        ExecSQL;

        ShowMessage('Registrado com sucesso.');

        edtCodigo.Text:='';
        ComboBox1.ItemIndex:=-1;

      end;
    end;

//    FDQGravar.DisposeOf;
//    Conexao.DisposeOf;

  except on E: Exception do
    begin
      ShowMessage(E.Message);

//      FDQGravar.DisposeOf;
//      Conexao.DisposeOf;
    end;
  end;
end;

procedure TfrmRegistrarOcorrencias.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmRegistrarOcorrencias.Button3Click(Sender: TObject);
var
  FDQGravar: TZQuery;
  Conexao: TZConnection;
begin
//
//    try
//      Conexao:=TZConnection.Create(Nil);
//      DM.ConectarBanco(Conexao);
//
//      FDQGravar:=TZQuery.Create(Nil);
//      FDQGravar.Connection:=Conexao;
//
//      with FDQGravar do
//      begin
//        Close;
//        SQL.Clear;
//        SQL.Add(
//                'SELECT '+
//                'P.CD_BARRAS, '+
//                'A.DS_ARTIGO, '+
//                'P.CD_DESTINOS_ULTIMO, '+
//                'D.DS_DESTINOS, '+
//                'COALESCE(MB.DS_MOTIVO_BAIXA, ''NÃO REGISTRADO'') DS_MOTIVO_BAIXA '+
//                ' '+
//                'FROM PRODUTOS P '+
//                ' '+
//                'LEFT JOIN ARTIGOS A ON P.CD_ARTIGO = A.CD_ARTIGO '+
//                'LEFT JOIN DESTINOS D ON P.CD_DESTINOS_ULTIMO = D.CD_DESTINOS '+
//                'LEFT JOIN MOTIVO_BAIXA MB ON MB.CD_MOTIVO_BAIXA = P.CD_MOTIVO_BAIXA '+
//                ' '+
//                'WHERE P.IN_ATIVO = ''N'' ' +
//                'AND P.DT_BAIXA BETWEEN :DT_INICIAL AND :DT_FINAL '+
//
//                'ORDER BY COALESCE(MB.DS_MOTIVO_BAIXA, ''NÃO REGISTRADO'') '
//                );
//        ParamByName('DT_INICIAL').AsDateTime  :=StrToDateTime(MaskEdit1.Text + ' 00:00:00');
//        ParamByName('DT_FINAL').AsDateTime    :=StrToDateTime(MaskEdit2.Text + ' 23:59:59');
//        Open();
//
//        if RecordCount > 0 then
//        begin
//          DM.frxDBDataset1.DataSet:=FDQGravar;
//          DM.frxReport1.LoadFromFile(ExtractFilePath(ParamStr(0)) + '\Relatórios\RelatorioOcorrencias.fr3');
//          DM.frxReport1.ShowReport();
//        end;
//
//        DM.frxDBDataset1.DataSet:=DM.FDQuery1;
//      end;
//
//      FreeAndNil(FDQGravar);
//      FreeAndNil(Conexao);
//
//    except on E: Exception do
//      begin
//        ShowMessage(E.Message);
//        FreeAndNil(FDQGravar);
//        FreeAndNil(Conexao);
//      end;
//    end;
end;

procedure TfrmRegistrarOcorrencias.edtCodigoChange(Sender: TObject);
var
  FDQGravar: TZQuery;
begin
  //FDQGravar:=TZQuery.Create(Nil);
  //FDQGravar.Connection:=DM.FDConnection1;
  //
  //with FDQGravar do
  //begin
  //  Close;
  //  SQL.Clear;
  //  SQL.Add('SELECT '+
  //          'P.CD_PRODUTO, '+
  //          'CB.CD_BARRAS, '+
  //          'A.CD_ARTIGO, '+
  //          'A.DS_ARTIGO, '+
  //          'P.IN_ATIVO, '+
  //          'MAX(CB.DT_CADASTRO) DT_CADASTRO '+
  //
  //          'FROM PRODUTOS P '+
  //
  //          'INNER JOIN CODIGO_BARRAS CB ON '+
  //          'P.CD_PRODUTO = CB.CD_PRODUTO '+
  //
  //          'INNER JOIN ARTIGOS A ON '+
  //          'P.CD_ARTIGO = A.CD_ARTIGO '+
  //
  //          'WHERE CB.CD_BARRAS = :CD_BARRAS '+
  //         // 'AND IN_ATIVO = ''S'' '+
  //
  //          'GROUP BY '+
  //          'P.CD_PRODUTO, '+
  //          'CB.CD_BARRAS, '+
  //          'A.CD_ARTIGO, '+
  //          'A.DS_ARTIGO, '+
  //          'P.IN_ATIVO');
  //
  //  ParamByName('CD_BARRAS').AsString:=edtCodigo.Text;
  //  Open();
  //
  //  if RecordCount > 0 then
  //  begin
  //    Edit1.Text:=UpperCase(FieldByName('DS_ARTIGO').AsString);
  //    //ComboBox1.ItemIndex:=FDQMotivoOcorrencias.FieldByName('CD_MOTIVO_BAIXA').AsInteger;
  //    if FieldByName('IN_ATIVO').AsString = 'N' then
  //      CheckBox1.Checked := True
  //      else
  //      CheckBox1.Checked := False;
  //  end else Edit1.Text:='';
  //
  //end;
  //
  //FreeAndNil(FDQGravar);
end;

procedure TfrmRegistrarOcorrencias.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
  frmRegistrarOcorrencias:=Nil;
end;

procedure TfrmRegistrarOcorrencias.FormCreate(Sender: TObject);
begin
  MaskEdit1.Text:=DateToStr(Now - 30);
  MaskEdit2.Text:=DateToStr(Now);
end;

end.

