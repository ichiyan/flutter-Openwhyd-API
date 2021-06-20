import 'package:flutter/material.dart';
import 'package:openwhyd_api_music_app/app_colors.dart';

class NeumorphicElement extends StatelessWidget {
  final double size;
  final Widget? child;
  final double? borderWidth;
  final String? image;
  static const String defaultImage = "assets/defaultImage.jpg";

  NeumorphicElement(
      {required this.size, this.child, this.borderWidth, this.image});

  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(200)),
      border: Border.all(
        width: borderWidth ?? 2,
        color: AppColors.mainColor,
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.mainColor,
          blurRadius: 10.0,
          offset: Offset(5.0, 5.0),
          spreadRadius: 3,
        ),
        BoxShadow(
          color: AppColors.lightShadow,
          blurRadius: 10.0,
          offset: Offset(-5.0, -5.0),
          spreadRadius: 3,
        )
      ],
      gradient: RadialGradient(colors: [
        Color(0xFF303030),
        Color(0xFF303030),
        Color(0xFF303030),
        Color(0xFF1a1a1a),
        // AppColors.mainColor,
        // AppColors.mainColor,
        // AppColors.mainColor,
        // Color(0XFF383838),
      ]),
    );

    if (image != null) {
      boxDecoration = boxDecoration.copyWith(
          image: DecorationImage(
            image: NetworkImage(image ?? ''),
            fit: BoxFit.cover,
          ),
          color: Color(0XFF212121),
          boxShadow: [
            BoxShadow(
              color: Color(0XFF1c1c1c),
              offset: Offset(10.0, 10.0),
              blurRadius: 22.0,
            ),
            BoxShadow(
              color: Color(0XFF404040),
              offset: Offset(-10.0, -10.0),
              blurRadius: 22.0,
            ),
          ]);
    }

    return Container(
      width: size,
      height: size,
      decoration: boxDecoration,
      child: TextButton(
        onPressed: () {},
        child: child ?? Container(),
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(200)),
          ),
        ),
      ),
    );
  }
}
