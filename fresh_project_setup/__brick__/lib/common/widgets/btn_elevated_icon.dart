import 'package:{{package_name}}/common/widgets/loading_animation.dart';
import 'package:{{package_name}}/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BtnElevatedIcon extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Key? btnKey;
  final bool useFlexibleWith, isMaterialIcon;
  final IconData iconData;
  final double? iconSize;
  final VoidCallback? onPressed;
  final double btnHeight, btnWidth, btnRadius;
  final bool isLoading, disabled;
  final Color? loadingColor, iconDataColor;
  const BtnElevatedIcon({
    super.key,
    required this.child,
    this.isMaterialIcon = false,
    this.btnHeight = AppDimens.kDefaultBtnHeight,
    this.useFlexibleWith = false,
    this.btnRadius = AppDimens.kDefaultBtnRadius,
    this.btnWidth = double.infinity,
    this.disabled = false,
    this.isLoading = false,
    this.backgroundColor,
    this.btnKey,
    this.loadingColor,
    required this.onPressed,
    required this.iconData,
    this.iconSize,
    this.iconDataColor
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SizedBox(
      height: btnHeight.h,
      width: useFlexibleWith == true ? null : btnWidth.w,
      child: ElevatedButton.icon(
          key: btnKey,
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(btnRadius),
              ),
              backgroundColor: backgroundColor
          ),
          onPressed: disabled ? null : isLoading ? null : onPressed,
          icon: isMaterialIcon
              ? Icon(iconData, color: iconDataColor ?? AppColors.kWhite, size: iconSize)
              : FaIcon(iconData, color: iconDataColor ?? AppColors.kWhite, size: iconSize),
          label: isLoading ? LoadingAnimation(color: loadingColor ?? Theme.of(context).colorScheme.primary) : child
      ),
    );
  }
}
