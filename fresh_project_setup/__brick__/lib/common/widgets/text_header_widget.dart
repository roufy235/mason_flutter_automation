import 'package:auto_size_text/auto_size_text.dart';
import 'package:{{package_name}}/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextHeaderWidget extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow textOverflow;
  final FontStyle? fontStyle;
  final TextDecoration? textDecoration;
  final int fontSize;
  final FontWeight? fontWeight;
  final bool isExtraBold, useAutoSizeText, isMediumFont;
  const TextHeaderWidget({
    super.key,
    required this.text,
    this.color,
    this.maxLines,
    this.fontStyle,
    this.fontFamily,
    this.textAlign,
    this.textDecoration,
    this.textOverflow = TextOverflow.ellipsis,
    this.fontWeight,
    this.fontSize = 18,
    this.isExtraBold = false,
    this.isMediumFont = false,
    this.useAutoSizeText = true
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    if (useAutoSizeText) {
      return AutoSizeText(
        //textScaleFactor: 0.5,
        text,
        textAlign: textAlign,
        overflow: textOverflow,
        maxLines: maxLines,
        style: TextStyle(
          fontFamily: isMediumFont ? 'GeneralSansMedium' : fontFamily ?? 'GeneralSansBold',
          color: color,
          fontSize: fontSize.sp,
          fontWeight: isMediumFont ? FontWeight.w600 : fontWeight ?? (isExtraBold ? FontWeight.w900 : FontWeight.w700),
          fontStyle: fontStyle,
          decoration: textDecoration,
        ),
      );
    }
    return Text(text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: textOverflow,
      style: TextStyle(
          fontFamily: isMediumFont ? 'GeneralSansMedium' : fontFamily ?? 'GeneralSansBold',
          fontWeight: isMediumFont ? FontWeight.w600 : fontWeight ?? (isExtraBold ? FontWeight.w900 : FontWeight.w700),
          color: color ?? AdaptiveColor.kBlack(context: context),
          fontSize: fontSize.sp
      ),
    );
  }
}