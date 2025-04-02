import 'package:flutter/material.dart';
import 'package:gespa_app/utils/colors.dart';

import 'container_with_corner.dart';

class TextFieldYetu extends StatelessWidget {
  final String hintText;
  bool isPassword;
  bool isEmail;
  Color? color;
  bool iscontact;
  Widget icon;
  TextInputAction? textInputAction;
  TextEditingController controller;
  String? Function(String?)? validator;

  TextFieldYetu({
    Key? key,
    required this.hintText,
    required this.isPassword,
    required this.isEmail,
    required this.icon,
    required this.iscontact,
    this.color,
    required this.controller,
    required this.textInputAction,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.0),

      borderSide: BorderSide.none,

      //borderSide: BorderSide.
      //borderSide: Divider.createBorderSide(context),
    );
    return ContainerCorner(
      borderRadius: 20.0,
      height: size.height * 0.07,
      width: size.width / 1.09,
      //width: size.width / 1.09,
      borderColor: primaryColorsG,
      alignment: Alignment.center,
      /*   padding: EdgeInsets.only(
        right: size.width / 30,
        left: size.width / 30,
      ), */
      child: TextFormField(
        validator: validator!,
        controller: controller,
        textInputAction: textInputAction,
        style: TextStyle(color: color ?? Colors.black),
        obscureText: isPassword,
        keyboardType: isEmail
            ? TextInputType.emailAddress
            : iscontact
                ? TextInputType.phone
                : TextInputType.text,
        decoration: InputDecoration(
          suffixIcon: icon,
          border: const OutlineInputBorder(
            //borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide.none,
          ),
          disabledBorder: InputBorder.none,
          //border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          //          Color? fillColor,
          // Color? focusColor,
          // Color? hoverColor,
          // fillColor: primaryColorsG,
          focusColor: Colors.black,
          //  filled: true,
          contentPadding: const EdgeInsets.all(8),
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: primaryColorsG,
          ),
        ),
      ),
    );
  }
}
