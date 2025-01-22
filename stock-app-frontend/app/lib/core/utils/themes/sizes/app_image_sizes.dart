import 'package:flutter/material.dart';

abstract class AppImageSizes {
  static const double small = 40.0;
  static const double medium = 80.0;
  static const double large = 120.0;

  static const double aspectRatio = 16 / 9;

  static Size custom(double width, double height) => Size(width, height);

  static double avatarSizeSmall = 50.0;
  static double avatarSizeMedium = 75.0;
  static double avatarSizeLarge = 100.0;
}
