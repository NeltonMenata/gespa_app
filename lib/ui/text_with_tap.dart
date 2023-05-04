import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

class TextWithTap extends StatelessWidget {
  final Function? onTap;
  final String text;
  final double? fontSize;
  final Color? color;
  final TextAlign? textAlign;
  final Alignment? alignment;
  final double? marginTop;
  final bool? textItalic;
  final double? marginLeft;
  final double? marginRight;
  final double? marginBottom;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final int? maxLines;

  const TextWithTap(
    this.text, {
    Key? key,
    this.textAlign,
    this.alignment,
    this.marginTop = 0,
    this.marginLeft = 0,
    this.marginRight = 0,
    this.marginBottom = 0,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.decoration,
    this.onTap,
    this.overflow,
    this.maxLines,
    this.textItalic = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      margin: EdgeInsets.only(
          left: marginLeft!,
          top: marginTop!,
          bottom: marginBottom!,
          right: marginRight!),
      child: GestureDetector(
        onTap: onTap as void Function()?,
        child: Text(
          text,
          maxLines: maxLines,
          textAlign: textAlign,
          overflow: overflow,
          style: TextStyle(
            fontSize: fontSize,
            fontStyle: textItalic! ? FontStyle.italic : FontStyle.normal,
            color: color,
            fontWeight: fontWeight,
            decoration: decoration,
          ),
        ),
      ),
    );
  }
}
