import 'package:app/core/constant/app_strings.dart';
import 'package:app/core/constant/enums/custom_typography_styles.dart';
import 'package:app/core/constant/icons/app_icons_path.dart';
import 'package:app/core/utils/themes/colors/colorgraphy.dart';
import 'package:app/core/utils/themes/sizes/app_sizes.dart';
import 'package:app/core/utils/widgets/Icons/custom_icon.dart';
import 'package:app/core/utils/widgets/Texts/custom_text.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onFavoritePressed;
  final VoidCallback? onRefreshPressed;
  final VoidCallback? onLogoutPressed;
  final Icon? leadingIcon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final TextStyle? titleTextStyle;
  final bool automaticallyImplyLeading;
  final double? toolbarHeight;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Widget? titleWidget;
  final bool? centerTitle;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final double? titleSpacing;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final ShapeBorder? shape;
  final bool enableFavorite;
  final bool enableRefresh;
  final bool enableLogout;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.onFavoritePressed,
    this.onRefreshPressed,
    this.onLogoutPressed,
    this.leadingIcon,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.titleTextStyle,
    this.automaticallyImplyLeading = true,
    this.toolbarHeight,
    this.borderRadius,
    this.boxShadow,
    this.titleWidget,
    this.centerTitle,
    this.iconTheme,
    this.actionsIconTheme,
    this.titleSpacing,
    this.flexibleSpace,
    this.bottom,
    this.shape,
    this.enableFavorite = false,
    this.enableRefresh = true,
    this.enableLogout = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: boxShadow,
      ),
      child: AppBar(
        // Basic properties
        title: titleWidget ??
            CustomText(
              text: AppStrings.appName,
              textColor: AppColors().backgroundColor,
              typographyStyle: CustomTypographyStyle.subheading,
            ),
        centerTitle: centerTitle,
        backgroundColor: backgroundColor ?? theme.primaryColor,
        foregroundColor: foregroundColor,
        elevation: elevation,
        automaticallyImplyLeading: automaticallyImplyLeading,
        toolbarHeight: toolbarHeight,

        // Advanced properties
        flexibleSpace: flexibleSpace,
        bottom: bottom,
        shape: shape,
        titleSpacing: titleSpacing,
        iconTheme: iconTheme,
        actionsIconTheme: actionsIconTheme,

        // Leading widget
        leading: leadingIcon != null
            ? IconButton(
                icon: leadingIcon!,
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
              )
            : null,

        // Action buttons
        actions: [
          if (enableFavorite)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomIcon(
                svgPath: AppIcons.dataIcon,
                onTap: onFavoritePressed,
                color: AppColors().backgroundColor,
                size: AppSizes.large * 1.5,
              ),
            ),
          if (enableRefresh)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomIcon(
                svgPath: AppIcons.refreshIcon,
                color: AppColors().backgroundColor,
                onTap: onRefreshPressed,
              ),
            ),
          const SizedBox(
            height: AppSizes.medium * 1.5,
          ),
          if (enableLogout)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomIcon(
                svgPath: AppIcons.logout,
                color: AppColors().backgroundColor,
                onTap: onLogoutPressed,
                size: AppSizes.large * 1.2,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);
}
