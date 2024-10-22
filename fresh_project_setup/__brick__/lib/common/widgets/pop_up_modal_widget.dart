import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:{{package_name}}/common/functions/ext.dart';
import 'package:{{package_name}}/common/widgets/btn_elevated.dart';
import 'package:{{package_name}}/common/widgets/text_header_widget.dart';
import 'package:{{package_name}}/common/widgets/text_widget.dart';

class PopUpModalWidget extends StatelessWidget {
  final String? image;
  final String title, content, btnText;
  final int imageSize;
  final VoidCallback onPressed;
  const PopUpModalWidget({super.key, this.image, required this.title, required this.content, required this.btnText, required this.onPressed, required this.imageSize});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (image != null)...[
            Image.asset(image!,
              height: imageSize.h,
              width: imageSize.h,
            ),
            30.h.heightBox
          ],
          TextHeaderWidget(
              text: title,
              textAlign: TextAlign.center,
              useAutoSizeText: false
          ),
          SizedBox(height: 10.h),
          TextWidget(
              text: content,
              useAutoSizeText: false,
              fontSize: 12,
              textAlign: TextAlign.center
          ),
          SizedBox(height: 30.h),
          BtnElevated(
              onPressed: onPressed,
              child: TextWidget(text: btnText, useAutoSizeText: false)
          )
        ],
      ),
    );
  }
}