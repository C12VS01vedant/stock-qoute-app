import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIcon extends StatelessWidget {
  final String svgPath; // Path to the SVG asset
  final double size; // Icon size
  final EdgeInsets margin; // Icon margin
  final Color? color; // Icon color
  final BoxBorder? border; // Border around the icon
  final BorderRadius? borderRadius; // Border radius
  final EdgeInsets padding; // Padding inside the border
  final Color? backgroundColor; // Background color
  final VoidCallback? onTap;

  const CustomIcon(
      {super.key,
      required this.svgPath,
      this.size = 24.0,
      this.margin = EdgeInsets.zero,
      this.color,
      this.border,
      this.borderRadius,
      this.padding = EdgeInsets.zero,
      this.backgroundColor,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: border,
          borderRadius: borderRadius,
        ),
        child: SvgPicture.asset(
          svgPath,
          width: size,
          height: size,
          
        ),
      ),
    );
  }
}
