import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
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
                                        backgroundColor: Colors.green.shade700);
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
                          action: () {},
                          hintText: "Escolha o número do aluno",
                        ),
                        TextWithForm(
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                        TextWithDrop(
                            title: "Mês",
                            hintText: "Escolhe o mês",
                            controller: TextEditingController(),
                            list: _selectThree == 0
                                ? ["Setembro", "Outubro", "Novembro"]
                                : _selectThree == 1
                                    ? ["Dezembro", "Janeiro", "Fevereiro"]
                                    : ["Março", "Abril", "Maio"]),
                        TextWithDrop(
                            title: "Semana",
                            hintText: "Escolhe a semana",
                            controller: TextEditingController(),
                            list: ["1ª", "2ª", "3ª", "4ª"]),
                        TextWithForm(
                            title: "Nota",
                            hintText: "Nota do Aluno",
                            controller: TextEditingController()),
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
                                  await _lancarNotas(turma.text);

                                  setState(() {
                                    isSaving = false;
                                    mes.text = "";
                                    semana.text = "";
                                    nota.text = "";
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50)),
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
                      ],
                    ),
                  )
                : Container(
                    color: Colors.black38,
                  ),
          ),
          Container(
            height: height * .1,
            color: Colors.orange.shade800,
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

  Future<void> _lancarNotas(String nota) async {}
}
