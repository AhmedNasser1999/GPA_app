import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final double? width;
  final Color? color;
  final String? buttonText;
  final Function()? onPressed;

  const Button({
    Key? key,
    this.width,
    this.color,
    this.buttonText,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 45.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        textColor: Colors.white,
        child: Text(buttonText ?? ''),
      ),
    );
  }
}
