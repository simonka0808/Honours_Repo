import 'package:flutter/material.dart';

class BookingButton extends StatelessWidget {
  BookingButton({
    Key? key,
    required this.buttonText,
    required this.isClicked,
    this.isActive = true,
    this.isDisabled = false,
    this.buttonStyle,
    this.width,
    this.buttonActiveColor,
    this.buttonInActiveColor,
  }) : super(key: key);

  final String buttonText;
  final VoidCallback isClicked;
  final bool? isActive;
  final bool? isDisabled;
  final TextStyle? buttonStyle;
  final Color? buttonActiveColor;
  final Color? buttonInActiveColor;
  final double? width;

  final Color inactiveColor = Colors.lightBlue.shade100;
  final Color activeColor = Colors.lightBlue;

  Color identifyTextColor() {
    if (isActive == true && isDisabled == false) {
      return Colors.white;
    } else if (isActive == false && isDisabled == false) {
      return buttonActiveColor ?? activeColor;
    } else {
      return Colors.white;
    }
  }

  Color identifyButtonColor() {
    if (isActive == true && isDisabled == false) {
      return buttonActiveColor ?? activeColor;
    } else if (isActive == false && isDisabled == false) {
      return Colors.white;
    } else {
      return buttonInActiveColor ?? inactiveColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;

    return InkWell(
      onTap: (isDisabled == null || isDisabled == false) ? isClicked : null,
      child: Container(
        width: width ?? double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: identifyButtonColor(),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Text(
          buttonText,
          style: buttonStyle ??
              themeData.button!.copyWith(color: identifyTextColor()),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
