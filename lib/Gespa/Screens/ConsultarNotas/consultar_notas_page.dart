import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gespa_app/Gespa/Screens/Auth/auth_ui/login/login_controller.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../../ui/container_with_corner.dart';
import '../../../ui/text_with_tap.dart';
import '../notas/notas.dart';

class ConsultarNotasPage extends StatefulWidget {
  const ConsultarNotasPage({Key? key}) : super(key: key);

  @override
  State<ConsultarNotasPage> createState() => _ConsultarNotasPageState();
}

class _ConsultarNotasPageState extends State<ConsultarNotasPage> {
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
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                            columns: colunas2
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
}

Future<double> _calcularMDFinal() async {
  return 0;
}

Future<double> _calcularMD({
  required String alunoObjectId,
  required String disciplina,
  required String trimestre,
}) async {
  final mac = await _consultarMacTrimestre(
    alunoObjectId: alunoObjectId,
    disciplina: disciplina,
    trimestre: trimestre,
  );
  final npp = await _consultarNotasProvas(
    alunoObjectId: alunoObjectId,
    nppOrNpt: "npp",
    disciplina: disciplina,
    trimestre: trimestre,
  );

  final npt = await _consultarNotasProvas(
    alunoObjectId: alunoObjectId,
    nppOrNpt: "npt",
    disciplina: disciplina,
    trimestre: trimestre,
  );
  return double.parse(((mac + npp + npt) / 3).toStringAsFixed(2));
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
    // ###################
    ..whereEqualTo("column", "value")
    ..whereEqualTo("trimestre", trimestre);

  final queryNota = await queryMac.find();
  print(queryNota);
  int divisor = queryNota.length;
  double soma = 0;
  for (var element in queryNota) {
    double valorAtual = double.tryParse(element.get("nota").toString()) ?? 0.0;
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
    // ###################
    ..whereEqualTo("column", "value")
    ..whereEqualTo("trimestre", trimestre);
  final resultProvas = await queryNppNpt.first();

  return double.tryParse(resultProvas?.get(nppOrNpt).toString() ?? "0.0") ??
      0.0;
}
