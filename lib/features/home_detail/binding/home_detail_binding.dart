import 'package:get/get.dart';

import '../controller/home_detail_controller.dart';

class HomeDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>HomeDetailController());
  }

}