import 'package:flutter/widgets.dart';

class AppConstants {
  static const String appName = "Anı Defteri";
  static const Size designDeviceSize = Size(375, 812);

  static const int maxImageSize = 5 * 1024 * 1024;
  static const List<String> allowedImageExtensions = ['jpg', 'jpeg', 'png'];
  static const String imageStoragePath = 'images';
}
