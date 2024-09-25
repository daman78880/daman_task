import 'package:daman_task/features/login/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:daman_task/core/common_constants/common_strings.dart';
import 'package:daman_task/core/common_widgets/common_click_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/common_constants/image_resources.dart';
import '../../../core/common_widgets/asset_widget/common_image_widget.dart';
import '../../../core/common_widgets/common_button.dart';
import '../../../core/common_widgets/common_input_fields.dart';
import '../../../core/text/app_text_widget.dart';
import '../../../core/theme/app_color_palette.dart';

extension LoginExtenstion on LoginScreen {
  Widget loginTitle() {
    return Column(
      children: [
        SizedBox(
          height: 40.h,
        ),
        AppTextWidget(
          text: CommonStrings.login.tr,
          style: CustomTextTheme.extraBigTitleStyle(
              color: Colors.blue, textSize: 40.sp),
        ),
        SizedBox(
          height: 40.h,
        ),
      ],
    );
  }

  Widget emailInputField() {
    return Column(
      children: [
        Obx(
          () => commonTextFieldWidget(
              hint: CommonStrings.emailHint.tr,
              title: CommonStrings.email.tr,
              controller: controller.emailController,
              errorMsg: controller.emailErrorMsg.value,
              onChanged: (value) {
                controller.validate(onChangeEmail: true);
              },
              isError: controller.emailErrorMsg.value.isNotEmpty),
        ),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }

  Widget pwdInputField() {
    return Column(
      children: [
        Obx(
          () => commonTextFieldWidget(
              hint: CommonStrings.pwdHint.tr,
              title: CommonStrings.pwd.tr,
              controller: controller.pwdController,
              errorMsg: controller.pwdErrorMsg.value,
              onChanged: (value) {
                controller.validate(onChangePwd: true);
              },
              isError: controller.pwdErrorMsg.value.isNotEmpty),
        ),
        SizedBox(
          height: 40.h,
        ),
      ],
    );
  }

  Widget loginField() {
    return Column(
      children: [
        CommonButton(
          onPress: () => controller.onClickLogin(),
          txt: CommonStrings.login.tr,
        ),
        SizedBox(
          height: 50.h,
        ),
      ],
    );
  }

  Widget googleLoginIcon() {
    return Column(
      children: [
        CommonClick(
          onTap: () => controller.onGoogleLoginClick(),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1000),
              boxShadow: commonHomeIconsShadowZoom(),
            ),
            child: Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                  color: lightColorPalette.whiteColor,
                  borderRadius: BorderRadius.circular(1000),
                  border:
                      Border.all(color: lightColorPalette.black, width: 1.w)),
              child: AssetWidget(
                asset: Asset(type: AssetType.svg, path: ImageResource.googleIc),
                boxFit: BoxFit.fill,
                width: 30.w,
                height: 30.w,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
