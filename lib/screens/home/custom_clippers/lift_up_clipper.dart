
import 'package:flutter/material.dart';

class LiftUpClipper extends CustomClipper<Path> {

  final double controlX;

  LiftUpClipper({required this.controlX});

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    var controlPint = Offset(size.width - 100 + controlX * 1.3, size.height);
    var endPoint = Offset(size.width - controlX * 30 / 300, 0);
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