import 'package:flutter/material.dart';
import 'package:gespa_app/Gespa/Screens/Auth/auth_ui/login/login_controller.dart';
import 'package:gespa_app/Gespa/Screens/widgets/text_with_form.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

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
  final nppNota = TextEditingController();
  final nptNota = TextEditingController();
  final disciplina = TextEditingController();
  bool isSaving = false;
  bool isSavingProva = false;

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
        title: GestureDetector(
            onTap: () async {
              //  await qualquer();
              print(turma.text);
              print("Finished");
            },
            child: const Text("GESPA")),
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
            child: SingleChildScrollView(
              child: _selecionador
                  ? Container(
                      color: Colors.grey.shade600,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FutureBuilder<List<ParseObject>>(
                            future: _carregarTurma(
                                userLogado.get("turma").get("objectId")),
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
                                      listAluno.addAll(
                                          await _carregarAluno(turma.text));
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
                                        double.parse(nota.text) > 20 ||
                                        double.parse(nota.text) < 0 ||
                                        turma.text.isEmpty) {
                                      showResultCustom(context,
                                          "Preencha todos os campos corretamente!");
                                      return;
                                    }

                                    setState(() {
                                      isSaving = true;
                                    });

                                    try {
                                      await _lancarNotas(
                                          alunoObjectId:
                                              identificadorAluno.text,
                                          nota: double.parse(nota.text),
                                          disciplina: disciplina.text,
                                          professorObjectId:
                                              userLogado.objectId!,
                                          anoLetivoObjectId: userLogado
                                              .get("anoLetivo")
                                              .get("objectId"),
                                          semana: semana.text,
                                          mes: mes.text,
                                          trimestre: _selectThree == 0
                                              ? "1º"
                                              : _selectThree == 1
                                                  ? "2º"
                                                  : "3º");
                                    } catch (e) {
                                      print(e);
                                    } finally {
                                      setState(() {
                                        isSaving = false;
                                        nota.text = "";
                                      });
                                    }
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
                          Container(
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
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
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
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
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
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: FutureBuilder<double>(
                                            future: _consultarNotas(
                                                alunoObjectId:
                                                    identificadorAluno.text,
                                                disciplina: disciplina.text,
                                                professorObjectId:
                                                    userLogado.objectId!,
                                                anoLetivoObjectId: userLogado
                                                    .get("anoLetivo")
                                                    .get("objectId"),
                                                semana: "1ª",
                                                mes: mes.text,
                                                trimestre: _selectThree == 0
                                                    ? "1º"
                                                    : _selectThree == 1
                                                        ? "2º"
                                                        : "3º"),
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
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: FutureBuilder<double>(
                                            future: _consultarNotas(
                                                alunoObjectId:
                                                    identificadorAluno.text,
                                                disciplina: disciplina.text,
                                                professorObjectId:
                                                    userLogado.objectId!,
                                                anoLetivoObjectId: userLogado
                                                    .get("anoLetivo")
                                                    .get("objectId"),
                                                semana: "2ª",
                                                mes: mes.text,
                                                trimestre: _selectThree == 0
                                                    ? "1º"
                                                    : _selectThree == 1
                                                        ? "2º"
                                                        : "3º"),
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
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: FutureBuilder<double>(
                                            future: _consultarNotas(
                                                alunoObjectId:
                                                    identificadorAluno.text,
                                                disciplina: disciplina.text,
                                                professorObjectId:
                                                    userLogado.objectId!,
                                                anoLetivoObjectId: userLogado
                                                    .get("anoLetivo")
                                                    .get("objectId"),
                                                semana: "3ª",
                                                mes: mes.text,
                                                trimestre: _selectThree == 0
                                                    ? "1º"
                                                    : _selectThree == 1
                                                        ? "2º"
                                                        : "3º"),
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
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: FutureBuilder<double>(
                                            initialData: 0,
                                            future: _consultarNotas(
                                                alunoObjectId:
                                                    identificadorAluno.text,
                                                disciplina: disciplina.text,
                                                professorObjectId:
                                                    userLogado.objectId!,
                                                anoLetivoObjectId: userLogado
                                                    .get("anoLetivo")
                                                    .get("objectId"),
                                                semana: "4ª",
                                                mes: mes.text,
                                                trimestre: _selectThree == 0
                                                    ? "1º"
                                                    : _selectThree == 1
                                                        ? "2º"
                                                        : "3º"),
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
                        ],
                      ),
                    )
                  : Container(
                      color: Colors.grey.shade600,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FutureBuilder<List<ParseObject>>(
                              future: _carregarTurma(
                                  userLogado.get("turma").get("objectId")),
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
                                        listAluno.addAll(
                                            await _carregarAluno(turma.text));
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
                                  ),
                                ]),
                            TextWithForm(
                              title: "NNP",
                              hintText: "Nota da Prova do Professor",
                              keyBoardType: TextInputType.number,
                              controller: nppNota,
                            ),
                            TextWithForm(
                              title: "NPT",
                              hintText: "Nota da Prova do Trimestre",
                              keyBoardType: TextInputType.number,
                              controller: nptNota,
                            ),
                            isSavingProva
                                ? const CircularProgressIndicator()
                                : GestureDetector(
                                    onTap: () async {
                                      if (nppNota.text.isEmpty ||
                                          nptNota.text.isEmpty ||
                                          double.parse(nppNota.text) > 20 ||
                                          double.parse(nppNota.text) < 0 ||
                                          double.parse(nptNota.text) > 20 ||
                                          double.parse(nptNota.text) < 0 ||
                                          turma.text.isEmpty) {
                                        showResultCustom(context,
                                            "Preencha todos os campos corretamente!");
                                        return;
                                      }

                                      setState(() {
                                        isSavingProva = true;
                                      });

                                      try {
                                        await _lancarNotasProvas(
                                            alunoObjectId:
                                                identificadorAluno.text,
                                            npp: double.parse(nppNota.text),
                                            npt: double.parse(nptNota.text),
                                            disciplina: disciplina.text,
                                            professorObjectId:
                                                userLogado.objectId!,
                                            anoLetivoObjectId: userLogado
                                                .get("anoLetivo")
                                                .get("objectId"),
                                            trimestre: _selectThree == 0
                                                ? "1º"
                                                : _selectThree == 1
                                                    ? "2º"
                                                    : "3º");
                                      } catch (e) {
                                        print(e);
                                      } finally {
                                        setState(() {
                                          isSavingProva = false;
                                          nptNota.text = "";
                                          nppNota.text = "";
                                        });
                                      }
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
                            Container(
                              //height: height * .05,
                              width: width,
                              color: Colors.orange.shade800,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Text(
                                            "Nome",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "MAC",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: FutureBuilder<double>(
                                              future: _consultarMacTrimestre(
                                                  alunoObjectId:
                                                      identificadorAluno.text,
                                                  disciplina: disciplina.text,
                                                  professorObjectId:
                                                      userLogado.objectId!,
                                                  anoLetivoObjectId: userLogado
                                                      .get("anoLetivo")
                                                      .get("objectId"),
                                                  trimestre: _selectThree == 0
                                                      ? "1º"
                                                      : _selectThree == 1
                                                          ? "2º"
                                                          : "3º"),
                                              initialData: 0,
                                              builder: (context, snapshot) {
                                                return Text(
                                                  snapshot.data!.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "NPP",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: FutureBuilder<double>(
                                              future: _consultarNotasProvas(
                                                  alunoObjectId:
                                                      identificadorAluno.text,
                                                  nppOrNpt: "npp",
                                                  disciplina: disciplina.text,
                                                  professorObjectId:
                                                      userLogado.objectId!,
                                                  anoLetivoObjectId: userLogado
                                                      .get("anoLetivo")
                                                      .get("objectId"),
                                                  trimestre: _selectThree == 0
                                                      ? "1º"
                                                      : _selectThree == 1
                                                          ? "2º"
                                                          : "3º"),
                                              initialData: 0,
                                              builder: (context, snapshot) {
                                                return Text(
                                                  snapshot.data!.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "NPT",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: FutureBuilder<double>(
                                              future: _consultarNotasProvas(
                                                  alunoObjectId:
                                                      identificadorAluno.text,
                                                  nppOrNpt: "npt",
                                                  disciplina: disciplina.text,
                                                  professorObjectId:
                                                      userLogado.objectId!,
                                                  anoLetivoObjectId: userLogado
                                                      .get("anoLetivo")
                                                      .get("objectId"),
                                                  trimestre: _selectThree == 0
                                                      ? "1º"
                                                      : _selectThree == 1
                                                          ? "2º"
                                                          : "3º"),
                                              initialData: 0,
                                              builder: (context, snapshot) {
                                                return Text(
                                                  snapshot.data!.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "MD",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: FutureBuilder<double>(
                                              future: _calcularMD(
                                                  alunoObjectId:
                                                      identificadorAluno.text,
                                                  disciplina: disciplina.text,
                                                  professorObjectId:
                                                      userLogado.objectId!,
                                                  anoLetivoObjectId: userLogado
                                                      .get("anoLetivo")
                                                      .get("objectId"),
                                                  semana: "3ª",
                                                  mes: mes.text,
                                                  trimestre: _selectThree == 0
                                                      ? "1º"
                                                      : _selectThree == 1
                                                          ? "2º"
                                                          : "3º"),
                                              initialData: 0,
                                              builder: (context, snapshot) {
                                                return Text(
                                                  snapshot.data!.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Trimestre",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              _selectThree == 0
                                                  ? "1º"
                                                  : _selectThree == 1
                                                      ? "2º"
                                                      : "3º",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Trimestre",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              disciplina.text,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ]),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<ParseObject>> _carregarTurma(String profTurma) async {
    final queryTurma = QueryBuilder(ParseObject("Turma"))
      ..whereEqualTo("objectId", profTurma);

    return await queryTurma.find();
  }

  Future<List<ParseObject>> _carregarAluno(String turmaObjectId) async {
    final queryAluno = QueryBuilder(ParseObject("_User"))
      ..whereEqualTo(
          "turma", (ParseObject("Turma")..objectId = turmaObjectId).toPointer())
      ..whereEqualTo("level", 2);
    return await queryAluno.find();
  }

  Future<void> _lancarNotas(
      {required String alunoObjectId,
      required double nota,
      required String disciplina,
      required String professorObjectId,
      required String trimestre,
      required String mes,
      required String semana,
      required String anoLetivoObjectId}) async {
    // CONSULTAR SE EXISTE NOTA ANTES DE SALVAR

    final queryMac = QueryBuilder(ParseObject("MAC"))
      ..whereEqualTo("professor",
          (ParseObject("_User")..objectId = professorObjectId).toPointer())
      ..whereEqualTo(
          "aluno", (ParseObject("_User")..objectId = alunoObjectId).toPointer())
      ..whereEqualTo("disciplina", disciplina)
      ..whereEqualTo("mes", mes)
      ..whereEqualTo("semana", semana)
      ..whereEqualTo("trimestre", trimestre)
      ..whereEqualTo("anoLetivo",
          (ParseObject("AnoLetivo")..objectId = anoLetivoObjectId).toPointer());
    final macExistente = await queryMac.first();

    if (macExistente != null) {
      Get.defaultDialog(
          content: const Text(
              "Este aluno já tem uma nota atribuida. Deseja subscrever?"),
          actions: [
            TextButton(
                onPressed: () async {
                  Get.back();

                  try {
                    macExistente.set("nota", nota);
                    final response = await macExistente.save();

                    if (response.success) {
                      setState(() {
                        showResultCustom(context, "Nota lançada com sucesso");
                      });
                    } else {
                      showResultCustom(context,
                          "Erro ao lançar nota, verifique a sua internet!");
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text("Sim")),
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Não"))
          ]);
    } else {
      try {
        final mac = ParseObject("MAC")
          ..set("professor",
              (ParseObject("_User")..objectId = professorObjectId).toPointer())
          ..set("aluno",
              (ParseObject("_User")..objectId = alunoObjectId).toPointer())
          ..set("disciplina", disciplina)
          ..set("mes", mes)
          ..set("nota", nota)
          ..set("semana", semana)
          ..set("trimestre", trimestre)
          ..set(
              "anoLetivo",
              (ParseObject("AnoLetivo")..objectId = anoLetivoObjectId)
                  .toPointer());

        final response = await mac.save();

        if (response.success) {
          showResultCustom(context, "Nota lançada com sucesso");
        } else {
          showResultCustom(
              context, "Erro ao lançar nota, verifique a sua internet!");
        }
      } catch (e) {
        print(e);
      }
    }
    //
  }

  Future<void> _lancarNotasProvas(
      {required String alunoObjectId,
      required double npp,
      required double npt,
      required String disciplina,
      required String professorObjectId,
      required String trimestre,
      required String anoLetivoObjectId}) async {
    // CONSULTAR SE EXISTE NOTA ANTES DE SALVAR

    final queryProva = QueryBuilder(ParseObject("Provas"))
      ..whereEqualTo("professor",
          (ParseObject("_User")..objectId = professorObjectId).toPointer())
      ..whereEqualTo(
          "aluno", (ParseObject("_User")..objectId = alunoObjectId).toPointer())
      ..whereEqualTo("disciplina", disciplina)
      ..whereEqualTo("trimestre", trimestre)
      ..whereEqualTo("anoLetivo",
          (ParseObject("AnoLetivo")..objectId = anoLetivoObjectId).toPointer());
    final provaExistente = await queryProva.first();

    if (provaExistente != null) {
      Get.defaultDialog(
          content: const Text(
              "Este aluno já tem uma nota atribuida. Deseja subscrever?"),
          actions: [
            TextButton(
                onPressed: () async {
                  this.setState(() {});

                  Get.back();

                  try {
                    provaExistente.set("npp", npp);
                    provaExistente.set("npt", npt);
                    final response = await provaExistente.save();

                    if (response.success) {
                      setState(() {
                        showResultCustom(context, "Nota lançada com sucesso");
                      });
                    } else {
                      showResultCustom(context,
                          "Erro ao lançar nota, verifique a sua internet!");
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text("Sim")),
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Não"))
          ]);
    } else {
      try {
        final prova = ParseObject("Provas")
          ..set("professor",
              (ParseObject("_User")..objectId = professorObjectId).toPointer())
          ..set("aluno",
              (ParseObject("_User")..objectId = alunoObjectId).toPointer())
          ..set("disciplina", disciplina)
          //..set("nota", nota)
          ..set("npp", npp)
          ..set("npt", npt)
          ..set("trimestre", trimestre)
          ..set(
              "anoLetivo",
              (ParseObject("AnoLetivo")..objectId = anoLetivoObjectId)
                  .toPointer());

        final response = await prova.save();

        if (response.success) {
          showResultCustom(context, "Nota lançada com sucesso");
        } else {
          showResultCustom(
              context, "Erro ao lançar nota, verifique a sua internet!");
        }
      } catch (e) {
        print(e);
      }
    }
    //
  }

  Future<double> _calcularMD(
      {required String alunoObjectId,
      required String disciplina,
      required String professorObjectId,
      required String trimestre,
      required String mes,
      required String semana,
      required String anoLetivoObjectId}) async {
    final mac = await _consultarMacTrimestre(
        alunoObjectId: alunoObjectId,
        disciplina: disciplina,
        professorObjectId: professorObjectId,
        trimestre: trimestre,
        anoLetivoObjectId: anoLetivoObjectId);
    final npp = await _consultarNotasProvas(
        alunoObjectId: alunoObjectId,
        nppOrNpt: "npp",
        disciplina: disciplina,
        professorObjectId: professorObjectId,
        trimestre: trimestre,
        anoLetivoObjectId: anoLetivoObjectId);

    final npt = await _consultarNotasProvas(
        alunoObjectId: alunoObjectId,
        nppOrNpt: "npt",
        disciplina: disciplina,
        professorObjectId: professorObjectId,
        trimestre: trimestre,
        anoLetivoObjectId: anoLetivoObjectId);
    return double.parse(((mac + npp + npt) / 3).toStringAsFixed(2));
  }

  Future<double> _consultarMacTrimestre(
      {required String alunoObjectId,
      required String disciplina,
      required String professorObjectId,
      required String trimestre,
      required String anoLetivoObjectId}) async {
    final queryMac = QueryBuilder(ParseObject("MAC"))
      ..whereEqualTo("professor",
          (ParseObject("_User")..objectId = professorObjectId).toPointer())
      ..whereEqualTo(
          "aluno", (ParseObject("_User")..objectId = alunoObjectId).toPointer())
      ..whereEqualTo("disciplina", disciplina)
      ..whereEqualTo("trimestre", trimestre)
      ..whereEqualTo("anoLetivo",
          (ParseObject("AnoLetivo")..objectId = anoLetivoObjectId).toPointer());
    final queryNota = await queryMac.find();
    int divisor = queryNota.length;
    double soma = 0;
    for (var element in queryNota) {
      double valorAtual =
          double.tryParse(element.get("nota").toString()) ?? 0.0;
      if (valorAtual < 1) {
        divisor--;
      }
      soma += valorAtual;
    }
    if (divisor < 1) {
      divisor = 1;
    }
    return double.parse((soma / divisor).toStringAsFixed(2));
  }

  Future<double> _consultarNotas(
      {required String alunoObjectId,
      required String disciplina,
      required String professorObjectId,
      required String trimestre,
      required String mes,
      required String semana,
      required String anoLetivoObjectId}) async {
    final queryMac = QueryBuilder(ParseObject("MAC"))
      ..whereEqualTo("professor",
          (ParseObject("_User")..objectId = professorObjectId).toPointer())
      ..whereEqualTo(
          "aluno", (ParseObject("_User")..objectId = alunoObjectId).toPointer())
      ..whereEqualTo("disciplina", disciplina)
      ..whereEqualTo("mes", mes)
      ..whereEqualTo("semana", semana)
      ..whereEqualTo("trimestre", trimestre)
      ..whereEqualTo("anoLetivo",
          (ParseObject("AnoLetivo")..objectId = anoLetivoObjectId).toPointer());
    final queryNota = await queryMac.first();

    return double.tryParse(queryNota?.get("nota").toString() ?? "0.0") ?? 0.0;
  }

  Future<double> _consultarNotasProvas(
      {required String alunoObjectId,
      required String nppOrNpt,
      required String disciplina,
      required String professorObjectId,
      required String trimestre,
      required String anoLetivoObjectId}) async {
    final queryNppNpt = QueryBuilder(ParseObject("Provas"))
      ..whereEqualTo("professor",
          (ParseObject("_User")..objectId = professorObjectId).toPointer())
      ..whereEqualTo(
          "aluno", (ParseObject("_User")..objectId = alunoObjectId).toPointer())
      ..whereEqualTo("disciplina", disciplina)
      ..whereEqualTo("trimestre", trimestre)
      ..whereEqualTo("anoLetivo",
          (ParseObject("AnoLetivo")..objectId = anoLetivoObjectId).toPointer());
    final resultProvas = await queryNppNpt.first();

    return double.tryParse(resultProvas?.get(nppOrNpt).toString() ?? "0.0") ??
        0.0;
  }
}

Future<void> qualquer() async {
  final List<ParseObject> listParses = [];
  for (var c = 0; c < 10; c++) {
    print(c);
    listParses.add(ParseObject("OlaMundo")..set("hello", "Hello World"));
  }
  final result = await Future.wait(listParses.map((e) => e.save()).toList());
  result.forEach((e) => print(e.result.get("objectId")));
  print("Funçao de Concorrência de Chamadas Assincronas!");
}
