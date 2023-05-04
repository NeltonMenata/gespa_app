import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gespa_app/Gespa/Screens/Routes/routes.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../../../ui/container_with_corner.dart';
import '../../../../ui/text_with_tap.dart';
import '../../../../utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String image = '';

  @override
  initState() {
    super.initState();

    try {
      // image = dataController!.myDocument!.get('image');
    } catch (e) {
      image = '';
    }
  }

  bool shouldPop = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.black.withOpacity(.9),
              content: const Icon(
                Icons.autorenew_rounded,
                color: Colors.white,
              ),
              title: const TextWithTap(
                'Tens a Certeza que queres sair da Aplicação?',
                color: Colors.white,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Sim'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Não'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
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
        //drawer: ProfessorDrawer(),
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
                  "ÁREA DE ADMINISTRADOR",
                  fontSize: size.width * 0.07,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  marginTop: size.width * 0.1,
                ), //.animate().fade(duration: 500.ms).scale(delay: 500.ms),
                ContainerCorner(
                  marginTop: size.width * 0.1,
                  marginBottom: size.width * 0.8,
                  //  height: size.width * 0.7,
                  width: size.width,
                  color: Colors.black.withOpacity(.7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          textAdmin(
                            text: "Aluno",
                            icon: CupertinoIcons.person,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.CADASTRAR_ALUNO);
                              // Get.to(
                              //   ConsultarNotas(),
                              //   transition: Transition.circularReveal,
                              //   duration: const Duration(seconds: 4),
                              // );
                            },
                          ),
                          textAdmin(
                            text: "Professor",
                            icon: CupertinoIcons.person_2,
                            onTap: () async {
                              Navigator.pushNamed(
                                  context, Routes.CADASTRAR_PROFESSOR);
                            },
                          ),
                          textAdmin(
                            text: "Disciplina",
                            icon: CupertinoIcons.book,
                            onTap: () {},
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          textAdmin(
                            text: "Turma",
                            icon: CupertinoIcons.home,
                            onTap: () {
                              print("turma");
                              Navigator.of(context)
                                  .pushNamed(Routes.CADASTRAR_TURMA);
                            },
                          ),
                          textAdmin(
                            text: "Ano Letivo",
                            icon: CupertinoIcons.calendar,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.CADASTRAR_ANO_LETIVO);
                              print("tuRno");
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomSheet: SizedBox(
          width: double.infinity,
          child: TextButton(
              onPressed: () async {
                final user = await ParseUser.currentUser() as ParseUser?;
                await user?.logout();
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.LOGIN, (route) => false);
              },
              child: const Text("Terminar Sessão")),
        ),
      ),
    );
  }

  ListTile list({
    required String nome,
    required Function onTap,
  }) {
    var size = MediaQuery.of(context).size;
    return ListTile(
      onTap: () {
        onTap();
        // Get.to(ProfileScreen());
      },
      title: Container(
        height: size.width * 0.08,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextWithTap(
          nome,
          fontSize: size.width * 0.05,
          marginLeft: size.width * 0.02,
          marginTop: size.width * 0.02,
          textAlign: TextAlign.center,
          color: Colors.white,
        ),
      ),
    );
  }

  textAdmin({
    required String text,
    required IconData icon,
    required Function onTap,
  }) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: size.width * 0.2,
          ),
          TextWithTap(
            text,
            color: Colors.white,
            fontSize: size.width * 0.05,
          ),
        ],
      ),
    );
  }
}
