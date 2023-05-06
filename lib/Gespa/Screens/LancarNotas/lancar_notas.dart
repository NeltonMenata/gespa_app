import 'package:flutter/material.dart';
import 'package:gespa_app/Gespa/Screens/Auth/auth_ui/login/login_controller.dart';
import 'package:gespa_app/Gespa/Screens/widgets/text_with_form.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/message.dart';

class LancarNotasPage extends StatefulWidget {
  const LancarNotasPage({Key? key}) : super(key: key);

  @override
  State<LancarNotasPage> createState() => _LancarNotasPageState();
}

class _LancarNotasPageState extends State<LancarNotasPage> {
  bool _selecionador = true;
  int _selectThree = 0;
  final identificadorAluno = TextEditingController();
  final turma = TextEditingController();
  final mes = TextEditingController();
  final semana = TextEditingController();
  final nota = TextEditingController();
  final disciplina = TextEditingController();
  bool isSaving = false;

  final List<ParseObject> listAluno = [];
  String nomeAluno = "";
  String mesSelecionado = "";

  @override
  Widget build(BuildContext context) {
    disciplina.text = LoginController.userLogado!.get("disciplina");
    final userLogado = LoginController.userLogado!;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("GESPA"),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              "Lançar Notas",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: height * .1,
            color: Colors.orange.shade800,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "MAC",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Radio<bool>(
                          value: true,
                          groupValue: _selecionador,
                          onChanged: (value) {
                            setState(() {
                              _selecionador = value!;
                            });
                          }))
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "PROVAS",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Radio<bool>(
                          value: false,
                          groupValue: _selecionador,
                          onChanged: (value) {
                            setState(() {
                              _selecionador = value!;
                            });
                          }))
                ],
              )
            ]),
          ),
          Expanded(
            flex: 9,
            child: SingleChildScrollView(
              child: _selecionador
                  ? Container(
                      color: Colors.grey.shade600,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FutureBuilder<List<ParseObject>>(
                            future: _carregarTurma(),
                            builder: ((context, snapshot) {
                              if (snapshot.hasData) {
                                return TextWithDropParseObject(
                                    title: "Turma",
                                    hintText: "Escolhe a turma",
                                    controller: turma,
                                    getObject: "turma",
                                    action: () async {
                                      Get.snackbar("Carregando",
                                          "Aguarde o carregamento dos alunos da turma selecionada!");
                                      listAluno.clear();
                                      listAluno.addAll(await _carregarAluno());
                                      setState(() {});
                                      Get.snackbar("Concluido",
                                          "Carregamento de lista de alunos concluido!",
                                          backgroundColor:
                                              Colors.green.shade700);
                                    },
                                    list: snapshot.data!);
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            }),
                          ),
                          TextWithDropParseObject(
                            title: "Nº do Aluno",
                            controller: identificadorAluno,
                            list: listAluno,
                            getObject: "numero",
                            action: () {
                              setState(() {
                                if (listAluno
                                    .where((element) =>
                                        element.objectId ==
                                        identificadorAluno.text)
                                    .isNotEmpty) {
                                  nomeAluno = listAluno
                                      .where((element) =>
                                          element.objectId ==
                                          identificadorAluno.text)
                                      .first
                                      .get("name")
                                      .toString();
                                }
                              });
                            },
                            hintText: "Escolha o número do aluno",
                          ),
                          TextWithBox(
                              title: "Disciplina",
                              hintText: "",
                              controller: disciplina),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "1º Trimestre",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Radio<int>(
                                            value: 0,
                                            groupValue: _selectThree,
                                            onChanged: (value) {
                                              setState(() {
                                                _selectThree = value!;
                                              });
                                            }))
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "2º Trimestre",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Radio<int>(
                                            value: 1,
                                            groupValue: _selectThree,
                                            onChanged: (value) {
                                              setState(() {
                                                _selectThree = value!;
                                              });
                                            }))
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "3º Trimestre",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Radio<int>(
                                            value: 2,
                                            groupValue: _selectThree,
                                            onChanged: (value) {
                                              setState(() {
                                                _selectThree = value!;
                                              });
                                            }))
                                  ],
                                )
                              ]),
                          Visibility(
                              visible: _selectThree == 0,
                              child: TextWithDrop(
                                  title: "Mês",
                                  hintText: "Escolhe o mês",
                                  action: () {
                                    setState(() {
                                      if (mes.text.isNotEmpty) {
                                        mesSelecionado = mes.text;
                                      }
                                    });
                                  },
                                  controller: mes,
                                  list: const [
                                    "Setembro",
                                    "Outubro",
                                    "Novembro"
                                  ])),
                          Visibility(
                              visible: _selectThree == 1,
                              child: TextWithDrop(
                                  title: "Mês",
                                  hintText: "Escolhe o mês",
                                  action: () {
                                    setState(() {
                                      if (mes.text.isNotEmpty) {
                                        mesSelecionado = mes.text;
                                      }
                                    });
                                  },
                                  controller: mes,
                                  list: const [
                                    "Janeiro",
                                    "Fevereiro",
                                    "Março"
                                  ])),
                          Visibility(
                              visible: _selectThree == 2,
                              child: TextWithDrop(
                                  title: "Mês",
                                  hintText: "Escolhe o mês",
                                  action: () {
                                    setState(() {
                                      if (mes.text.isNotEmpty) {
                                        mesSelecionado = mes.text;
                                      }
                                    });
                                  },
                                  controller: mes,
                                  list: const ["Abril", "Maio", "Junho"])),
                          TextWithDrop(
                              title: "Semana",
                              hintText: "Escolhe a semana",
                              controller: semana,
                              list: const ["1ª", "2ª", "3ª", "4ª"]),
                          TextWithForm(
                            title: "Nota",
                            hintText: "Nota do Aluno",
                            keyBoardType: TextInputType.number,
                            controller: nota,
                          ),
                          isSaving
                              ? const CircularProgressIndicator()
                              : GestureDetector(
                                  onTap: () async {
                                    if (mes.text.isEmpty ||
                                        semana.text.isEmpty ||
                                        nota.text.isEmpty ||
                                        turma.text.isEmpty) {
                                      showResultCustom(context,
                                          "Preencha todos os campos corretamente!");
                                      return;
                                    }

                                    setState(() {
                                      isSaving = true;
                                    });
                                    await _lancarNotas(
                                        identificadorAluno.text,
                                        double.parse(turma.text),
                                        disciplina.text,
                                        userLogado.objectId!,
                                        userLogado.get("anoLetivo"));

                                    setState(() {
                                      isSaving = false;
                                      mes.text = "";
                                      semana.text = "";
                                      nota.text = "";
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      width: width * .65,
                                      padding: const EdgeInsets.all(8),
                                      child: Center(
                                          child: Text(
                                        "Lançar nota",
                                        style: TextStyle(
                                            color: Colors.orange.shade800,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    )
                  : Container(
                      color: Colors.red,
                      height: 300,
                      width: 300,
                    ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              //height: height * .05,
              width: width,
              color: Colors.orange.shade800,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "Nome",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            nomeAluno,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "Mês",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            mesSelecionado,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "1ª Sem",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: FutureBuilder<double>(
                              initialData: 0,
                              builder: (context, snapshot) {
                                return Text(
                                  snapshot.data!.toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                );
                              }),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "2ª Sem",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: FutureBuilder<double>(
                              initialData: 0,
                              builder: (context, snapshot) {
                                return Text(
                                  snapshot.data!.toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                );
                              }),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "3ª Sem",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: FutureBuilder<double>(
                              initialData: 0,
                              builder: (context, snapshot) {
                                return Text(
                                  snapshot.data!.toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                );
                              }),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "4ª Sem",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: FutureBuilder<double>(
                              initialData: 0,
                              builder: (context, snapshot) {
                                return Text(
                                  snapshot.data!.toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                );
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<List<ParseObject>> _carregarTurma() async {
    final queryTurma = QueryBuilder(ParseObject("Turma"));

    return await queryTurma.find();
  }

  Future<List<ParseObject>> _carregarAluno() async {
    final queryAluno = QueryBuilder(ParseObject("_User"));
    queryAluno.whereEqualTo("level", 2);
    return await queryAluno.find();
  }

  Future<void> _lancarNotas(
    String alunoObjectId,
    double nota,
    String disciplina,
    String professorObjectId,
    int anoLetivo,
  ) async {
    final mac = ParseObject("MAC");
    mac.set("aluno", ParseObject("_User")..objectId = alunoObjectId);
  }

  Future<double> _consultarNotas() async {
    return 0;
  }
}
