import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class FadeInUpWidget extends StatelessWidget {
  final Widget child;
  const FadeInUpWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
        delay: const Duration(milliseconds: 200),
        duration: const Duration(milliseconds: 400),
        child: child
    );
  }
}
