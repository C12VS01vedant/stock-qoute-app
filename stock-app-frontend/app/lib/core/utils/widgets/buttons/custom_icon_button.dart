import 'package:app/core/constant/enums/button_type.dart';
import 'package:app/core/utils/themes/colors/colorgraphy.dart';
import 'package:app/core/utils/themes/sizes/app_image_sizes.dart';
import 'package:app/core/utils/widgets/Icons/custom_icon.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String icon;
  final VoidCallback? onPressed;
  final ButtonType type;
  final Color? iconColor;

  const CustomIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.type = ButtonType.primary,
    this.iconColor,
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

    return IconButton(
      icon: CustomIcon(
        svgPath: icon,
        size: AppImageSizes.small,
        color: iconColor ?? AppColors().dividerColor,
      ),
      onPressed: onPressed,
      color: backgroundColor,
    );
  }
}
