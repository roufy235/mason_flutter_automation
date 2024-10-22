import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final bool useAutoSizeText;
  final TextOverflow? textOverflow;
  final FontStyle? fontStyle;
  final TextDecoration? textDecoration;
  final int? maxLines;
  final TextAlign? textAlign;
  final int fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  const TextWidget({
    super.key,
    required this.text,
    this.textAlign,
    this.fontFamily,
    this.textDecoration,
    this.useAutoSizeText = true,
    this.fontSize = 12,
    this.color,
    this.maxLines,
    this.fontStyle,
    this.textOverflow,
    this.fontWeight
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    if (useAutoSizeText) {
      return AutoSizeText(
        //textScaleFactor: 0.5,
        text,
        textAlign: textAlign,
        overflow: textOverflow ?? TextOverflow.ellipsis,
        maxLines: maxLines,
        style: TextStyle(
          fontFamily: fontFamily ?? 'GeneralSansRegular',
          color: color,
          fontSize: fontSize.sp,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          decoration: textDecoration,
        ),
      );
    }
    return Text(
      text,
      textAlign: textAlign,
      overflow: textOverflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
      style: TextStyle(
          fontFamily: 'GeneralSansRegular',
          color: color,
          fontSize: fontSize.sp,
          fontWeight: fontWeight,
          fontStyle: fontStyle
      ),
    );
  }
}