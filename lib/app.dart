import 'package:diary_mobile/core/constant/app_constants.dart';
import 'package:diary_mobile/core/constant/app_page_routes.dart';
import 'package:diary_mobile/core/constant/theme/app_theme.dart';
import 'package:diary_mobile/core/keys/app_keys.dart';
import 'package:diary_mobile/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class DiaryApp extends StatelessWidget {
  const DiaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init();
    return MaterialApp(
      theme: AppTheme.lightTheme,
      title: AppConstants.appName,
      navigatorKey: AppKeys.navigatorKey,
      scaffoldMessengerKey: AppKeys.scaffoldMessengerKey,
      onGenerateRoute: AppPageRoutes.onGenerateRoute,
      initialRoute: AppPageRoutes.splash.value,
    );
  }
}
