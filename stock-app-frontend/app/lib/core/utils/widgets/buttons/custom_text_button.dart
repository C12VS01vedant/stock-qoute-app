import 'package:app/core/constant/enums/button_type.dart';
import 'package:app/core/utils/themes/colors/colorgraphy.dart';
import 'package:flutter/material.dart';


class CustomTextButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final ButtonType type;
  final Color? textColor;

  const CustomTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (type) {
      case ButtonType.primary:
        color = AppColors().gainColor;
        break;
      case ButtonType.secondary:
        color = AppColors().primaryColor;
        break;
      case ButtonType.tertiary:
        color = AppColors().titleTextColor;
        break;
      case ButtonType.error:
        color = AppColors().errorColor;
        break;
    }

    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: color,
      ),
      onPressed: onPressed,
      child: Text(label, style: TextStyle(color: textColor ?? color)),
    );
  }
}
