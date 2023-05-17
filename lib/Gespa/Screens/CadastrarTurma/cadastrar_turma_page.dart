import 'package:flutter/material.dart';
import 'package:gespa_app/Gespa/Screens/widgets/text_with_form.dart';
import 'package:gespa_app/ui/text_with_tap.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../../../utils/colors.dart';
import '../../../utils/message.dart';

class CadastrarTurmaPage extends StatefulWidget {
  @override
  State<CadastrarTurmaPage> createState() => _CadastrarTurmaPageState();
}

class _CadastrarTurmaPageState extends State<CadastrarTurmaPage> {
  final anoController = TextEditingController();
  final turmaController = TextEditingController();
  final classeController = TextEditingController();
  final turnoController = TextEditingController();

  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const TextWithTap(
          "Turma",
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        foregroundColor: primaryColorsG,
        elevation: .0,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<List<ParseObject>>(
            future: _carregarAnoLetivo(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                print(anoController.text);
                return TextWithDropParseObject(
                    title: "Ano Letivo",
                    hintText: "Escolhe o ano letivo",
                    controller: anoController,
                    getObject: "ano",
                    action: () {},
                    list: snapshot.data!);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
          ),
          TextWithForm(
              title: "Turma",
              hintText: "Escolhe a turma",
              controller: turmaController),
          TextWithDrop(
            title: "Classe",
            hintText: "Escolhe a classe",
            controller: classeController,
            list: const ["7ª", "8ª", "9ª", "10ª", "11ª", "12ª", "13ª"],
          ),
          TextWithDrop(
            title: "Turno",
            hintText: "Escolhe o turno",
            controller: turnoController,
            list: const ["Manha", "Tarde", "Noite"],
          ),
          isSaving
              ? const CircularProgressIndicator()
              : GestureDetector(
                  onTap: () async {
                    if (anoController.text.isEmpty ||
                        turmaController.text.isEmpty ||
                        classeController.text.isEmpty ||
                        turnoController.text.isEmpty) {
                      showResultCustom(
                          context, "Preencha todos os campos corretamente!");
                      return;
                    }

                    setState(() {
                      isSaving = true;
                    });
                    await _cadastrarTurma(
                        anoController.text,
                        turmaController.text,
                        classeController.text,
                        turnoController.text);

                    setState(() {
                      isSaving = false;
                      anoController.text = "";
                      turmaController.text = "";
                      classeController.text = "";
                      turnoController.text = "";
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
                      "CADASTRAR",
                      style: TextStyle(
                          color: Colors.orange.shade800,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
        ],
      ),
    );
  }

  Future<List<ParseObject>> _carregarAnoLetivo() async {
    final queryAnoLetivo = QueryBuilder(ParseObject("AnoLetivo"))
      ..orderByAscending("ano");

    return await queryAnoLetivo.find();
  }

  _cadastrarTurma(String ano, String turma, String classe, String turno) async {
    final queryTurma = QueryBuilder(ParseObject("Turma"));
    queryTurma.whereEqualTo("ano", ano);
    queryTurma.whereEqualTo("turma", turma);

    final response = await queryTurma.find();
    if (response.isNotEmpty) {
      showResultCustom(context, "Esta turma já existe", isError: true);
      return;
    }

    final parseTurma = ParseObject("Turma");
    parseTurma.set("ano", ano);
    parseTurma.set("turma", turma);
    parseTurma.set("classe", classe);
    parseTurma.set("turno", turno);
    await parseTurma.save();

    showResultCustom(context, "Turma salva com sucesso!");
  }
}
