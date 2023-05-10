//import 'package:animated_text_kit/animated_text_kit.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gespa_app/Gespa/Screens/LancarNotas/testes_dart.dart';
//import 'package:flutter_animate/flutter_animate.dart';

import '../../../../ui/botton_yeto.dart';
import '../../../../utils/colors.dart';
import '/ui/container_with_corner.dart';
import '/ui/text_with_tap.dart';
import 'package:get/get.dart';
import 'auth_ui/login/login.dart';

class BenvindoScreen extends StatefulWidget {
  BenvindoScreen({super.key});
  int numbers = 0;
  @override
  State<BenvindoScreen> createState() => _BenvindoScreenState();
}

class _BenvindoScreenState extends State<BenvindoScreen> {
  @override
  Widget build(BuildContext context) {
    print("## BUILD PRINCIPAL ##");
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 1.6,
            fit: BoxFit.cover,
            image: AssetImage("assets/images/mapa.jpeg"),
          ),
        ),
        child: Column(
          children: [
            TextWithTap(
              "GESPA",
              fontSize: size.width * 0.2,
              color: primaryColorsG,
              fontWeight: FontWeight.bold,
              marginTop: size.width * 0.8,
              alignment: Alignment.center,
            ),
            ContainerCorner(
              //height:size.height * 0.9 ,
              marginTop: size.width * 0.3,
              alignment: Alignment.center,
              child: SizedBox(
                width: size.width * 0.8,
                child: BottunYeto(
                  onTap: () async {
                    Get.to(
                      const Login(),
                      transition: Transition.circularReveal,
                      duration: const Duration(seconds: 1),
                    );
                  },
                  text: const TextWithTap(
                    "Começar",
                    color: Colors.white,
                  ),
                  color: blackG,
                  colorborder: blackG,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
