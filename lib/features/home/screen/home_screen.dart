import 'package:daman_task/features/home/controller/home_controller.dart';
import 'package:daman_task/features/home/extenstion/home_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/common_widgets/common_loader.dart';
import '../../../core/theme/app_color_palette.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: appBarHome(),
          body: Container(
            padding: EdgeInsets.only(top: 20.w),
            decoration: BoxDecoration(color: lightColorPalette.whiteColor),
            child: listOfData(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.onClickAddBtn();
            },
            child: const Icon(Icons.add),
          ),
        ),
        Obx(() => CommonLoader(isLoading: controller.loading.value))
      ],
    );
  }
}
