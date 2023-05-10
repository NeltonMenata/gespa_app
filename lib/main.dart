import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gespa_app/Gespa/back4app_core_connection/back4app.dart';
import 'package:gespa_app/Gespa/Screens/Routes/routes.dart';
import 'package:get/get.dart';
import 'Gespa/Screens/Auth/benvindo.dart';

void main() async {
  await Back4app.initialize();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gespa Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          centerTitle: true,
        ),
        primarySwatch: Colors.blue,
      ),
      defaultTransition: Transition.native,
      builder: EasyLoading.init(),
      home: BenvindoScreen(),
      routes: Routes.routes(context),
    );
  }
}
