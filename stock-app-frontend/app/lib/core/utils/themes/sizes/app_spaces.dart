import 'package:flutter/widgets.dart';

/// Abstract class for app-wide spaces and gaps
abstract class AppSpaces {
  /// Horizontal spacing
  static const SizedBox horizontalSmall = SizedBox(width: 8);
  static const SizedBox horizontalMedium = SizedBox(width: 16);
  static const SizedBox horizontalLarge = SizedBox(width: 24);

  /// Vertical spacing
  static const SizedBox verticalSmall = SizedBox(height: 8);
  static const SizedBox verticalMedium = SizedBox(height: 16);
  static const SizedBox verticalLarge = SizedBox(height: 24);

  /// Custom spacing
  static SizedBox customHorizontal(double width) => SizedBox(width: width);
  static SizedBox customVertical(double height) => SizedBox(height: height);
}
