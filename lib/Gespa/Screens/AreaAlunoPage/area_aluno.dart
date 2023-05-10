import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gespa_app/Gespa/Screens/Routes/routes.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../../ui/container_with_corner.dart';
import '../../../ui/text_with_tap.dart';
import '../Auth/auth_ui/login/login_controller.dart';
import '../notas/notas.dart';

class AreaAlunoPage extends StatefulWidget {
  const AreaAlunoPage({Key? key}) : super(key: key);

  @override
  State<AreaAlunoPage> createState() => _AreaAlunoPageState();
}

class _AreaAlunoPageState extends State<AreaAlunoPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final userLogado = LoginController.userLogado;
    return Scaffold(
      appBar: AppBar(
        title: const Text("GESPA"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              opacity: .9,
              fit: BoxFit.cover,
              image: AssetImage("assets/images/garotas.jpg"),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "AREA DO ALUNO",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Container(
                  width: width,
                  height: height * .4,
                  padding: const EdgeInsets.only(right: 8),
                  color: Colors.orange.shade800.withOpacity(.7),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextWithTap(
                          userLogado!.get("name"),
                          fontSize: width * 0.07,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          marginTop: width * 0.1,
                        ),
                        ContainerCorner(
                          //color: Colors.deepOrangeAccent.withOpacity(.7),
                          marginTop: width * 0.1,
                          width: width,
                          child: Column(
                            children: [
                              ContainerCorner(
                                onTap: () {
                                  // Get.to(
                                  //   const Notas(),
                                  //   transition: Transition.circularReveal,
                                  //   duration: const Duration(seconds: 4),
                                  // );
                                  Navigator.pushNamed(
                                      context, Routes.CONSULTAR_NOTAS);
                                },
                                marginTop: 14,
                                child: Icon(
                                  CupertinoIcons.news,
                                  color: Colors.white,
                                  size: width * 0.2,
                                ),
                              ),
                              TextWithTap(
                                "Consultar Notas",
                                fontSize: width * 0.05,
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
                )
              ],
            ),
          ),
        ),
      ),
      bottomSheet: SizedBox(
        width: double.infinity,
        child: TextButton(
          child: const Text("Terminar Sessão"),
          onPressed: () async {
            final current = await ParseUser.currentUser() as ParseUser?;
            await current?.logout();
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.LOGIN, (route) => false);
          },
        ),
      ),
    );
  }
}
