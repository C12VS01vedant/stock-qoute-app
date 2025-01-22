import 'package:app/core/constant/enums/custom_typography_styles.dart';
import 'package:flutter/material.dart';


class CustomText extends StatelessWidget {
  final String text; // Text content
  final CustomTypographyStyle typographyStyle; // Typography style
  final TextAlign? textAlign; // Text alignment
  final Color? textColor; // Custom text color (overrides default)
  final double? customFontSize; // Custom font size (overrides default)
  final FontWeight? fontWeight; // Custom font weight (overrides default)
  final EdgeInsets margin; // Margin around the text
  final EdgeInsets padding; // Padding around the text
   final TextOverflow overflow;  // Add this line

  const CustomText({
    super.key,
    required this.text,
    this.typographyStyle = CustomTypographyStyle.body,
    this.textAlign = TextAlign.start,
    this.textColor,
    this.customFontSize,
    this.fontWeight,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
     this.overflow = TextOverflow.clip,  // Add this line with default value
  });

  // A method to dynamically get text style based on typography style
  TextStyle _getTextStyle(BuildContext context) {
    switch (typographyStyle) {
      case CustomTypographyStyle.heading:
        return TextStyle(
          fontSize: customFontSize ?? 24.0,
          fontWeight: fontWeight ?? FontWeight.bold,
          color: textColor ?? Theme.of(context).primaryColor,
        );
      case CustomTypographyStyle.subheading:
        return TextStyle(
          fontSize: customFontSize ?? 20.0,
          fontWeight: fontWeight ?? FontWeight.w600,
          color: textColor ?? Theme.of(context).primaryColorDark,
        );
      case CustomTypographyStyle.body:
        return TextStyle(
          fontSize: customFontSize ?? 16.0,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: textColor ?? Theme.of(context).textTheme.bodyLarge?.color,
        );
      case CustomTypographyStyle.caption:
        return TextStyle(
          fontSize: customFontSize ?? 12.0,
          fontWeight: fontWeight ?? FontWeight.w400,
          color: textColor ?? Theme.of(context).textTheme.bodySmall?.color,
        );
      case CustomTypographyStyle.error:
        return TextStyle(
          fontSize: customFontSize ?? 16.0,
          fontWeight: fontWeight ?? FontWeight.bold,
          color: textColor ?? Colors.red,
        );
      }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      child: Text(
        text,
        textAlign: textAlign,
        style: _getTextStyle(context),
        overflow: overflow,  // Add this line
        softWrap: true,     // Add this line
      ),
    );
  }
}