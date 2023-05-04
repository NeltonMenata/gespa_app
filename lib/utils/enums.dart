enum NivelUsuario { Administrador, Professor, Aluno }

class Cadastrar {
  final NivelUsuario usuario;
  Cadastrar(this.usuario);
  printar() {
    print(this.usuario);
  }
}
