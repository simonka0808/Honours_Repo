import 'package:flutter/material.dart';

class BookingSlot extends StatelessWidget {
  const BookingSlot({
    Key? key,
    required this.timeSlot,
    this.padding,
    this.margin,
    this.color,
    this.borderRadius,
  }) : super(key: key);

  final Widget timeSlot;
  final BorderRadius? borderRadius;
  final Color? color;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        margin: margin,
        decoration: BoxDecoration(
          color: color ?? Colors.white70,
          borderRadius:
              borderRadius ?? const BorderRadius.all(Radius.circular(3)),
        ),
        child: timeSlot);
  }
}
