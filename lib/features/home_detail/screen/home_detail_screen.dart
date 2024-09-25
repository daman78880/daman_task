import 'package:daman_task/features/home_detail/extenstion/home_detail_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/common_widgets/common_loader.dart';
import '../../../core/theme/app_color_palette.dart';
import '../controller/home_detail_controller.dart';

class HomeDetailScreen extends GetView<HomeDetailController> {
  const HomeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: appBarHomeDetail(),
          body: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              decoration: BoxDecoration(color: lightColorPalette.whiteColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  recordNameWidget(),
                  Obx(() => controller.data.value?.imageUrls?.isNotEmpty == true
                      ? Expanded(
                          child: listOfImageWidget(),
                        )
                      : noImageTxtWidget())
                ],
              )),
        ),
        Obx(() => CommonLoader(isLoading: controller.loading.value))
      ],
    );
  }
}
