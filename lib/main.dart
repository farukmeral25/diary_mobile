import 'package:diary_mobile/app.dart';
import 'package:diary_mobile/core/constant/app_environment.dart';
import 'package:flutter/material.dart';
import 'package:diary_mobile/core/init/injection_container.dart' as locator;
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([dotenv.load(fileName: AppEnvironment().fileName), locator.init()]);
  runApp(const DiaryApp());
}
