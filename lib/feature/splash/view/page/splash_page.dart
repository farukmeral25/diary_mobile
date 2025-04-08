import 'package:diary_mobile/core/constant/app_constants.dart';
import 'package:diary_mobile/core/constant/app_page_routes.dart';
import 'package:diary_mobile/core/constant/theme/app_colors.dart';
import 'package:diary_mobile/core/shared/app_scaffold.dart';
import 'package:diary_mobile/core/utils/route_manager.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      RouteManager().navigateToReplacement(AppPageRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: AppColors.foregroundPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.book, size: 100, color: AppColors.white),
            const SizedBox(height: 24),
            Text(
              AppConstants.appName,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
