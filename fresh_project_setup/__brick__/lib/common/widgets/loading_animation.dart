import 'package:{{package_name}}/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingAnimation extends StatelessWidget {
  final Color color;
  final double height;
  const LoadingAnimation({super.key, this.color = AppColors.kWhite, this.height = 15});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Center(
      child: LoadingAnimationWidget.horizontalRotatingDots(
        color: color,
        size: height.h,
      ),
    );
  }
}
