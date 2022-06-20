
import 'package:flutter/material.dart';

hexColor(String colorHexCode) {
  var hexCode = colorHexCode.toUpperCase().replaceAll('#', '');
  if (hexCode.length == 6) {
    hexCode = 'FF$hexCode';
  }
  return Color(int.parse(hexCode, radix: 16));
}