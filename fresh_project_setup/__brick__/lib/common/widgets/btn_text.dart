import 'package:{{package_name}}/common/widgets/loading_animation.dart';
import 'package:{{package_name}}/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BtnText extends StatelessWidget {
  final Widget child;
  final bool useFlexibleWith;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final double btnHeight, btnWidth, btnRadius;
  final bool isLoading, disabled;
  const BtnText({
    super.key,
    required this.child,
    this.backgroundColor,
    this.btnHeight = AppDimens.kDefaultBtnHeight,
    this.useFlexibleWith = false,
    this.disabled = false,
    this.btnRadius = AppDimens.kDefaultBtnRadius,
    this.btnWidth = double.infinity,
    this.isLoading = false,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    Color primaryColor = Theme.of(context).colorScheme.primary;
    return SizedBox(
      height: btnHeight.h,
      width: useFlexibleWith == true ? null : btnWidth.w,
      child: TextButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(btnRadius),
            ),
            backgroundColor: backgroundColor
          ),
          onPressed: disabled ? null : isLoading ? null : onPressed,
          child: isLoading ? LoadingAnimation(color: primaryColor) : child
      ),
    );
  }
}
