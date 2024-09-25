import 'package:daman_task/core/common_constants/common_constants.dart';
import 'package:daman_task/features/home/binding/home_binding.dart';
import 'package:daman_task/features/home/screen/home_screen.dart';
import 'package:daman_task/features/home_detail/binding/home_detail_binding.dart';
import 'package:daman_task/features/home_detail/screen/home_detail_screen.dart';
import 'package:daman_task/features/login/binding/login_binding.dart';
import 'package:daman_task/features/login/screen/login_screen.dart';
import 'package:get/get.dart';

import '../../features/splash/binding/splash_binding.dart';
import '../../features/splash/screen/splash_screen.dart';

class Routes {
  Routes._();

  static const String root = "/";
  static const String loginScreen = "/LoginScreen";
  static const String homeScreen = "/HomeScreen";
  static const String homeDetailScreen = "/HomeDetailScreen";
}

List<GetPage> appPages() => [
      GetPage(
        name: Routes.root,
        page: () => const SplashScreen(),
        fullscreenDialog: true,
        binding: SplashBinding(),
        transition: CommonConstants.transition,
        transitionDuration:
            const Duration(milliseconds: CommonConstants.transitionDuration),
      ),
      GetPage(
        name: Routes.loginScreen,
        page: () => const LoginScreen(),
        fullscreenDialog: true,
        binding: LoginBinding(),
        transition: CommonConstants.transition,
        transitionDuration:
            const Duration(milliseconds: CommonConstants.transitionDuration),
      ),
      GetPage(
        name: Routes.homeScreen,
        page: () => const HomeScreen(),
        fullscreenDialog: true,
        binding: HomeBinding(),
        transition: CommonConstants.transition,
        transitionDuration:
            const Duration(milliseconds: CommonConstants.transitionDuration),
      ),
      GetPage(
        name: Routes.homeDetailScreen,
        page: () => const HomeDetailScreen(),
        fullscreenDialog: true,
        binding: HomeDetailBinding(),
        transition: CommonConstants.transition,
        transitionDuration:
            const Duration(milliseconds: CommonConstants.transitionDuration),
      ),
    ];
