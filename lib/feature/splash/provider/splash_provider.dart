import 'package:diary_mobile/core/constant/app_page_routes.dart';
import 'package:diary_mobile/core/utils/route_manager.dart';
import 'package:diary_mobile/feature/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SplashProvider with ChangeNotifier {
  final HomeProvider _homeProvider = GetIt.I<HomeProvider>();

  Future<void> initializeApp() async {
    try {
      // Uygulama başlatıldığında yapılacak işlemler
      await _homeProvider.loadMemories();
      // Diğer başlangıç işlemleri buraya eklenebilir
    } catch (e) {
      // Hata yönetimi
    } finally {
      RouteManager().navigateToReplacement(AppPageRoutes.home);
    }
  }
}
