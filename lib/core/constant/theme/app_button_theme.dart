import 'package:flutter/material.dart';
import 'package:diary_mobile/core/constant/theme/app_colors.dart';
import 'package:diary_mobile/core/extension/num_extension.dart';
import 'package:diary_mobile/core/helper/edge_insets_functions.dart';

class AppButtonTheme {
  static FilledButtonThemeData filledButtonTheme = FilledButtonThemeData(
    style: ButtonStyle(
      alignment: Alignment.center,
      maximumSize: const WidgetStatePropertyAll(Size.fromWidth(double.infinity)),
      fixedSize: const WidgetStatePropertyAll(Size.fromWidth(double.maxFinite)),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6.r)))),
      padding: WidgetStatePropertyAll(REdgeInsets.symmetric(horizontal: 16, vertical: 14)),
      backgroundColor: WidgetStatePropertyAll(AppColors.green),
    ),
  );

  static TextButtonThemeData textButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
      alignment: Alignment.center,
      maximumSize: const WidgetStatePropertyAll(Size.fromWidth(double.infinity)),
      fixedSize: const WidgetStatePropertyAll(Size.fromWidth(double.maxFinite)),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6.r)))),
      padding: WidgetStatePropertyAll(REdgeInsets.symmetric(horizontal: 16, vertical: 14)),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
  );
}
