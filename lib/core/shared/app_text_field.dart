import 'package:flutter/material.dart';
import 'package:diary_mobile/core/constant/theme/app_text_styles.dart';
import 'package:diary_mobile/core/functions/remove_focus.dart';

class AppTextField extends TextField {
  AppTextField.none({super.key, super.controller, super.inputFormatters, String? hintText})
    : super(
        textAlign: TextAlign.center,
        onTapOutside: (event) => removeFocus(),
        style: AppTextStyles.px32w500,
        decoration: InputDecoration(hintText: hintText, focusedBorder: InputBorder.none, enabledBorder: InputBorder.none),
      );
  AppTextField.border({
    super.key,
    super.onTap,
    super.keyboardType,
    super.focusNode,
    super.controller,
    super.inputFormatters,
    super.onChanged,
    super.textInputAction,
  }) : super(textAlign: TextAlign.center, onTapOutside: (event) => removeFocus());
}
