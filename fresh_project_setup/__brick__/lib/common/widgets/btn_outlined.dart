import 'package:{{package_name}}/common/widgets/loading_animation.dart';
import 'package:{{package_name}}/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BtnOutlined extends StatelessWidget {
  final Widget child;
  final bool useFlexibleWith;
  final VoidCallback? onPressed;
  final double btnHeight, btnWidth, btnRadius;
  final Color? bgColor;
  final bool isLoading;
  const BtnOutlined({
    super.key,
    required this.child,
    this.btnRadius = AppDimens.kDefaultBtnRadius,
    this.btnHeight = AppDimens.kDefaultBtnHeight,
    this.bgColor,
    this.isLoading = false,
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
      child: OutlinedButton(
          style: ElevatedButton.styleFrom(
            //backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(btnRadius),
            ),
            side: bgColor != null ? BorderSide(width: 1.0, color: bgColor!) : null,
          ),
          onPressed: isLoading ? null : onPressed,
          child: isLoading ? LoadingAnimation(color: primaryColor) : child
      ),
    );
  }
}
