import 'package:app/core/constant/enums/button_type.dart';
import 'package:app/core/utils/themes/colors/colorgraphy.dart';
import 'package:app/core/utils/themes/fonts/app_typography.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final ButtonType type;
  final Color? textColor;

  const CustomElevatedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    switch (type) {
      case ButtonType.primary:
        backgroundColor = AppColors().gainColor;
        break;
      case ButtonType.secondary:
        backgroundColor = AppColors().primaryColor;
        break;
      case ButtonType.tertiary:
        backgroundColor = AppColors().titleTextColor;
      case ButtonType.error:
        backgroundColor = AppColors().errorColor;
        break;
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor ?? AppColors().dividerColor,
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: AppTypography.button,
      ),
    );
  }
}
