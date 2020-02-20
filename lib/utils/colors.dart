import 'package:flutter/material.dart';
import 'dart:math';

class TodosColor {
  static const kPrimaryColorCode = 0xffca3e47;
  static const kSecondaryColorCode = 0xff34465d;
  static const kThirdColorCode = 0xff0f15a0e;

  static TodosColor sharedInstance = TodosColor._();

  List<Color> storedColors;

  TodosColor._() {
    storedColors = List.generate(100, (pos) {
      return Color.fromARGB(0xff - pos * 10, Random().nextInt(255),
          Random().nextInt(255), Random().nextInt(255));
    });
  }

  Color leadingTaskColor(int pos) {
    switch (pos) {
      case 0:
        return Colors.amber[900];
      case 1:
        return Colors.cyan[900];
      case 2:
        return Colors.blue[900];
    }

    if (pos < storedColors.length) {
      return storedColors[pos];
    }

    // default case when need more than 100 colors
    return Color.fromARGB(0xff - pos * 10, Random().nextInt(255),
        Random().nextInt(255), Random().nextInt(255));
  }
}