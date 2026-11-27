import 'dart:ui';
import 'package:flutter/material.dart';

class LiquidGlassContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final BorderRadius borderRadius;

  const LiquidGlassContainer({
    Key? key,
    required this.child,
    this.blur = 15.0,
    this.opacity = 0.1,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            borderRadius: borderRadius,
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(opacity + 0.05),
                Colors.white.withOpacity(opacity - 0.05),
              ],
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
