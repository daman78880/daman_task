import 'package:daman_task/features/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:daman_task/core/common_constants/common_strings.dart';
import 'package:daman_task/core/common_widgets/common_click_widgets.dart';
import '../../../core/text/app_text_widget.dart';
import '../../../core/common_firebase/common_firebase_functions.dart';
import '../../../core/theme/app_color_palette.dart';

extension HomeExtenstion on HomeScreen {
  AppBar appBarHome(){
    return AppBar(
      backgroundColor: lightColorPalette.liteBlue,
      centerTitle: true,
      title: AppTextWidget(
        text: CommonStrings.memoryList.tr,
        style: CustomTextTheme.bigTitleStyle(
          color: Colors.white,
        ),
      ),
      actions: [
        CommonClick(
          onTap: () => controller.onLogOutClick(),
          child: Row(
            children: [
              AppTextWidget(
                text: CommonStrings.logOut.tr,
                style: CustomTextTheme.bigTitleStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 16.w,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget listOfData(){
    return StreamBuilder(
      stream: CommonFirebaseFunctions.getDataList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
            separatorBuilder: (context, index) {
              return Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 10.h),
                height: 1.h,
                color: lightColorPalette.black,
              );
            },
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              var item = snapshot.data?[index];
              return item != null
                  ? CommonClick(
                onTap: () {
                  controller.onClickItem(item);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  child: AppTextWidget(
                      text: item.recordName ?? '',
                      style: CustomTextTheme.bigTitleStyle(
                        color: Colors.blue,
                      )),
                ),
              )
                  : const SizedBox();
            },
          );
        } else {
          return Center(
              child: AppTextWidget(
                  text: CommonStrings.noMemoryList.tr,
                  style: CustomTextTheme.bigTitleStyle(
                    color: Colors.blue,
                  )));
        }
      },
    );
  }
}
