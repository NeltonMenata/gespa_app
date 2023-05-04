import 'package:flutter/material.dart';
import 'package:gespa_app/Gespa/Screens/widgets/text_with_form.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:uuid/uuid.dart';

class LancarNotasPage extends StatefulWidget {
  const LancarNotasPage({Key? key}) : super(key: key);

  @override
  State<LancarNotasPage> createState() => _LancarNotasPageState();
}

class _LancarNotasPageState extends State<LancarNotasPage> {
  bool _selecionador = true;
  final identificadorAluno = TextEditingController();
  final List<ParseObject> listAluno = [];
  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
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
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.amber,
                        child: TextWithDropParseObject(
                          title: "Nº do Aluno",
                          controller: identificadorAluno,
                          list: listAluno,
                          getObject: "numero",
                          hintText: "Escolha o número do aluno",
                        ),
                      ),
                    ],
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
}
