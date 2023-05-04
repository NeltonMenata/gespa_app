import 'package:flutter/material.dart';
import 'package:gespa_app/Gespa/Screens/notas/notas.dart';
import 'package:gespa_app/Gespa/Screens/Routes/routes.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class AreaProfessorPage extends StatefulWidget {
  const AreaProfessorPage({Key? key}) : super(key: key);

  @override
  State<AreaProfessorPage> createState() => _AreaProfessorPageState();
}

class _AreaProfessorPageState extends State<AreaProfessorPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("GESPA"),
      ),
      body: Container(
        //padding: const EdgeInsets.all(8),
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "AREA DO PROFESSOR",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Container(
                  width: width,
                  height: height * .4,
                  padding: const EdgeInsets.only(right: 8),
                  color: Colors.orange.shade800.withOpacity(.7),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: (() {
                            Navigator.pushNamed(context, Routes.LANCAR_NOTAS);
                          }),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.note_add_outlined,
                                size: 60,
                              ),
                              Text(
                                "Notas",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (() {}),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.calendar_month_outlined,
                                size: 60,
                              ),
                              Text(
                                "Horários",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (() {}),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.alarm,
                                size: 60,
                              ),
                              Text(
                                "Atividades",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
      bottomSheet: SizedBox(
        width: double.infinity,
        child: TextButton(
          child: Text("Terminar Sessão"),
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
