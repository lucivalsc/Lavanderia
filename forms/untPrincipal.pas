unit untPrincipal;

{$mode objfpc}{$H+}

interface

uses
   untRelatorioMovimentacao, untRelatorioQuantidadeGeralPecas,
			untRelatorioQuantidadePecasSetor, untRegistrarOcorrencias,
			untRelatorioOcorrencias, untSobre, untRegistrarSaidas, untCadastroProdutos,
			untCadastroFornecedores, untMotivoBaixa, untCadastroArtigos,
			untCadastroMarca, untLeitos, untQuarto, untUnidadeHospitalar, Classes,
			SysUtils, Forms, Controls, Graphics, Dialogs, Menus, UCBase, UCZEOSConn;

type

			{ TfrmPrincipal }

   TfrmPrincipal = class(TForm)
						Ajuda1: TMenuItem;
						Alterarsenha1: TMenuItem;
						Arquivo1: TMenuItem;
						Artigos1: TMenuItem;
						Cadastrarusurios1: TMenuItem;
						Configuraes1: TMenuItem;
						Fornecedor1: TMenuItem;
						MainMenu1: TMainMenu;
						Marca1: TMenuItem;
						Marca2: TMenuItem;
						MenuItem1: TMenuItem;
						MenuItem2: TMenuItem;
						MotivodaBaixa1: TMenuItem;
						Movimentaes1: TMenuItem;
						Movimento1: TMenuItem;
						Movimento2: TMenuItem;
						N1: TMenuItem;
						N10: TMenuItem;
						N12: TMenuItem;
						N2: TMenuItem;
						N3: TMenuItem;
						N4: TMenuItem;
						N5: TMenuItem;
						N6: TMenuItem;
						N7: TMenuItem;
						N9: TMenuItem;
						Peasporsetor1: TMenuItem;
						Produtos1: TMenuItem;
						QuantidadedePeasxSituao1: TMenuItem;
						RegistrarOcorrncias1: TMenuItem;
						Registrarsada1: TMenuItem;
						Relatrios1: TMenuItem;
						Sair1: TMenuItem;
						Segurana1: TMenuItem;
						Setores1: TMenuItem;
						Setores2: TMenuItem;
						Sobre1: TMenuItem;
						TrocardeUsuario1: TMenuItem;
						UCZEOSConn1: TUCZEOSConn;
						UserControl1: TUserControl;
						procedure Artigos1Click(Sender: TObject);
						procedure Fornecedor1Click(Sender: TObject);
      procedure Marca2Click(Sender: TObject);
      procedure MenuItem1Click(Sender: TObject);
						procedure MenuItem2Click(Sender: TObject);
						procedure MotivodaBaixa1Click(Sender: TObject);
						procedure Movimentaes1Click(Sender: TObject);
						procedure Peasporsetor1Click(Sender: TObject);
						procedure Produtos1Click(Sender: TObject);
						procedure QuantidadedePeasxSituao1Click(Sender: TObject);
						procedure RegistrarOcorrncias1Click(Sender: TObject);
						procedure Registrarsada1Click(Sender: TObject);
      procedure Setores1Click(Sender: TObject);
						procedure Sobre1Click(Sender: TObject);
   private

   public
      procedure AbrirForm(FormClass: TComponentClass);
   end;

var
   frmPrincipal: TfrmPrincipal;
   FormAtivo: TForm;

implementation

{$R *.lfm}

{ TfrmPrincipal }

procedure TfrmPrincipal.Setores1Click(Sender: TObject);
begin
   AbrirForm(TfrmUnidadeHospitalar);
end;

procedure TfrmPrincipal.Sobre1Click(Sender: TObject);
begin
   AbrirForm(TfrmSobre);
end;

procedure TfrmPrincipal.MenuItem1Click(Sender: TObject);
begin
   AbrirForm(TfrmQuarto);
end;

procedure TfrmPrincipal.Marca2Click(Sender: TObject);
begin
   AbrirForm(TfrmCadastroMarca);
end;

procedure TfrmPrincipal.Artigos1Click(Sender: TObject);
begin
   AbrirForm(TfrmCadastroArtigos);
end;

procedure TfrmPrincipal.Fornecedor1Click(Sender: TObject);
begin
   AbrirForm(TfrmCadastroFornecedores);
end;

procedure TfrmPrincipal.MenuItem2Click(Sender: TObject);
begin
   AbrirForm(TfrmLeitos);
end;

procedure TfrmPrincipal.MotivodaBaixa1Click(Sender: TObject);
begin
   AbrirForm(TfrmMotivoBaixa);
end;

procedure TfrmPrincipal.Movimentaes1Click(Sender: TObject);
begin
   AbrirForm(TfrmRelatorioMovimentacao);
end;

procedure TfrmPrincipal.Peasporsetor1Click(Sender: TObject);
begin
   AbrirForm(TfrmRelatorioQuantidadePecasSetor);
end;

procedure TfrmPrincipal.Produtos1Click(Sender: TObject);
begin
   AbrirForm(TfrmCadastroProdutos);
end;

procedure TfrmPrincipal.QuantidadedePeasxSituao1Click(Sender: TObject);
begin
   AbrirForm(TfrmRelatorioQuantidadeGeralPecas);
end;

procedure TfrmPrincipal.RegistrarOcorrncias1Click(Sender: TObject);
begin
   AbrirForm(TfrmRegistrarOcorrencias);
end;

procedure TfrmPrincipal.Registrarsada1Click(Sender: TObject);
begin
   AbrirForm(TfrmRegistrarSaidas);
end;

procedure TfrmPrincipal.AbrirForm(FormClass: TComponentClass);
begin
	  try
	    if Assigned(FormAtivo) then
	    begin
	      if FormAtivo.ClassType = FormClass then
	        Exit
	        else
	        begin
	          FormAtivo.Destroy;
	          FormAtivo:=Nil;
	        end;
	    end;
	    Application.CreateForm(FormClass, FormAtivo);
     FormAtivo.Position:=poMainFormCenter;
     FormAtivo.ShowModal;

			finally
     FormAtivo.Destroy;
     FormAtivo:=Nil;
			end;
end;

end.

