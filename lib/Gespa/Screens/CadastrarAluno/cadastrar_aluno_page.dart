import 'package:flutter/material.dart';
import 'package:gespa_app/Gespa/Screens/widgets/text_with_form.dart';
import 'package:gespa_app/utils/message.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class CadastrarAlunoPage extends StatefulWidget {
  const CadastrarAlunoPage({Key? key}) : super(key: key);

  @override
  State<CadastrarAlunoPage> createState() => _CadastrarAlunoPageState();
}

class _CadastrarAlunoPageState extends State<CadastrarAlunoPage> {
  final identificador = TextEditingController();
  final password = TextEditingController();
  final nome = TextEditingController();
  final numeroAluno = TextEditingController();
  final classeAluno = TextEditingController();
  final turma = TextEditingController();
  final turno = TextEditingController();
  final anoLetivo = TextEditingController();
  bool isSaving = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("GESPA"),
      ),
      body: SingleChildScrollView(
        child: Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                opacity: .9,
                fit: BoxFit.cover,
                image: AssetImage("assets/images/garotas.jpg"),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "CADASTRO DE ALUNO",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Container(
                    width: width,
                    height: height * .7,
                    padding: const EdgeInsets.only(right: 8),
                    color: Colors.orange.shade800.withOpacity(.7),
                    child: Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWithForm(
                                title: "Username",
                                hintText: "Identificador do Aluno",
                                controller: identificador),
                            TextWithForm(
                                title: "Senha",
                                hintText: "Senha do Aluno",
                                controller: password),
                            TextWithForm(
                                title: "Nome",
                                hintText: "Nome do Aluno",
                                controller: nome),
                            TextWithForm(
                                title: "Nº do Aluno",
                                hintText: "Nº do Aluno",
                                keyBoardType: TextInputType.number,
                                controller: numeroAluno),
                            FutureBuilder<List<ParseObject>>(
                              future: _carregarTurma(),
                              builder: ((context, snapshot) {
                                if (snapshot.hasData) {
                                  return TextWithDropParseObject(
                                      title: "Turma",
                                      hintText: "Escolhe a turma",
                                      controller: turma,
                                      getObject: "turma",
                                      action: () {},
                                      list: snapshot.data!);
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                            ),
                            FutureBuilder<List<ParseObject>>(
                              future: _carregarAnoLetivo(),
                              builder: ((context, snapshot) {
                                if (snapshot.hasData) {
                                  return TextWithDropParseObject(
                                      title: "Ano Letivo",
                                      hintText: "Escolhe o ano letivo",
                                      controller: anoLetivo,
                                      getObject: "ano",
                                      action: () {},
                                      list: snapshot.data!);
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            isSaving
                                ? const CircularProgressIndicator()
                                : GestureDetector(
                                    onTap: () async {
                                      if (identificador.text.isEmpty ||
                                          password.text.isEmpty ||
                                          nome.text.isEmpty ||
                                          numeroAluno.text.isEmpty) {
                                        showResultCustom(context,
                                            "Preencha todos os campos corretamente!");
                                        return;
                                      }

                                      setState(() {
                                        isSaving = true;
                                      });

                                      await _cadastrarAluno(
                                          identificador.text,
                                          password.text,
                                          nome.text,
                                          numeroAluno.text,
                                          turma.text,
                                          turno.text,
                                          classeAluno.text,
                                          anoLetivo.text);

                                      setState(() {
                                        isSaving = false;

                                        identificador.text = "";
                                        password.text = "";
                                        nome.text = "";
                                        numeroAluno.text = "";
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      width: width * .65,
                                      padding: const EdgeInsets.all(8),
                                      child: Center(
                                          child: Text(
                                        "CADASTRAR",
                                        style: TextStyle(
                                            color: Colors.orange.shade800,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                  ),
                          ]),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Future<void> _cadastrarAluno(
      String username,
      String password,
      String nome,
      String numero,
      String turma,
      String turno,
      String classe,
      String anoLetivo) async {
    final cadAluno = ParseUser(
        username.trim(), password.trim(), "${username.trim()}@gmail.com");

    cadAluno.set("name", nome.trim());
    cadAluno.set("numero", numero.trim());
    cadAluno.set("turma", ParseObject("Turma")..objectId = turma);
    cadAluno.set("anoLetivo", ParseObject("AnoLetivo")..objectId = anoLetivo);
    cadAluno.set("level", 2);

    final queryAluno = QueryBuilder(ParseObject("_User"))
      ..whereEqualTo("numero", numero.trim())
      ..whereEqualTo(
          "anoLetivo", ParseObject("AnoLetivo")..objectId = anoLetivo)
      ..whereEqualTo("turma", ParseObject("Turma")..objectId = turma);
    //..whereEqualTo("turma", ParseObject("turma")..objectId = turma);
    final respQuery = await queryAluno.first();
    if (respQuery != null) {
      showResultCustom(context,
          "Erro ao salvar Aluno. Já existe um aluno com este número nessa turma.",
          isError: true);
      return;
    }
    final response = await cadAluno.signUp();
    if (response.success) {
      showResultCustom(context, "Aluno salvo com sucesso");
    } else {
      showResultCustom(context,
          "Erro ao salvar Aluno, verifique a internet ou troque o username. ${response.error}",
          isError: true);
    }
  }

  Future<List<ParseObject>> _carregarTurma() async {
    final queryTurma = QueryBuilder(ParseObject("Turma"));

    return await queryTurma.find();
  }

  Future<List<ParseObject>> _carregarAnoLetivo() async {
    final queryAnoLetivo = QueryBuilder(ParseObject("AnoLetivo"))
      ..orderByAscending("ano");
    return await queryAnoLetivo.find();
  }
}
