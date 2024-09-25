import 'package:daman_task/features/login/extenstion/login_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/common_widgets/common_loader.dart';
import '../../../core/theme/app_color_palette.dart';
import '../controller/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(color: lightColorPalette.whiteColor),
              child: Column(
                children: [
                  loginTitle(),
                  emailInputField(),
                  pwdInputField(),
                  loginField(),
                  googleLoginIcon()
                ],
              ),
            ),
          ),
          Obx(() => CommonLoader(isLoading: controller.loading.value))
        ],
      ),
    );
  }
}
