import 'dart:math';

import 'package:flutter/material.dart';

class LoginClipper extends CustomClipper<Path> {
  Point p1 = Point(0.0, 54.0);
  Point c1 = Point(20.0, 25.0);
  Point c2 = Point(81.0, -8.0);
  Point p2 = Point(160.0, 20.0);
  Point c3 = Point(216.0, 38.0);
  Point c4 = Point(280.0, 73.0);
  Point p3 = Point(280.0, 44.0);
  Point c5 = Point(280.0, -11.0);
  Point c6 = Point(330.0, 8.0);

  @override
  Path getClip(Size size) {
    Point p4 = Point(size.width, .0);

    Path path = Path();
    path.moveTo(p1.x as double, p1.y as double);
    path.cubicTo(c1.x as double, c1.y as double, c2.x as double, c2.y as double,
        p2.x as double, p2.y as double);
    path.cubicTo(c3.x as double, c3.y as double, c4.x as double, c4.y as double,
        p3.x as double, p3.y as double);
    path.cubicTo(c5.x as double, c5.y as double, c6.x as double, c6.y as double,
        p4.x as double, p4.y as double);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return this.hashCode != oldClipper.hashCode;
  }
}
