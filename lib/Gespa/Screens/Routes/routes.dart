import 'package:flutter/material.dart';
import 'package:gespa_app/Gespa/Screens/AreaAlunoPage/area_aluno.dart';
import 'package:gespa_app/Gespa/Screens/AreaProfessorPage/area_professor.dart';
import 'package:gespa_app/Gespa/Screens/Auth/auth_ui/login/login.dart';
import 'package:gespa_app/Gespa/Screens/Auth/auth_ui/sign_up/sign_up.dart';
import 'package:gespa_app/Gespa/Screens/CadastrarAluno/cadastrar_aluno_page.dart';
import 'package:gespa_app/Gespa/Screens/CadastrarAnoLetivo/cadastrar_ano_letivo.dart';
import 'package:gespa_app/Gespa/Screens/CadastrarProfessor/cadastrar_professor_page.dart';
import 'package:gespa_app/Gespa/Screens/CadastrarTurma/cadastrar_turma_page.dart';
import 'package:gespa_app/Gespa/Screens/Home/home.dart';
import 'package:gespa_app/Gespa/Screens/LancarNotas/lancar_notas.dart';

class Routes {
  static const SIGNUP = "/signup";
  static const LOGIN = "/login";
  static const CADASTRAR_ALUNO = "/cadastrar_aluno";
  static const CADASTRAR_PROFESSOR = "/cadastrar_professor";
  static const AREA_ALUNO = "/area_aluno";
  static const AREA_PROFESSOR = "/area_professor";
  static const HOME = "/home";
  static const LANCAR_NOTAS = "/lancar_notas";
  static const CADASTRAR_ANO_LETIVO = "/cadastrar_ano_letivo";
  static const CADASTRAR_TURMA = "/cadastrar_turma";

  static Map<String, Widget Function(BuildContext)> routes(
      BuildContext context) {
    return {
      SIGNUP: (context) => SignUp(),
      LOGIN: (context) => Login(),
      HOME: (context) => HomeScreen(),
      CADASTRAR_ALUNO: (context) => CadastrarAlunoPage(),
      CADASTRAR_PROFESSOR: (context) => CadastrarProfessorPage(),
      AREA_ALUNO: (context) => AreaAlunoPage(),
      AREA_PROFESSOR: (context) => AreaProfessorPage(),
      LANCAR_NOTAS: (context) => LancarNotasPage(),
      CADASTRAR_ANO_LETIVO: (context) => CadastrarAnoLetivoPage(),
      CADASTRAR_TURMA: (context) => CadastrarTurmaPage()
    };
  }
}
