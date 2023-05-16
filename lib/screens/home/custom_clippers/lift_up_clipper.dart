import 'package:flutter/material.dart';

class LiftUpClipper extends CustomClipper<Path> {
  LiftUpClipper({
    required this.controlX,
    this.falling = false,
  });

  final double controlX;
  final bool falling;

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    var controlPint = falling
        ///Falling
        ? Offset(size.width + 100 / (controlX + 0.1), size.height)
        ///Raising
        : Offset(size.width - 100 + controlX * 1.3, size.height);

    var endPoint = falling
        ///Falling
        ? Offset(size.width, 0)
        ///Raising
        : Offset(size.width - controlX * 30 / 300, 0);

    path.quadraticBezierTo(
        controlPint.dx, controlPint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}
