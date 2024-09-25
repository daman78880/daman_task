import 'package:daman_task/core/common_constants/common_strings.dart';
import 'package:daman_task/core/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/routes.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  final letters = (CommonStrings.applicationName.tr).split('');
  final List<Animation<double>> letterAnimations = [];

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _setupAnimations();
    animationController.forward().then((_) => _navigateToNextScreen());
  }

  void _setupAnimations() {
    final intervalStep = 1.0 / letters.length;

    for (int i = 0; i < letters.length; i++) {
      final start = intervalStep * i;
      final end = start + (intervalStep / 2);

      letterAnimations.add(
        Tween<double>(begin: 50, end: 0).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval(start, end, curve: Curves.easeOut),
          ),
        ),
      );
    }

    // Add bounce animation for the entire name at the end
    letterAnimations.add(
      Tween<double>(begin: 0, end: 20).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Interval(0.8, 1.0, curve: Curves.bounceOut),
        ),
      ),
    );
  }

  void _navigateToNextScreen() async {
    bool userLogin = await Prefs.readBool(Prefs.userLogin);
    if (userLogin) {
      Get.offAllNamed(Routes.homeScreen);
    } else {
      Get.offAllNamed(Routes.loginScreen);
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
