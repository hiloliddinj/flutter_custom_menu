import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    this.onPressed,
    required this.title,
  }) : super(key: key);

  final void Function()? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }
}
