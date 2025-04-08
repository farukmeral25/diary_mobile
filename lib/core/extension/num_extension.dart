import 'package:diary_mobile/core/utils/screen_size.dart';

extension NumExtension on num? {
  double get h => ScreenSize().getHeight(getValueOrDefault);

  double get w => ScreenSize().getWidth(getValueOrDefault);

  double get sp => ScreenSize().getFontSize(getValueOrDefault);

  double get r => ScreenSize().getRadius(getValueOrDefault);

  num get getValueOrDefault => this ?? 0;

  bool get isZero => getValueOrDefault == 0;
}
