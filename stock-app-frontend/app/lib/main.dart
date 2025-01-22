import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import './core/dependency_injection/service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  services();
  runApp(const MyApp());
}

void services() async {
  // depenedency injection
  di.init();
  // offline service
  await Hive.initFlutter();
}
