import 'package:diary_mobile/core/constant/app_constants.dart';
import 'package:diary_mobile/core/constant/theme/app_colors.dart';
import 'package:diary_mobile/core/init/injection_container.dart' as locator;
import 'package:diary_mobile/core/utils/screen_size.dart';
import 'package:diary_mobile/feature/splash/provider/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => locator.sl<SplashProvider>(),
      child: Consumer<SplashProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            backgroundColor: AppColors.primary,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.book,
                    size: ScreenSize().getWidth(100),
                    color: AppColors.white,
                  ),
                  SizedBox(height: ScreenSize().getHeight(24)),
                  Text(
                    AppConstants.appName,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
