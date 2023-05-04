import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../ui/container_with_corner.dart';
import '../../../../ui/text_with_tap.dart';
import '../../../../utils/colors.dart';
import 'notas.dart';

class ConsultarNotas extends StatefulWidget {
  @override
  _ConsultarNotasState createState() => _ConsultarNotasState();
}

class _ConsultarNotasState extends State<ConsultarNotas> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: primaryColorsG,
        elevation: .0,
        centerTitle: true,
        title: TextWithTap(
          "GESPA",
          color: Colors.black,
        ),
      ),
      drawer: Drawer(),
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
            children: [
              TextWithTap(
                "ÁREA DO ALUNO",
                fontSize: size.width * 0.07,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                marginTop: size.width * 0.1,
              ),
              ContainerCorner(
                color: Colors.deepOrangeAccent.withOpacity(.7),
                marginTop: size.width * 0.1,
                width: size.width,
                child: Column(
                  children: [
                    ContainerCorner(
                      onTap: () {
                        Get.to(
                          Notas(),
                          transition: Transition.circularReveal,
                          duration: Duration(seconds: 4),
                          

                        );
                      },
                      marginTop: 14,
                      child: Icon(
                        CupertinoIcons.news,
                        color: Colors.white,
                        size: size.width * 0.2,
                      ),
                    ),
                    TextWithTap(
                      "Consultar Notas",
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      marginBottom: 14,
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
}
