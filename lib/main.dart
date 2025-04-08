import 'package:diary_mobile/app.dart';
import 'package:diary_mobile/core/constant/app_environment.dart';
import 'package:diary_mobile/feature/home/provider/add_memory_provider.dart';
import 'package:diary_mobile/feature/home/provider/home_provider.dart';
import 'package:diary_mobile/feature/splash/provider/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:diary_mobile/core/init/injection_container.dart' as locator;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([dotenv.load(fileName: AppEnvironment().fileName), locator.init()]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator.sl<SplashProvider>()),
        ChangeNotifierProvider(create: (_) => locator.sl<HomeProvider>()),
        ChangeNotifierProvider(create: (_) => locator.sl<AddMemoryProvider>()),
      ],
      child: const DiaryApp(),
    ),
  );
}
