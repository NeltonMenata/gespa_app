import 'package:flutter/material.dart';
import 'package:gespa_app/Gespa/Screens/widgets/text_with_form.dart';
import 'package:gespa_app/utils/message.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class CadastrarProfessorPage extends StatefulWidget {
  const CadastrarProfessorPage({Key? key}) : super(key: key);

  @override
  State<CadastrarProfessorPage> createState() => _CadastrarProfessorPageState();
}

class _CadastrarProfessorPageState extends State<CadastrarProfessorPage> {
  final identificador = TextEditingController();
  final password = TextEditingController();
  final nome = TextEditingController();
  final disciplina = TextEditingController();
  final turma = TextEditingController();
  final anoLetivo = TextEditingController();

  bool isSaving = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("GESPA"),
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
                children: [
                  const Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "CADASTRO DE PROFESSOR",
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
                                hintText: "Identificador do Professor",
                                controller: identificador),
                            TextWithForm(
                                title: "Senha",
                                hintText: "Senha do Professor",
                                isPassword: true,
                                controller: password),
                            TextWithForm(
                                title: "Nome",
                                hintText: "Nome do Professor",
                                controller: nome),
                            TextWithDrop(
                                title: "Disciplina",
                                controller: disciplina,
                                hintText: "Escolhe a disciplina",
                                list: const [
                                  "Portugues",
                                  "Matematica",
                                  "Historia",
                                  "Geografia",
                                  "Fisica",
                                  "Quimica",
                                  "EVP",
                                  "EMC"
                                ]),
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
                                          turma.text.isEmpty) {
                                        showResultCustom(context,
                                            "Preencha todos os campos corretamente!");
                                        return;
                                      }

                                      setState(() {
                                        isSaving = true;
                                      });
                                      await _cadastrarProfessor(
                                          identificador.text,
                                          password.text,
                                          nome.text,
                                          disciplina.text,
                                          turma.text,
                                          anoLetivo.text);

                                      setState(() {
                                        isSaving = false;
                                        identificador.text = "";
                                        password.text = "";
                                        nome.text = "";
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

  Future<void> _cadastrarProfessor(String username, String password,
      String nome, String disciplina, String turma, String anoLetivo) async {
    final cadProf = ParseUser(
        username.trim(), password.trim(), "${username.trim()}@gmail.com");
    cadProf.set("name", nome);
    cadProf.set("disciplina", disciplina);
    cadProf.set("turma", ParseObject("Turma")..objectId = turma);
    cadProf.set("anoLetivo", ParseObject("AnoLetivo")..objectId = anoLetivo);
    cadProf.set("level", 1);

    final response = await cadProf.signUp();
    if (response.success) {
      await showResultCustom(context, "Professor salvo com sucesso");
    } else {
      await showResultCustom(context,
          "Erro ao salvar o Professor, verifique a internet ou troque o username.",
          isError: true);
    }
  }

  Future<List<ParseObject>> _carregarTurma() async {
    final queryTurma = QueryBuilder(ParseObject("Turma"));

    return await queryTurma.find();
  }

  Future<List<ParseObject>> _carregarAnoLetivo() async {
    final queryAnoLetivo = QueryBuilder(ParseObject("AnoLetivo"));
    return await queryAnoLetivo.find();
  }
}
