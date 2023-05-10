import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetWithState extends StatefulWidget {
  WidgetWithState(this.numbers, {Key? key}) : super(key: key);

  int numbers;
  @override
  State<WidgetWithState> createState() => _WidgetWithStateState();
}

class _WidgetWithStateState extends State<WidgetWithState> {
  @override
  Widget build(BuildContext context) {
    print("## BUILD DO BOTAO COM ESTADO ##");
    return ElevatedButton(
        onPressed: () {
          setState(() {
            widget.numbers++;
          });
        },
        child: Text(
          widget.numbers.toString(),
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ));
  }
}

class WidgetWithOut extends StatelessWidget {
  WidgetWithOut(this.numbers, {Key? key}) : super(key: key);

  int numbers;

  @override
  Widget build(BuildContext context) {
    print("## BUILD DO BOTAO SEM ESTADO ##");
    return ElevatedButton(
        onPressed: () {
          numbers++;
          print("## QUANTIDADE DE CLICK: $numbers ##");

          // ignore: unnecessary_this
          this.build(context);
        },
        child: Text(
          numbers.toString(),
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ));
  }
}
