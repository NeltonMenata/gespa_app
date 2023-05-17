import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class TextWithForm extends StatefulWidget {
  const TextWithForm(
      {Key? key,
      required this.title,
      required this.hintText,
      this.isPassword,
      this.keyBoardType,
      required this.controller})
      : super(key: key);
  final String title;
  final bool? isPassword;
  final String hintText;
  final TextInputType? keyBoardType;
  final TextEditingController controller;
  @override
  State<TextWithForm> createState() => _TextWithFormState();
}

class _TextWithFormState extends State<TextWithForm> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 15),
            width: width * .60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.white)),
            child: TextField(
              controller: widget.controller,
              obscureText: widget.isPassword ?? false,
              keyboardType: widget.keyBoardType,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: const TextStyle(color: Colors.white),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextWithBox extends StatefulWidget {
  const TextWithBox(
      {Key? key,
      required this.title,
      required this.hintText,
      this.isPassword,
      this.keyBoardType,
      required this.controller})
      : super(key: key);
  final String title;
  final bool? isPassword;
  final String hintText;
  final TextInputType? keyBoardType;
  final TextEditingController controller;
  @override
  State<TextWithBox> createState() => _TextWithBoxState();
}

class _TextWithBoxState extends State<TextWithBox> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            width: width * .60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.white)),
            child: Text(
              widget.controller.text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class TextWithDrop extends StatefulWidget {
  const TextWithDrop(
      {Key? key,
      required this.title,
      required this.hintText,
      required this.controller,
      this.action,
      required this.list})
      : super(key: key);
  final String title;
  final String hintText;
  final TextEditingController controller;
  final Function? action;
  final List<String> list;

  @override
  State<TextWithDrop> createState() => _TextWithDropState();
}

class _TextWithDropState extends State<TextWithDrop> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 15),
            width: width * .60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.white)),
            child: DropdownButton<String>(
                underline: Container(),
                isExpanded: true,
                dropdownColor: Colors.orange,
                value: selectedValue,
                hint: Text(
                  widget.hintText,
                  style: const TextStyle(color: Colors.white),
                ),
                items: widget.list
                    .map((e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(
                            e,
                            style: const TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            setState(() {});
                          },
                        ))
                    .toList(),
                onChanged: (value) => setState(() {
                      selectedValue = value;
                      widget.controller.text = value!;
                      widget.action?.call();
                    })),
          ),
        ],
      ),
    );
  }
}

class TextWithDropParseObject extends StatefulWidget {
  const TextWithDropParseObject(
      {Key? key,
      required this.title,
      required this.hintText,
      required this.getObject,
      required this.controller,
      required this.action,
      required this.list})
      : super(key: key);
  final String title;
  final String hintText;
  final TextEditingController controller;
  final List<ParseObject> list;
  final Function action;

  final String getObject;

  @override
  State<TextWithDropParseObject> createState() =>
      _TextWithDropParseObjectState();
}

class _TextWithDropParseObjectState extends State<TextWithDropParseObject> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 15),
            width: width * .60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.white)),
            child: DropdownButton<String>(
                underline: Container(),
                isExpanded: true,
                dropdownColor: Colors.orange,
                value: selectedValue,
                hint: Text(
                  widget.hintText,
                  style: const TextStyle(color: Colors.white),
                ),
                items: widget.list
                    .map((e) => DropdownMenuItem<String>(
                          value: e.objectId,
                          child: Text(
                            e.get(widget.getObject).toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            setState(() {});
                          },
                        ))
                    .toList(),
                onChanged: (value) => setState(() {
                      selectedValue = value;
                      widget.controller.text = value!;
                      widget.action();
                    })),
          ),
        ],
      ),
    );
  }
}
