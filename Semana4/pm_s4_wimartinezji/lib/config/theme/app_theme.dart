import 'package:flutter/material.dart';

const Color _customColor = Color.fromARGB(255, 23, 86, 92);

const List<Color> _colorThemes = [
  _customColor,
  Colors.amber,
  Colors.purple,
  Colors.green,
  Colors.brown,
  Colors.pink,
  Colors.indigo
];
class AppTheme {
  final int selectedColor;

  AppTheme({
    required this.selectedColor
    }):assert(selectedColor >= 0 && selectedColor <= _colorThemes.length, 
    "Los colores deben estar entre 0 y ${_colorThemes.length}" );

  ThemeData theme(){
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _colorThemes[selectedColor],
      brightness: Brightness.dark
    );

  }
}