import 'package:flutter/material.dart';

class CommonCard extends StatelessWidget {
  const CommonCard({
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
        margin: margin,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius:
              borderRadius ?? const BorderRadius.all(Radius.circular(10)),
        ),
        child: timeSlot);
  }
}
