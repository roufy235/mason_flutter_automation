import 'package:flutter/material.dart';
import 'package:{{package_name}}/config/config.dart';

class AdaptiveColor {

  static Color kBlack({required BuildContext context, bool retainColor = false}) {
    if (retainColor) return AppColors.kPureBlack;
    if (Theme.of(context).brightness == Brightness.light) {
      return AppColors.kPureBlack;
    }
    return AppColors.kWhite;
  }

  static Color kInputColor({required BuildContext context, bool retainColor = false}) {
    if (retainColor) return AppColors.kPureBlack;
    if (Theme.of(context).brightness == Brightness.light) {
      return AppColors.kPureBlack;
    }
    return AppColors.kWhite;
  }

  static Color kInputTextColor({required BuildContext context, bool retainColor = false}) {
    if (retainColor) return AppColors.kPureBlack;
    if (Theme.of(context).brightness == Brightness.light) {
      return AppColors.kPureBlack;
    }
    return AppColors.kWhite;
  }

}
