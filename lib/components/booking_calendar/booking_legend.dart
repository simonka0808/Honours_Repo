import 'package:flutter/material.dart';

class BookingLegend extends StatelessWidget {
  const BookingLegend(
      {Key? key,
      required this.legendIconColor,
      required this.legendText,
      this.legendIcon})
      : super(key: key);

  final double? legendIcon;
  final String legendText;
  final Color legendIconColor;

  @override
  Widget build(BuildContext context) {
    double legendIconSize = 17;
    final themeData = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: legendIcon ?? legendIconSize,
          height: legendIcon ?? legendIconSize,
          decoration:
              BoxDecoration(color: legendIconColor, shape: BoxShape.rectangle),
        ),
        const SizedBox(width: 4),
        Text(legendText,
            style: themeData.textTheme.bodyText1
                ?.copyWith(fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
      ],
    );
  }
}
