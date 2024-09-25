import 'package:daman_task/features/home/model/save_data_model.dart';
import 'package:get/get.dart';

import '../../../core/common_firebase/common_firebase_functions.dart';

class HomeDetailController extends GetxController {
  var loading = false.obs;
  var data = Rxn<SaveDataModel>();

  void onClickAddBtn() {}

  @override
  void onReady() {
    SaveDataModel? modle = Get.arguments;
    if (modle != null) {
      getDocumentDetail(modle!.recordName!);
    }
    super.onReady();
  }

  getDocumentDetail(String doucmentId) async {
    loading.value = true;
    data.value = await CommonFirebaseFunctions.getDataByDocumentId(doucmentId);
    loading.value = false;
  }
}
