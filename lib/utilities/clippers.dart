import 'package:flutter/material.dart';

import 'package:saipaapp/utilities/typedefs.dart';

class MyClipper extends CustomClipper<Path> {
  final PathCallBack getClipFunction;

  const MyClipper(this.getClipFunction);

  @override
  Path getClip(Size size) => getClipFunction(size);

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    print(
        "*************This Method got called by returning false!**********************");
    return true;
  }
}

class ClipMethods {
  static Path loginTopLeftClip(Size size) {
    Path path = Path();

    path.moveTo(25, 0);
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height / 3);
    path.close();

    return path;
  }
}
