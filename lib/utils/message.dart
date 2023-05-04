import 'package:flutter/material.dart';

Future<void> showResultCustom(BuildContext context, String valueResult,
    {bool isError = false}) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: isError ? Colors.red : Colors.white,
        content: Text(
          valueResult,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isError ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              "Ok",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isError ? Colors.white : Colors.black,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}
