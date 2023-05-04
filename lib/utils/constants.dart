import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(builder: (context) {
      return SizedBox(
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: Color(0xffe16555),
            ),
            const SizedBox(
              height: 18.0,
            ),
            Container(
                margin: const EdgeInsets.only(left: 7),
                child: const Text("Carregando...")),
          ],
        ),
      );
    }),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

String getMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
      return "E-mail já utilizado. Ir para a página de login.";
    case "account-exists-with-different-credential":
      return "E-mail já utilizado. Ir para a página de login.";
    case "email-already-in-use":
      return "E-mail já utilizado. Ir para a página de login.";
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Senha incorreta ";
    case "ERROR_USER_NOT_FOUND":
      return "Nenhum usuário encontrado com este e-mail.";
    case "user-not-found":
      return "Nenhum usuário encontrado com este e-mail.";
    case "ERROR_USER_DISABLED":
      return "Usuário desabilitado.";
    case "user-disabled":
      return "Usuário desabilitado.";
    case "ERROR_TOO_MANY_REQUESTS":
      return "Muitas solicitações para fazer login nesta conta.";
    case "operation-not-allowed":
      return "Muitas solicitações para fazer login nesta conta.";
    case "ERROR_OPERATION_NOT_ALLOWED":
      return "Muitas solicitações para fazer login nesta conta.";
    case "ERROR_INVALID_EMAIL":
      return "endereço de email inválido.";
    case "invalid-email":
      return "endereço de email inválido.";
    default:
      return "Falha no login. Por favor, tente novamente.";
  }
}

bool loginVaildation(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    showMessage("Ambos os campos estão vazios");
    return false;
  } else if (email.isEmpty) {
    showMessage("O e-mail está vazio");
    return false;
  } else if (password.isEmpty) {
    showMessage("A senha está vazia");
    return false;
  } else {
    return true;
  }
}

bool signUpVaildation(
    String email, String password, String name, String phone) {
  if (email.isEmpty && password.isEmpty && name.isEmpty && phone.isEmpty) {
    showMessage("Todos os campos estão vazios");
    return false;
  } else if (name.isEmpty) {
    showMessage("O nome está vazio");
    return false;
  } else if (email.isEmpty) {
    showMessage("O e-mail está vazio");
    return false;
  } else if (phone.isEmpty) {
    showMessage("O telefone está vazio");
    return false;
  } else if (password.isEmpty) {
    showMessage("A senha está vazia");
    return false;
  } else {
    return true;
  }
}
