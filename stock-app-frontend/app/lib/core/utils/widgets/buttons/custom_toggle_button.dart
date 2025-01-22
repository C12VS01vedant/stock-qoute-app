import 'package:app/core/constant/enums/button_type.dart';
import 'package:app/core/utils/themes/colors/colorgraphy.dart';
import 'package:flutter/material.dart';


class CustomToggleButton extends StatelessWidget {
  final List<bool> isSelected;
  final List<Widget> children;
  final Function(int) onPressed;
  final ButtonType type;
  final Color? borderColor;

  const CustomToggleButton({
    super.key,
    required this.isSelected,
    required this.children,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.borderColor,
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

    return ToggleButtons(
      isSelected: isSelected,
      onPressed: onPressed,
      color: backgroundColor,
      selectedColor: Colors.white,
      fillColor: backgroundColor,
      borderColor: borderColor ?? Colors.transparent,
      children: children,
    );
  }
}
