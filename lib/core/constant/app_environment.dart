import 'package:flutter/foundation.dart';

class AppEnvironment {
  AppEnvironment._();
  factory AppEnvironment() {
    return _instance;
  }

  static final AppEnvironment _instance = AppEnvironment._();

  String get fileName => kDebugMode ? ".env.dev" : ".env.prod";
  String get domain => kDebugMode ? "test.domain" : "prod.domain";
}
