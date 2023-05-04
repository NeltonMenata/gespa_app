// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gespa_app/ui/container_with_corner.dart';
import 'package:gespa_app/ui/text_field_yetu.dart';
import 'package:gespa_app/utils/message.dart';
import 'package:gespa_app/Gespa/Screens/Routes/routes.dart';

import 'package:get/get.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../../../../../ui/botton_yeto.dart';
import '../../../../../../ui/text_with_tap.dart';
import '../../../../../../utils/colors.dart';
import '../../../Home/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isShowPassword = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: .9,
            fit: BoxFit.cover,
            image: AssetImage("assets/images/garotas.jpg"),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  height: 50,
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  width: double.infinity,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back)),
                ),
                TextWithTap(
                  "Desfruta do melhor sistema de Gestão de Pautas para Escolas do Ensino Geral de Angola.",
                  fontSize: size.width * 0.04,
                  marginLeft: 14,
                  marginRight: 14,
                  color: const Color.fromARGB(255, 4, 2, 2),
                  fontWeight: FontWeight.bold,
                  marginTop: size.width * 0.0,
                  alignment: Alignment.topCenter,
                  textAlign: TextAlign.justify,
                ),
                TextWithTap(
                  "Entrar no Sistema",
                  fontSize: size.width * 0.05,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  marginTop: size.width * 0.1,
                  alignment: Alignment.topCenter,
                ),
                const SizedBox(
                  height: 46.0,
                ),
                ContainerCorner(
                  marginAll: 8,
                  child: TextFieldYetu(
                    controller: email,
                    textInputAction: TextInputAction.done,
                    hintText: 'Identificador',
                    isEmail: true,
                    isPassword: false,
                    iscontact: false,
                    icon: IconButton(
                        icon: Icon(
                          Icons.email,
                          color: primaryColorsG,
                        ),
                        onPressed: () {}),
                    validator: (value) {
                      if (value!.isEmpty) {
                        Get.snackbar(
                          'Aviso',
                          'O e-mail é obrigatório.',
                        );
                        return 'Digite o e-mail';
                      }

                      return null;
                    },
                  ),
                ),
                ContainerCorner(
                  alignment: Alignment.center,
                  marginAll: 8,
                  child: TextFieldYetu(
                    controller: password,
                    textInputAction: TextInputAction.done,
                    hintText: 'Senha',
                    isEmail: false,
                    isPassword: isShowPassword,
                    iscontact: false,
                    icon: IconButton(
                        icon: Icon(
                          isShowPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: primaryColorsG,
                        ),
                        onPressed: () {
                          setState(() {
                            isShowPassword = !isShowPassword;
                          });
                        }),
                    validator: (value) {
                      if (value!.isEmpty) {
                        Get.snackbar(
                          'Aviso',
                          'Senha requerida.',
                          colorText: Colors.white,
                          backgroundColor: Colors.blue,
                        );
                        return 'Digite uma Senha valida';
                      } else if (value.length < 6) {
                        Get.snackbar(
                          'Aviso',
                          'A senha deve ter mais de 6 caracteres.',
                          colorText: Colors.white,
                          backgroundColor: Colors.blue,
                        );
                        return "A senha é muito curta";
                      }

                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 36.0,
                ),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : BottunYeto(
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          if (email.text.isEmpty || password.text.isEmpty) {
                            showResultCustom(
                                context, "Preencha os campos correctamente!");

                            setState(() {
                              isLoading = false;
                            });
                            return;
                          }
                          final parseLogin =
                              ParseUser(email.text, password.text, email.text);

                          final login = await parseLogin.login();
                          if (login.success) {
                            if (login.result.get("level") == 0) {
                              Get.offAll(
                                const HomeScreen(),
                                transition: Transition.circularReveal,
                                duration: const Duration(seconds: 4),
                              );
                              setState(() {
                                isLoading = false;
                              });
                              return;
                            } else if (login.result.get("level") == 1) {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  Routes.AREA_PROFESSOR, (route) => false);
                              setState(() {
                                isLoading = false;
                              });
                              return;
                            } else {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, Routes.AREA_ALUNO, (route) => false);
                              setState(() {
                                isLoading = false;
                              });
                              return;
                            }
                          }
                          setState(() {
                            isLoading = false;
                          });
                          showResultCustom(context, "Usuario não encontrado");
                        },
                        text: const TextWithTap(
                          "ENTRAR",
                          color: Colors.white,
                        ),
                        color: kColorsAmber900,
                        colorborder: kColorsAmber900),
                const SizedBox(
                  height: 24.0,
                ),
                const Center(child: Text("Não tem uma conta?")),
                const SizedBox(
                  height: 12.0,
                ),
                Center(
                  child: CupertinoButton(
                    onPressed: () {},
                    child: Text(
                      "Crie a sua conta aqui",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
