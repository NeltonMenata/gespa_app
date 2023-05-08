//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/Material.dart';
//import 'package:flutter_animate/flutter_animate.dart';

import '../../../../ui/container_with_corner.dart';
import '../../../../ui/text_with_tap.dart';
import '../../../../utils/colors.dart';

class Notas extends StatefulWidget {
  const Notas({Key? key}) : super(key: key);

  @override
  State<Notas> createState() => _NotasState();
}

class _NotasState extends State<Notas> {
  // int? _group = 0;
  int value = 0;
  int? group = 0;
  final Color _bgColor = Colors.white;

  trimestre1({
    required String text,
    required int value,
  }) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextWithTap(
          text,
          fontSize: size.width * 0.04,
          color: Colors.white,
          alignment: Alignment.centerLeft,
          marginTop: size.width * 0.05,
          marginLeft: size.width * 0.03,
          marginRight: size.width * 0.03,
          //textAlign: TextAlign.left,
        ),
        Radio(
          activeColor: Colors.white,
          groupValue: group,
          value: value,
          onChanged: (dynamic t) {
            setState(() {
              group = t;
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: primaryColorsG,
        elevation: .0,
        centerTitle: true,
        title: const TextWithTap(
          "GESPA",
          color: Colors.black,
        ),
      ),
      drawer: const Drawer(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
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
              TextWithTap(
                "Escolha um Trimestre",
                fontSize: size.width * 0.07,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                marginTop: size.width * 0.1,
              ), //.animate().fade(duration: 500.ms).scale(delay: 500.ms),

              ContainerCorner(
                color: Colors.deepOrangeAccent.withOpacity(.7),
                marginTop: size.width * 0.1,
                // height: size.width * 0.4,
                width: size.width,
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          trimestre1(text: "1ª Trimestre", value: 1),
                          trimestre1(text: "2ª Trimestre", value: 2),
                          trimestre1(text: "3ª Trimestre", value: 3),
                          trimestre1(text: " Media Final", value: 4),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              if (group == 1)
                ContainerCorner(
                  marginTop: size.width * 0.1,
                  width: size.width,
                  color: Colors.black.withOpacity(.7),
                  child: Table(
                    children: [
                      buildRow(["Discplina", "MAC", "NPP", "NPT", "MD"],
                          isHeader: true),
                      buildRow(["L.Portuguesa", "13", "12", "14", "15"]),
                      buildRow(["Matemática", "12", "12", "14", "15"]),
                      buildRow(["EVP", "13", "12", "14", "15"]),
                      buildRow(["História", "13", "12", "14", "15"]),
                    ],
                  ),
                ),
              if (group == 2)
                ContainerCorner(
                  marginTop: size.width * 0.1,
                  width: size.width,
                  color: Colors.black.withOpacity(.7),
                  child: Table(
                    children: [
                      buildRow(["Discplina", "MAC", "NPP", "NPT", "MD"],
                          isHeader: true),
                      buildRow(["L.Portuguesa", "13", "12", "14", "15"]),
                      buildRow(["Matemática", "12", "14", "14", "15"]),
                      buildRow(["EVP", "13", "12", "11", "14"]),
                      buildRow(["História", "13", "12", "14", "15"]),
                    ],
                  ),
                ),
              if (group == 3)
                ContainerCorner(
                  marginTop: size.width * 0.1,
                  width: size.width,
                  color: Colors.black.withOpacity(.7),
                  child: Table(
                    children: [
                      buildRow(["Discplina", "MAC", "NPP", "NPT", "MD"],
                          isHeader: true),
                      buildRow(["L.Portuguesa", "13", "12", "14", "15"]),
                      buildRow(["Matemática", "11", "15", "14", "15"]),
                      buildRow(["EVP", "13", "12", "12", "15"]),
                      buildRow(["História", "13", "10", "14", "15"]),
                    ],
                  ),
                ),

              if (group == 4)
                ContainerCorner(
                  marginTop: size.width * 0.1,
                  width: size.width,
                  color: Colors.black.withOpacity(.7),
                  child: Column(
                    children: [
                      ContainerCorner(
                        child: Table(
                          children: [
                            buildRow(["Discplina", "MD1", "MD2", "MD3", "MF"],
                                isHeader: true),
                            buildRow(["L.Portuguesa", "13", "12", "14", "15"]),
                            buildRow(["Matemática", "12", "12", "14", "15"]),
                            buildRow(["EVP", "13", "12", "14", "15"]),
                            buildRow(["História", "13", "12", "14", "15"]),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 4.4,
                      ),
                      const TextWithTap(
                        "APTO",
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow buildRow(List<String> cells, {bool isHeader = false}) => TableRow(
        children: cells.map((cell) {
          final style = TextStyle(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
            color: Colors.white,
          );
          return Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                cell,
                style: style,
              ));
        }).toList(),
      );
/* 
  void testfirebase() async {
    await FirebaseFirestore.instance.collection("1trimeste").add({
      /* 
buildRow(["Disciplina", "MD1", "MD2", "MD3", "MF"],
 isHeader: true),
 buildRow(["L.Portuguesa", "13", "12", "14", "15"]),
 buildRow(["Matemática", "12", "12", "14", "15"]),
 buildRow(["EVP", "13", "12", "14", "15"]),
 buildRow(["História", "13", "12", "14", "15"]),
      
       */
      "uid": 1,
      "Disciplina": "Disciplina",
      "L.Portuguesa": 27,
      "Matemática": 12,
      "EVP": 13,
      "História": 15,
    }).then((DocumentReference doc) {
      print("meu id é ${doc.id}");
    });
  }
 */

}
