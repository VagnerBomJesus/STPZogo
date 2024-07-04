import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AppGradientse {
  static const linear =   LinearGradient(colors: [
    Color(0xFF57B6E5),
    Color.fromRGBO(73, 6, 227, 0.6941176470588235),
  ], stops: [
    0.0,
    0.695
  ], transform: GradientRotation(2.13959913 * pi));
}



class AppGradients {
  static const linear = LinearGradient(
    colors: [
      Color(0xFF8257E5),
      Color(0xFFB085F5), // Tom mais claro
      Color(0xFF4B3F91), // Tom mais escuro
    ],
    stops: [
      0.0,
      0.5,  // Ponto médio
      0.995
    ],transform: GradientRotation(2.13959913 * pi)
  );
}
