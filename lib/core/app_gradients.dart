import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AppGradients {
  static final linear = LinearGradient(colors: [
    Color(0xFF4FACFE),
    Color(0xFF00F2FE),
  ], stops: [
    0.0,
    0.695
  ], transform: GradientRotation(2.13959913 * pi));

  static final rodape = LinearGradient(colors: [
    Color(0xFF4FACFE),
    Color(0xFF1890FF),
  ], stops: [
    0.0,
    1.0
  ], transform: GradientRotation(2.13959913 * pi));
}
