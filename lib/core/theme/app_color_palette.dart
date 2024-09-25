import 'package:daman_task/core/common_constants/common_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColorPalette {
  final Color whiteColor;
  final Color transparentColor;
  final Color backgroundColor;
  final Color black;
  final Color liteBlue;
  final Color grey;
  final Color hintGrey;
  final Color liteGrey;
  final Color redDark;
  final List<Color> commonBtnGradientColor;

  AppColorPalette({
    required this.whiteColor,
    required this.backgroundColor,
    required this.transparentColor,
    required this.black,
    required this.liteBlue,
    required this.liteGrey,
    required this.grey,
    required this.hintGrey,
    required this.redDark,
    required this.commonBtnGradientColor,
  });
}

AppColorPalette lightColorPalette = AppColorPalette(
  transparentColor: Colors.transparent,
  backgroundColor: const Color(0xFFFFFFFF),
  whiteColor: Colors.white,
  black: const Color(0xFF575665),
  liteBlue: const Color(0xFF007FFF),
  grey: const Color(0xFF9AA1AB),
  liteGrey: const Color(0xFFEDEDED),
  hintGrey: const Color(0xFF9593A2),
  redDark: Colors.red,
  commonBtnGradientColor: [Color(0xFF00ACDB), Color(0xFF003F79)],
);

class CustomTextTheme {
  static TextStyle extraBigTitleStyle(
      {Color? color,
      FontWeight? fontWeight,
      double? textSize,
      double? height}) {
    return TextStyle(
      fontSize: textSize ?? 20.sp,
      fontWeight: fontWeight ?? FontWeight.w700,
      fontFamily: CommonConstants.raleway,
      color: color ?? lightColorPalette.black,
      height: height ?? 1.h,
    );
  }

  static TextStyle bigTitleStyle(
      {Color? color,
      FontWeight? fontWeight,
      double? textSize,
      double? height}) {
    return TextStyle(
      fontSize: textSize ?? 17.sp,
      fontWeight: fontWeight ?? FontWeight.w600,
      fontFamily: CommonConstants.raleway,
      color: color ?? lightColorPalette.black,
      height: height ?? 1.h,
    );
  }

  static TextStyle normalTextStyle(
      {Color? color,
      FontWeight? fontWeight,
      double? textSize,
      bool underscore = false,
      double? height}) {
    return TextStyle(
        fontSize: textSize ?? 13.sp,
        fontWeight: fontWeight ?? FontWeight.w400,
        fontFamily: CommonConstants.raleway,
        color: color ?? lightColorPalette.black,
        height: height ?? 1.h,
        decorationStyle: underscore ? TextDecorationStyle.solid : null,
        decoration: underscore ? TextDecoration.underline : null,
        decorationColor: underscore ? Colors.white : color);
  }

  static TextStyle bottomTabs({required Color? color, double? height}) {
    return TextStyle(
      letterSpacing: 0.56,
      fontFamily: CommonConstants.raleway,
      fontSize: 12.w,
      fontWeight: FontWeight.w500,
      height: height ?? 1,
      color: color ?? lightColorPalette.black,
    );
  }
}

BoxDecoration inputTxtDecoration({required bool focused}) {
  return BoxDecoration(
      color: lightColorPalette.whiteColor,
      border: Border.all(
        color: focused ? lightColorPalette.black : lightColorPalette.grey,
        width: 0.6.w,
      ),
      borderRadius: BorderRadius.circular(7.r),
      boxShadow: focused
          ? [
              BoxShadow(
                blurRadius: 2,
                spreadRadius: 1,
                color: lightColorPalette.liteBlue,
              )
            ]
          : null);
}

List<BoxShadow> commonHomeIconsShadowZoom() {
  return [
    BoxShadow(
        color: lightColorPalette.black.withOpacity(0.05),
        blurRadius: 3.0,
        offset: const Offset(1, 2),
        spreadRadius: 1.5.w)
  ];
}
