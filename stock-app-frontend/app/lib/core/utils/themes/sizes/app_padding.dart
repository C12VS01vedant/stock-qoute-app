import 'package:app/core/utils/themes/sizes/app_sizes.dart';
import 'package:flutter/material.dart';

abstract class AppPadding {
  static const EdgeInsets heading = EdgeInsets.all(AppSizes.medium);
  static const EdgeInsets title = EdgeInsets.symmetric(
    horizontal: AppSizes.medium,
    vertical: AppSizes.small,
  );
  static const EdgeInsets body = EdgeInsets.all(AppSizes.small);
  static const EdgeInsets caption = EdgeInsets.only(
    left: AppSizes.small,
    right: AppSizes.small,
    bottom: AppSizes.small,
  );
}
