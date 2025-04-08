import 'package:diary_mobile/feature/home/view/page/add_memory_page.dart';
import 'package:diary_mobile/feature/home/view/page/home_page.dart';
import 'package:diary_mobile/feature/splash/view/page/splash_page.dart';
import 'package:flutter/material.dart';

enum AppPageRoutes {
  splash(page: SplashPage()),
  home(page: HomePage()),
  addMemory(page: AddMemoryPage());

  final Widget page;

  const AppPageRoutes({required this.page});

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final AppPageRoutes route = AppPageRoutes.values.singleWhere((element) => element.value == settings.name);

    return route.navigate(settings, route.isModal);
  }
}

extension AppPageRoutesExtension on AppPageRoutes {
  String get value {
    switch (this) {
      case AppPageRoutes.splash:
        return '/';
      default:
        return name;
    }
  }

  bool get isModal {
    switch (this) {
      default:
        return false;
    }
  }

  Route<dynamic> navigate(RouteSettings settings, bool isModalBottomSheet) {
    switch (this) {
      default:
        return isModalBottomSheet
            ? ModalBottomSheetRoute(builder: (_) => page, settings: settings, isScrollControlled: true, useSafeArea: true)
            : MaterialPageRoute(builder: (_) => page, settings: settings);
    }
  }
}
