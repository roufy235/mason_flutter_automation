import 'package:{{package_name}}/common/widgets/loading_animation.dart';
import 'package:{{package_name}}/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BtnTextIcon extends StatelessWidget {
  final Widget child;
  final IconData iconData;
  final bool useFlexibleWith, isMaterialIcon;
  final VoidCallback? onPressed;
  final double btnHeight, btnWidth, btnRadius;
  final double? iconSize;
  final Color? bgColor, backgroundColor, iconDataColor;
  final bool isLoading, disabled;
  const BtnTextIcon({
    super.key,
    required this.child,
    required this.iconData,
    this.btnRadius = AppDimens.kDefaultBtnRadius,
    this.btnHeight = AppDimens.kDefaultBtnHeight,
    this.bgColor,
    this.iconDataColor,
    this.disabled = false,
    this.iconSize,
    this.backgroundColor,
    this.isLoading = false,
    this.isMaterialIcon = false,
    this.useFlexibleWith = false,
    this.btnWidth = double.infinity,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    Color primaryColor = Theme.of(context).colorScheme.primary;
    return SizedBox(
      height: btnHeight.h,
      width: useFlexibleWith == true ? null : btnWidth.w,
      child: TextButton.icon(
          style: ElevatedButton.styleFrom(
            //backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(btnRadius),
            ),
              backgroundColor: backgroundColor,
            side: bgColor != null ? BorderSide(width: 1.0, color: bgColor!) : null,
          ),
          onPressed: disabled ? null : isLoading ? null : onPressed,
          icon: isMaterialIcon
              ? Icon(iconData, color: iconDataColor ?? bgColor, size: iconSize)
              : FaIcon(iconData, color: iconDataColor ?? bgColor, size: iconSize),
          label: isLoading ? LoadingAnimation(color: primaryColor) : child
      ),
    );
  }
}
