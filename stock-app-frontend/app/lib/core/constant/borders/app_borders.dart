import 'package:flutter/material.dart';

abstract class AppBorders {
  static const BorderRadius small = BorderRadius.all(Radius.circular(4));
  static const BorderRadius medium = BorderRadius.all(Radius.circular(8));
  static const BorderRadius large = BorderRadius.all(Radius.circular(16));
}

abstract class AppBorderStyles {
  static const Border small = Border.fromBorderSide(
    BorderSide(color: Colors.grey, width: 1),
  );
  static const Border medium = Border.fromBorderSide(
    BorderSide(color: Colors.grey, width: 2),
  );
  static const Border large = Border.fromBorderSide(
    BorderSide(color: Colors.grey, width: 3),
  );
}

abstract class AppShadows {
  static const List<BoxShadow> small = [
    BoxShadow(
      color: Colors.black26,
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];
  static const List<BoxShadow> medium = [
    BoxShadow(
      color: Colors.black38,
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];
  static const List<BoxShadow> large = [
    BoxShadow(
      color: Colors.black45,
      blurRadius: 12,
      offset: Offset(0, 6),
    ),
  ];
}