import 'package:flutter/material.dart';
import 'package:gespa_app/Gespa/Screens/Routes/routes.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("GESPA"),
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
                  padding: const EdgeInsets.all(8.0),
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
