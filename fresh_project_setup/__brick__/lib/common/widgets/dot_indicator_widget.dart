import 'package:flutter/material.dart';

class DotIndicatorWidget extends StatelessWidget {
  final bool isActive;
  final Color color;
  final Color? notActiveColor;
  const DotIndicatorWidget({super.key, required this.color, this.notActiveColor, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 30 : 15,
      decoration: BoxDecoration(
        color: isActive ? color : notActiveColor ?? Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}
