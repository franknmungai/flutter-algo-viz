import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function() onPressed;
  final Color? color;
  final String title;

  CustomButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(title),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            color ?? Colors.purple.shade400,
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(vertical: 16, horizontal: 48),
          ),
        ),
      ),
    );
  }
}
