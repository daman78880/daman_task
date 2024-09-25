import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/text/app_text_widget.dart';
import '../../../core/theme/app_color_palette.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: controller.animationController,
          builder: (context, child) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(controller.letters.length, (index) {
                final letter = controller.letters[index];
                final offset = controller.letterAnimations[index].value;
                return Transform.translate(
                  offset: Offset(0, -offset),
                  child: AppTextWidget(
                    text: letter,
                    style: CustomTextTheme.bigTitleStyle(
                      color: Colors.blue,
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
