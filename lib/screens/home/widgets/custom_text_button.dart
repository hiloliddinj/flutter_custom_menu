import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    this.onPressed,
    required this.title,
    required this.opacity,
  }) : super(key: key);

  final void Function()? onPressed;
  final String title;
  final double opacity;

  @override
  Widget build(BuildContext context) {

    double internalOpacity = opacity;

    if (opacity < 0) {
      internalOpacity = 0;
    } else if (opacity > 1) {
      internalOpacity = 1;
    }

    return TextButton(
        onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white.withOpacity(internalOpacity),
          fontSize: 25,
        ),
      ),
    );
  }
}
