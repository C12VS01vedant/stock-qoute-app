import 'package:flutter/material.dart';

abstract class ColorGraphy {
  Color get primaryColor;
  Color get secondaryColor;
  Color get gainColor;
  Color get lossColor;
  Color get backgroundColor;
  Color get cardBackgroundColor;
  Color get titleTextColor;
  Color get subtitleTextColor;
  Color get hintTextColor;
  Color get borderColor;
  Color get dividerColor;
  Color get errorColor;
  Color get buttonColor;
  Color get buttonDisabledColor;
  Color get watchlistBackgroundColor;
  Color get watchlistItemTextColor;
  Color get chartPositiveColor;
  Color get chartNegativeColor;
  Color get accentColor;
  Color get transparentColor;
}

class AppColors implements ColorGraphy {
  @override
  Color get primaryColor => const Color.fromARGB(255, 8, 105, 232);

  @override
  Color get secondaryColor => const Color(0xFF0D47A1);

  @override
  Color get gainColor => const Color(0xFF4CAF50);

  @override
  Color get lossColor => const Color(0xFFEF5350);

  @override
  Color get backgroundColor => const Color(0xFFF5F5F5);

  @override
  Color get cardBackgroundColor => const Color(0xFFFFFFFF);

  @override
  Color get titleTextColor => const Color(0xFF212121);

  @override
  Color get subtitleTextColor => const Color(0xFF757575);
  @override
  Color get hintTextColor => const Color(0xFFBDBDBD);

  @override
  Color get borderColor => const Color(0xFFBDBDBD);

  @override
  Color get dividerColor => const Color(0xFFEEEEEE);

  @override
  Color get errorColor => const Color(0xFFB00020);

  @override
  Color get buttonColor => const Color(0xFF1A73E8);

  @override
  Color get buttonDisabledColor => const Color(0xFFBDBDBD);

  @override
  Color get watchlistBackgroundColor => const Color(0xFFF1F8E9);

  @override
  Color get watchlistItemTextColor => const Color(0xFF388E3C);

  @override
  Color get chartPositiveColor => const Color(0xFF4CAF50);

  @override
  Color get chartNegativeColor => const Color(0xFFEF5350);

  @override
  Color get accentColor => const Color(0xFFFFC107);

  @override
  Color get transparentColor => Colors.transparent;
}

// usage:
//  AppColors().titleTextColor,
