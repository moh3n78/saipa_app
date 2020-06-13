import 'package:flutter/material.dart';

import 'package:saipaapp/utilities/clippers.dart';
import 'package:saipaapp/utilities/typedefs.dart';

class LoginContainer extends StatelessWidget with ClipMethods {
  final String text;
  final Color containerColor;
  final Color textColor;
  final VoidCallback onTap;
  final PathCallBack clipMethod;

  const LoginContainer(
    this.text,
    this.containerColor,
    this.textColor,
    this.onTap,
    this.clipMethod,
  );

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: InkWell(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 13.0),
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: const BorderRadius.only(
              topRight: const Radius.circular(15.0),
              bottomRight: const Radius.circular(15.0),
              bottomLeft: const Radius.circular(20.0),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.w100,
            ),
          ),
        ),
        onTap: onTap,
      ),
      clipper: MyClipper(clipMethod),
    );
  }
}
