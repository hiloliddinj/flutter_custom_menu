import 'package:flutter/material.dart';

class BBIconButton extends StatelessWidget {
  const BBIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  final void Function()? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Colors.deepPurple,
        size: 30,
      ),
    );
  }
}
