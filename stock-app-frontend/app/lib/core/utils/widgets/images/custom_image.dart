import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String imagePath; // Path to the image asset or network URL
  final double width; // Image width
  final double height; // Image height
  final EdgeInsets margin; // Image margin
  final BoxBorder? border; // Border around the image
  final BorderRadius? borderRadius; // Border radius
  final EdgeInsets padding; // Padding inside the border
  final Color? backgroundColor; // Background color
  final BoxFit fit; // Image fit type
  final bool isNetworkImage; // Whether the image is from the network

  const CustomImage({
    super.key,
    required this.imagePath,
    this.width = 100.0,
    this.height = 100.0,
    this.margin = EdgeInsets.zero,
    this.border,
    this.borderRadius,
    this.padding = EdgeInsets.zero,
    this.backgroundColor,
    this.fit = BoxFit.cover,
    this.isNetworkImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: border,
        borderRadius: borderRadius,
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: isNetworkImage
            ? Image.network(
                imagePath,
                width: width,
                height: height,
                fit: fit,
              )
            : Image.asset(
                imagePath,
                width: width,
                height: height,
                fit: fit,
              ),
      ),
    );
  }
}