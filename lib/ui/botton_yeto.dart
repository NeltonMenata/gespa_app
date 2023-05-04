import 'package:flutter/material.dart';
import 'package:gespa_app/utils/colors.dart';

import 'container_with_corner.dart';

class BottunYeto extends StatelessWidget {
  Widget text;
  Function onTap;
  Color? color;
  Color? colorborder;

  BottunYeto({
    Key? key,
    required this.text,
    required this.onTap,
    this.color,
    this.colorborder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ContainerCorner(
      borderRadius: 20.0,
      height: size.height * 0.07,
      width: size.width / 1.09,
      child: MaterialButton(
        onPressed: () => onTap(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(
            color: colorborder!,
            width: 0.6,
          ),
        ),
        color: color,
        child: text,
      ),
    );
  }
  /*   Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ContainerCorner(
                borderColor: Colors.grey,
                borderRadius: 20.0,
                height: size.height * 0.07,
                width: size.width * 0.90,
                child: MaterialButton(
                  onPressed: signUpUser,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),

                  // color: Colors.blue,
                  child: !_isLoading
                      ? const TextWithTap(
                          'Cadastrar',
                          color: Colors.black,
                        )
                      : const CircularProgressIndicator(
                          color: Colors.black,
                        ),
                ),
              ),
            ), */
}
