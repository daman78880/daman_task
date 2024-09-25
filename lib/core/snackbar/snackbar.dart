import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../text/app_text_widget.dart';
import '../theme/app_color_palette.dart';

snackbar(String message) {
  if(Get.isSnackbarOpen){
   Get.back();
  }

  return Get.snackbar(
    "",
    message,
    titleText: Container(),
    messageText: AppTextWidget(
      style: CustomTextTheme.normalTextStyle(color: lightColorPalette.whiteColor),
      text: message,
    ),
    backgroundColor: lightColorPalette.liteBlue,
    borderRadius: 10,
    margin: const EdgeInsets.all(10),
    duration: const Duration(seconds: 4),
    isDismissible: true,
    dismissDirection: DismissDirection.endToStart,
    forwardAnimationCurve: Curves.linearToEaseOut,
  );
}

