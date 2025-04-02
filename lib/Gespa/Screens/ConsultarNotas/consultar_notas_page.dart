import 'package:flutter/material.dart';
import 'package:gespa_app/Gespa/Screens/Auth/auth_ui/login/login_controller.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class ConsultarNotasPage extends StatefulWidget {
  const ConsultarNotasPage({Key? key}) : super(key: key);

  @override
  State<ConsultarNotasPage> createState() => _ConsultarNotasPageState();
}

class _ConsultarNotasPageState extends State<ConsultarNotasPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      Get.snackbar("Notas", "Aguarde o carregamento das Notas!",
          backgroundColor: Colors.orange.shade200);
    });

    super.initState();
  }

  int _selectFour = 0;
  @override
  Widget build(BuildContext context) {
    final userLogado = LoginController.userLogado!;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("GESPA"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 1.6,
            fit: BoxFit.cover,
            image: AssetImage("assets/images/garotas.jpg"),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width,
                height: size.height * .15,
                padding: const EdgeInsets.only(right: 8),
                color: Colors.orange.shade800.withOpacity(.7),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "1º Trim",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Radio<int>(
                          value: 0,
                          groupValue: _selectFour,
                          onChanged: (value) {
                            setState(() {
                              _selectFour = value!;
                            });
                          })
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "2º Trim",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Radio<int>(
                          value: 1,
                          groupValue: _selectFour,
                          onChanged: (value) {
                            setState(() {
                              _selectFour = value!;
                            });
                          })
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "3º Trim",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Radio<int>(
                          value: 2,
                          groupValue: _selectFour,
                          onChanged: (value) {
                            setState(() {
                              _selectFour = value!;
                            });
                          })
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Media Final",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Radio<int>(
                          value: 3,
                          groupValue: _selectFour,
                          onChanged: (value) {
                            setState(() {
                              _selectFour = value!;
                            });
                          })
                    ],
                  ),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.black54,
                child: _selectFour != 3
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                            columns: colunas
                                .map((e) => DataColumn(
                                        label: Text(
                                      e,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )))
                                .toList(),
                            rows: listaDisciplina
                                .map((e) => DataRow(cells: [
                                      DataCell(
                                        Text(
                                          e,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                      DataCell(
                                        FutureBuilder<double>(
                                            future: _consultarMacTrimestre(
                                                alunoObjectId:
                                                    userLogado.objectId!,
                                                disciplina: e,
                                                trimestre: _selectFour == 0
                                                    ? "1º"
                                                    : _selectFour == 1
                                                        ? "2º"
                                                        : "3º"),
                                            initialData: 0,
                                            builder: (context, snapshot) {
                                              return Text(
                                                snapshot.data.toString(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              );
                                            }),
                                      ),
                                      DataCell(
                                        FutureBuilder<double>(
                                            future: _consultarNotasProvas(
                                                alunoObjectId:
                                                    userLogado.objectId!,
                                                nppOrNpt: "npp",
                                                disciplina: e,
                                                trimestre: _selectFour == 0
                                                    ? "1º"
                                                    : _selectFour == 1
                                                        ? "2º"
                                                        : "3º"),
                                            initialData: 0,
                                            builder: (context, snapshot) {
                                              return Text(
                                                  snapshot.data.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white));
                                            }),
                                      ),
                                      DataCell(
                                        FutureBuilder<double>(
                                            future: _consultarNotasProvas(
                                                alunoObjectId:
                                                    userLogado.objectId!,
                                                nppOrNpt: "npt",
                                                disciplina: e,
                                                trimestre: _selectFour == 0
                                                    ? "1º"
                                                    : _selectFour == 1
                                                        ? "2º"
                                                        : "3º"),
                                            initialData: 0,
                                            builder: (context, snapshot) {
                                              return Text(
                                                  snapshot.data.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white));
                                            }),
                                      ),
                                      DataCell(
                                        FutureBuilder<double>(
                                            future: _calcularMD(
                                                alunoObjectId:
                                                    userLogado.objectId!,
                                                disciplina: e,
                                                trimestre: _selectFour == 0
                                                    ? "1º"
                                                    : _selectFour == 1
                                                        ? "2º"
                                                        : "3º"),
                                            initialData: 0,
                                            builder: (context, snapshot) {
                                              return Text(
                                                  snapshot.data.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white));
                                            }),
                                      ),
                                    ]))
                                .toList()),
                      )
                    : Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                                columns: colunas2
                                    .map((e) => DataColumn(
                                            label: Text(
                                          e,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )))
                                    .toList(),
                                rows: listaDisciplina
                                    .map((e) => DataRow(cells: [
                                          DataCell(
                                            Text(
                                              e,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          DataCell(
                                            FutureBuilder<double>(
                                                future: _calcularMD(
                                                    alunoObjectId:
                                                        userLogado.objectId!,
                                                    disciplina: e,
                                                    trimestre: "1º"),
                                                initialData: 0,
                                                builder: (context, snapshot) {
                                                  return Text(
                                                    snapshot.data.toString(),
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  );
                                                }),
                                          ),
                                          DataCell(
                                            FutureBuilder<double>(
                                                future: _calcularMD(
                                                    alunoObjectId:
                                                        userLogado.objectId!,
                                                    disciplina: e,
                                                    trimestre: "2º"),
                                                initialData: 0,
                                                builder: (context, snapshot) {
                                                  return Text(
                                                      snapshot.data.toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white));
                                                }),
                                          ),
                                          DataCell(
                                            FutureBuilder<double>(
                                                future: _calcularMD(
                                                    alunoObjectId:
                                                        userLogado.objectId!,
                                                    disciplina: e,
                                                    trimestre: "3º"),
                                                initialData: 0,
                                                builder: (context, snapshot) {
                                                  return Text(
                                                      snapshot.data.toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white));
                                                }),
                                          ),
                                          DataCell(
                                            FutureBuilder<double>(
                                                future: _calcularMDFinal(
                                                  alunoObjectId:
                                                      userLogado.objectId!,
                                                  disciplina: e,
                                                ),
                                                initialData: 0,
                                                builder: (context, snapshot) {
                                                  return Text(
                                                      snapshot.data.toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white));
                                                }),
                                          ),
                                        ]))
                                    .toList()),
                          ),
                          FutureBuilder<double>(
                            future: _consultarResultadoFinal(
                                alunoObjectId: userLogado.objectId!,
                                disciplinas: listaDisciplina),
                            //initialData: 0,
                            builder: (context, snapshot) => Container(
                              width: size.width,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                children: [
                                  const Divider(
                                    thickness: 5,
                                    color: Colors.white,
                                  ),
                                  snapshot.hasError
                                      ? const Text(
                                          "Erro ao Carregar nota!",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : snapshot.hasData
                                          ? snapshot.data! < 8
                                              ? Text(
                                                  "NÃO APTO: ${snapshot.data}",
                                                  style: const TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              : snapshot.data! > 8 &&
                                                      snapshot.data! < 10
                                                  ? Text(
                                                      "RECUPERAÇÃO: ${snapshot.data}",
                                                      style: const TextStyle(
                                                          fontSize: 25,
                                                          color: Colors.orange,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  : Text(
                                                      "APTO: ${snapshot.data}",
                                                      style: const TextStyle(
                                                          fontSize: 25,
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                          : const Text(
                                              "CARREGANDO...",
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )
                                ],
                              ),
                            ),
                          ),

                          /*
                          
                          snapshot.hasData
                                          ? snapshot.data!["negativas"] > 3
                                              ? Text(
                                                  "NÃO APTO: ${snapshot.data["media"]}",
                                                  style: const TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              : snapshot.data!["negativas"] > 1 && snapshot.data!["negativas"] <= 3
                                                      snapshot.data! < 10
                                                  ? Text(
                                                      "RECUPERAÇÃO: ${snapshot.data["media"]}",
                                                      style: const TextStyle(
                                                          fontSize: 25,
                                                          color: Colors.orange,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  : Text(
                                                      "APTO: ${snapshot.data["media"]}",
                                                      style: const TextStyle(
                                                          fontSize: 25,
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                          
                          */
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final listaDisciplina = const [
    "L. Portuguesa",
    "Matematica",
    "Historia",
    "Geografia",
    "Fisica",
    "Quimica",
    "EVP",
    "EMC"
  ];

  final colunas = const ["Disciplina", "MAC", "NPP", "NPT", "MD"];

  final colunas2 = const ["Disciplina", "MD1", "MD2", "MD3", "MF"];

  Future<double> _calcularMDFinal(
      {required String alunoObjectId, required String disciplina}) async {
    double sum = 0.0;
    final mds = await Future.wait<double>([
      _calcularMD(
          alunoObjectId: alunoObjectId,
          disciplina: disciplina,
          trimestre: "1º"),
      _calcularMD(
          alunoObjectId: alunoObjectId,
          disciplina: disciplina,
          trimestre: "2º"),
      _calcularMD(
          alunoObjectId: alunoObjectId,
          disciplina: disciplina,
          trimestre: "3º"),
    ]);
    print(mds);
    for (double nota in mds) {
      sum += nota;
    }

    return double.parse((sum / mds.length).toStringAsFixed(2));
  }

  Future<double> _calcularMD({
    required String alunoObjectId,
    required String disciplina,
    required String trimestre,
  }) async {
    var sum = 0.0;
    final mac = await Future.wait([
      _consultarMacTrimestre(
        alunoObjectId: alunoObjectId,
        disciplina: disciplina,
        trimestre: trimestre,
      ),
      _consultarNotasProvas(
        alunoObjectId: alunoObjectId,
        nppOrNpt: "npp",
        disciplina: disciplina,
        trimestre: trimestre,
      ),
      _consultarNotasProvas(
        alunoObjectId: alunoObjectId,
        nppOrNpt: "npt",
        disciplina: disciplina,
        trimestre: trimestre,
      )
    ]);
    for (var nota in mac) {
      sum += nota;
    }
    return double.parse((sum / 3).toStringAsFixed(2));
  }

  Future<double> _consultarMacTrimestre({
    required String alunoObjectId,
    required String disciplina,
    required String trimestre,
  }) async {
    final queryMac = QueryBuilder(ParseObject("MAC"))
      ..whereEqualTo(
          "aluno", (ParseObject("_User")..objectId = alunoObjectId).toPointer())
      ..whereEqualTo("disciplina", disciplina)
      ..whereEqualTo("trimestre", trimestre);

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
    return double.parse((soma / divisor).toStringAsFixed(2)) * 4;
  }

  Future<double> _consultarNotasProvas({
    required String alunoObjectId,
    required String nppOrNpt,
    required String disciplina,
    required String trimestre,
  }) async {
    final queryNppNpt = QueryBuilder(ParseObject("Provas"))
      ..whereEqualTo(
          "aluno", (ParseObject("_User")..objectId = alunoObjectId).toPointer())
      ..whereEqualTo("disciplina", disciplina)
      ..whereEqualTo("trimestre", trimestre);
    final resultProvas = await queryNppNpt.first();

    return double.tryParse(resultProvas?.get(nppOrNpt).toString() ?? "0.0") ??
        0.0;
  }

  Future<double> _consultarResultadoFinal(
      {required String alunoObjectId,
      required List<String> disciplinas}) async {
    final cRF = await Future.wait([
      _calcularMDFinal(
          alunoObjectId: alunoObjectId, disciplina: disciplinas[0]),
      _calcularMDFinal(
          alunoObjectId: alunoObjectId, disciplina: disciplinas[1]),
      _calcularMDFinal(
          alunoObjectId: alunoObjectId, disciplina: disciplinas[2]),
      _calcularMDFinal(
          alunoObjectId: alunoObjectId, disciplina: disciplinas[3]),
      _calcularMDFinal(
          alunoObjectId: alunoObjectId, disciplina: disciplinas[4]),
      _calcularMDFinal(
          alunoObjectId: alunoObjectId, disciplina: disciplinas[5]),
      _calcularMDFinal(
          alunoObjectId: alunoObjectId, disciplina: disciplinas[6]),
      _calcularMDFinal(
          alunoObjectId: alunoObjectId, disciplina: disciplinas[7]),
    ]);
    var sum = 0.0;
    int divisor = cRF.length;
    for (var nota in cRF) {
      sum += nota;
      if (nota < 1) {
        divisor--;
      }
    }
    return double.parse((sum / divisor).toStringAsFixed(2));
  }
}
