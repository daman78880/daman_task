import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../theme/app_color_palette.dart';

class CommonLoader extends StatelessWidget {
  bool isLoading;

  CommonLoader({Key? key, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? GestureDetector(
            onTap: () {},
            onDoubleTap: () {},
            child: Container(
              height: Get.height,
              width: Get.width,
              color: Colors.black.withOpacity(0.4),
              child: CupertinoActivityIndicator(
                color: lightColorPalette.liteBlue,
                radius: 20.w,
                animating: true,
              ),
            ),
          )
        : const SizedBox();
  }
}
