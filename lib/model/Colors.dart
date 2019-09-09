import 'dart:ui';

import 'package:flutter/material.dart';

Color primary = Color.fromRGBO(213, 0, 0, 1); //Color.fromRGBO(213, 0, 0, 1);
Color primaryLight =
    Color.fromRGBO(255, 81, 49, 1); //Color.fromRGBO(255, 81, 49, 1);
Color primaryDark =
    Color.fromRGBO(155, 0, 0, 1); //Color.fromRGBO(155, 0, 0, 1);
Color errorMessage =
    Color.fromRGBO(176, 0, 32, 1);
Color color1 =Colors.teal[200];
double percentageSize(BuildContext context, double percentage) {
  return MediaQuery.of(context).size.width * (percentage / 100.0);
}

