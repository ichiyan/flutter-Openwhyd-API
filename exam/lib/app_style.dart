import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'app_colors.dart';

const List<BoxShadow> kBtnShadow = [
  BoxShadow(
    color: AppColors.kBtnShadowColor,
    offset: Offset(0, 8),
    blurRadius: 20,
  )
];

const TextStyle kTitleTextStyle = TextStyle(
  fontSize: kTitleTextSize,
  color: AppColors.kTextColor,
  fontWeight: kMediumFontWeight,
);

const TextStyle kBodyTextStyle = TextStyle(
  fontSize: kBodyTextSize,
  color: AppColors.kTextColor,
  fontWeight: kLightFontWeight,
);

const TextStyle kBtnTextStyle = TextStyle(
  color: AppColors.kBtnColorStart,
  fontSize: kBtnTextSize,
  fontWeight: kMediumFontWeight,
);

InputBorder kInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(kInputBorderRadius),
  borderSide: BorderSide(
    width: 2,
    color: AppColors.kInputBorderColor,
  ),
);

const double kTitleTextSize = 24;
const double kBodyTextSize = 14;
const double kBtnTextSize = 18;
const double kBtnRadius = 24;
const double kInputBorderRadius = 5;
const double kIconSize = 24;
const double kIconBoxSize = 56;
const FontWeight kLightFontWeight = FontWeight.w300;
const FontWeight kMediumFontWeight = FontWeight.w500;
