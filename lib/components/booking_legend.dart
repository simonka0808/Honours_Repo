import 'package:flutter/material.dart';

class BookingLegend extends StatelessWidget {
  const BookingLegend(
      {Key? key,
      required this.legendIconColor,
      required this.legendText,
      this.legendIconSize})
      : super(key: key);

  final double? legendIconSize;
  final String legendText;
  final Color legendIconColor;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: legendIconSize ?? 16,
          width: legendIconSize ?? 16,
          decoration:
              BoxDecoration(color: legendIconColor, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(legendText,
            style: themeData.textTheme.bodyText1
                ?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
