import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:daman_task/core/common_constants/common_strings.dart';
import 'package:daman_task/core/common_widgets/asset_widget/common_image_widget.dart';
import '../../../core/text/app_text_widget.dart';
import '../../../core/theme/app_color_palette.dart';
import '../screen/home_detail_screen.dart';

extension HomeDetailExtenstion on HomeDetailScreen {
  AppBar appBarHomeDetail() {
    return AppBar(
      backgroundColor: lightColorPalette.liteBlue,
      centerTitle: true,
      title: AppTextWidget(
        text: CommonStrings.detailScreen.tr,
        style: CustomTextTheme.bigTitleStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget recordNameWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => AppTextWidget(
            text:
                '${CommonStrings.name.tr} -> ${controller.data?.value?.recordName ?? ''}',
            style: CustomTextTheme.bigTitleStyle(
                color: lightColorPalette.liteBlue),
          ),
        ),
        SizedBox(
          height: 40.h,
        ),
      ],
    );
  }

  Widget listOfImageWidget() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      AppTextWidget(
        text: CommonStrings.memoryImageList.tr,
        style: CustomTextTheme.bigTitleStyle(),
      ),
      SizedBox(
        height: 10.h,
      ),
      ListView.separated(
        separatorBuilder: (context, index) {
          return Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 10.h),
            height: 1.h,
          );
        },
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        itemCount: controller.data.value?.imageUrls?.length ?? 0,
        itemBuilder: (context, index) {
          String? item = controller.data.value?.imageUrls?[index];
          return item != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: lightColorPalette.black, width: 1.w),
                        borderRadius: BorderRadius.circular(8.r)),
                    width: double.infinity,
                    height: 100.h,
                    child: AssetWidget(
                      asset: Asset(type: AssetType.network, path: item),
                      boxFit: BoxFit.fill,
                      width: 18.w,
                      height: 18.w,
                    ),
                  ),
                )
              : const SizedBox();
        },
      ),
    ]);
  }

  Widget noImageTxtWidget() {
    return AppTextWidget(
      text: CommonErrorMsg.notImageFound.tr,
      style: CustomTextTheme.bigTitleStyle(),
    );
  }
}
