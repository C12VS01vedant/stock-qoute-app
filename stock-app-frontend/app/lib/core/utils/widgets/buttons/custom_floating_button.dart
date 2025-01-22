import 'package:app/core/utils/widgets/Icons/custom_icon.dart';
import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  final CustomIcon icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final double? elevation;
  final String? tooltip;
  final bool mini;
  final double? size;
  final ShapeBorder? shape;
  final BorderRadius? borderRadius;
  final EdgeInsets? margin;
  final bool extended;
  final String? label;
  final TextStyle? labelStyle;
  final bool enableFeedback;

  const CustomFloatingButton({
    Key? key,
    required this.icon,
    this.onPressed,
    this.backgroundColor,
    this.elevation,
    this.tooltip,
    this.mini = false,
    this.size,
    this.shape,
    this.borderRadius,
    this.margin,
    this.extended = false,
    this.label,
    this.labelStyle,
    this.enableFeedback = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Determine the effective shape
    final effectiveShape = shape ??
        RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(16.0),
        );

    // Build the FAB content
    Widget fabContent = icon;
    if (extended && label != null) {
      fabContent = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 8),
          Text(
            label!,
            style: labelStyle ??
                theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
          ),
        ],
      );
    }

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: extended
          ? FloatingActionButton.extended(
              onPressed: onPressed,
              icon: icon,
              label: Text(
                label ?? '',
                style: labelStyle,
              ),
              backgroundColor: backgroundColor ?? theme.colorScheme.primary,
              elevation: elevation,
              tooltip: tooltip,
              shape: effectiveShape,
              enableFeedback: enableFeedback,
            )
          : FloatingActionButton(
              onPressed: onPressed,
              backgroundColor: backgroundColor ?? theme.colorScheme.primary,
              elevation: elevation,
              tooltip: tooltip,
              mini: mini,
              shape: effectiveShape,
              child: fabContent,
            ),
    );
  }
}

// Example usage with different styles
class FABStyles {
  static CustomFloatingButton primary({
    required CustomIcon icon,
    required VoidCallback onPressed,
    String? tooltip,
  }) {
    return CustomFloatingButton(
      icon: icon,
      onPressed: onPressed,
      tooltip: tooltip,
      elevation: 6.0,
      borderRadius: BorderRadius.circular(16.0),
    );
  }

  static CustomFloatingButton secondary({
    required CustomIcon icon,
    required VoidCallback onPressed,
    String? tooltip,
  }) {
    return CustomFloatingButton(
      icon: icon,
      onPressed: onPressed,
      tooltip: tooltip,
      backgroundColor: Colors.grey[800],
      elevation: 4.0,
      mini: true,
    );
  }

  static CustomFloatingButton extended({
    required CustomIcon icon,
    required VoidCallback onPressed,
    required String label,
    String? tooltip,
  }) {
    return CustomFloatingButton(
      icon: icon,
      onPressed: onPressed,
      tooltip: tooltip,
      extended: true,
      label: label,
      elevation: 6.0,
    );
  }
}
