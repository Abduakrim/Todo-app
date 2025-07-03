import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyButton extends HookConsumerWidget {
  final Widget child;
  final void Function()? onPressed;
  final Color? buttonColor;
  final Color? backButtonColor;
  final double? width;
  final double? height;
  final double depth;
  final EdgeInsets padding;
  final double borderRadius;
  final Duration? duration;
  final bool isScaleButton;
  const MyButton({
    super.key,
    this.borderRadius = 15.0,
    this.width,
    this.height,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    this.depth = 5,
    required this.child,
    required this.onPressed,
    this.buttonColor,
    this.backButtonColor,
    this.duration,
    this.isScaleButton = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isPressed = useState(false);
    if (isScaleButton) {
      return GestureDetector(
        onTap: onPressed,
        onTapDown: (_) {
          isPressed.value = true;
        },
        onTapUp: (_) {
          isPressed.value = false;
        },
        onTapCancel: () {
          isPressed.value = false;
        },
        child: AnimatedScale(
          duration: duration ?? Duration(milliseconds: 100),
          scale: isPressed.value ? 0.9 : 1,
          child: AnimatedContainer(
            duration: duration ?? Duration(milliseconds: 100),
            width: width,
            height: height,
            padding: padding,
            decoration: BoxDecoration(
              color: buttonColor ?? Colors.white,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: child,
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: onPressed,
        onTapDown: (_) {
          isPressed.value = true;
        },
        onTapUp: (_) {
          isPressed.value = false;
        },
        onTapCancel: () {
          isPressed.value = false;
        },
        child: AnimatedSlide(
          duration: duration ?? Duration(milliseconds: 100),
          offset: Offset(0, isPressed.value ? depth / 60 : 0),
          child: AnimatedContainer(
            duration: duration ?? Duration(milliseconds: 100),
            width: width,
            height: height,
            padding: padding,
            decoration: BoxDecoration(
              color: buttonColor ?? Colors.white,
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, isPressed.value ? 0 : depth),
                  color: backButtonColor ?? Colors.grey,
                ),
              ],
            ),
            child: child,
          ),
        ),
      );
    }
  }
}
