import 'package:flutter/material.dart';

extension WidgetExt on Widget {

  Expanded expanded({int flex = 1}) => Expanded(
    flex: flex,
    child: this,
  );

  Opacity setOpacity({required double val}) => Opacity(
    opacity: val,
    child: this,
  );

  Padding withPadding({required EdgeInsets padding}) => Padding(
    padding: padding,
    child: this,
  );

  SizedBox box({double? width, double? height}) => SizedBox(
      width: width,
      height: height,
      child: this
  );

  Center center() => Center(
    child: this,
  );

  Widget onClick({required Function() onClick, bool addRipple = false}) {
    if (addRipple) {
      return InkWell(
        onTap: onClick,
        child: this,
      );
    }

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onClick,
      child: this,
    );
  }

  RotatedBox rotate({required int quarterTurns}) => RotatedBox(
    quarterTurns: quarterTurns,
    child: this,
  );
}