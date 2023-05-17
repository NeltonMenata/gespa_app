import 'package:flutter/material.dart';
import 'package:gespa_app/utils/message.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class CadastrarAnoLetivoPage extends StatefulWidget {
  const CadastrarAnoLetivoPage({Key? key}) : super(key: key);

  @override
  State<CadastrarAnoLetivoPage> createState() => _CadastrarAnoLetivoPageState();
}

class _CadastrarAnoLetivoPageState extends State<CadastrarAnoLetivoPage> {
  final anoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("Cadastrar Ano Letivo")),
      body: Column(children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
              child: FutureBuilder<List<ParseObject>>(
            future: _carregarAnoLetivo(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    ...List.generate(
                        snapshot.data!.length,
                        (index) => Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      title: Text(
                                        snapshot.data![index]
                                            .get("ano")
                                            .toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                const Divider()
                              ],
                            ))
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
          )),
        )),
        Container(
          height: height * .1,
          width: width,
          padding: const EdgeInsets.only(left: 15, top: 10, bottom: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.orange.shade800),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: anoController,
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Digite o Ano Letivo"),
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (anoController.text.length != 4) {
                        showResultCustom(
                            context, "O Ano Letivo deve ter quatro caracteres");
                        return;
                      }

                      _cadastrarAnoLetivo(int.parse(anoController.text));
                    });
                  },
                  icon: const Icon(Icons.save))
            ],
          ),
        )
      ]),
    );
  }

  Future<List<ParseObject>> _carregarAnoLetivo() async {
    final queryAnoLetivo = QueryBuilder(ParseObject("AnoLetivo"))
      ..orderByAscending("ano");
    return await queryAnoLetivo.find();
  }

  _cadastrarAnoLetivo(int ano) async {
    final queryAno = QueryBuilder(ParseObject("AnoLetivo"));
    queryAno.whereEqualTo("ano", ano);
    final response = await queryAno.find();
    if (response.isNotEmpty) {
      showResultCustom(context, "Este ano letivo já existe", isError: true);
      return;
    }
    final parseAno = ParseObject("AnoLetivo");
    parseAno.set("ano", ano);
    await parseAno.save();
    // setState(() {
    showResultCustom(context, "Ano Letivo salvo com sucesso!");
    // });
  }
}
