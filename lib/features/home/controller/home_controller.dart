import 'package:daman_task/core/routes/routes.dart';
import 'package:daman_task/core/snackbar/snackbar.dart';
import 'package:daman_task/core/utils.dart';
import 'package:daman_task/features/home/model/save_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/common_constants/common_constants.dart';
import '../../../core/common_constants/common_strings.dart';
import '../../../core/common_firebase/common_firebase_functions.dart';
import '../../../core/common_widgets/common_input_fields.dart';
import '../../../core/text/app_text_widget.dart';
import '../../../core/theme/app_color_palette.dart';

class HomeController extends GetxController {
  var loading = false.obs;
  List<XFile> pickedImageList = [];
  Set<String> finalAddList = {};

  void onClickAddBtn() {
    showAddDataDialog(
      CommonStrings.addRecord.tr,
    );
  }

  onLogOutClick() async {
    loading.value = true;
    dismissKeyboard();
    await CommonFirebaseFunctions.logOutUser();
    Get.offAllNamed(Routes.loginScreen);
  }

  Future<void> pickMultipleImages() async {
    final picker = ImagePicker();
    final List<XFile>? images =
        await picker.pickMultiImage(limit: 3, maxWidth: 400, maxHeight: 400);
    if (images != null) {
      pickedImageList = images;
    }
  }

  void showAddDataDialog(
    String title,
  ) {
    final nameController = TextEditingController();
    final imagePathController = TextEditingController();
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            commonTextFieldWidget(
              hint: CommonStrings.idName.tr,
              controller: nameController,
            ),
            TextButton(
                onPressed: () {
                  pickedImageList.clear();
                  finalAddList.clear();
                  pickMultipleImages();
                },
                child: AppTextWidget(
                  text: CommonStrings.pickImage.tr,
                  style:
                      CustomTextTheme.normalTextStyle(color: Colors.lightBlue),
                )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: AppTextWidget(
              text: CommonStrings.cancel.tr,
              style: CustomTextTheme.normalTextStyle(color: Colors.lightBlue),
            ),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.trim().isNotEmpty) {
                addImageFromToList(recordName: nameController.text.trim());
              } else {
                snackbar(CommonErrorMsg.recordName.tr);
              }
            },
            child: AppTextWidget(
              text: CommonStrings.add.tr,
              style: CustomTextTheme.normalTextStyle(color: Colors.lightBlue),
            ),
          ),
        ],
      ),
    );
  }

  addImageFromToList({required String recordName}) async {
    Get.back();
    await Future.delayed(const Duration(milliseconds: 50));
    loading.value = true;
    if (pickedImageList.isNotEmpty) {
      for (var element in pickedImageList ?? []) {
        final fileSize = await element.length();
        XFile? compressImageFile = await compressImage(
            file: element, lowQuality: await (moreThanFiveMb(fileSize ?? 0)));
        final fileSizeAfter = await element.length();
        if (fileSizeAfter > CommonConstants.imageRestrictionSize) {
          snackbar(CommonStrings.imageRestrictionMsg.tr);
        } else {
          if (compressImageFile?.path.isNotEmpty == true) {
            finalAddList.add(compressImageFile!.path);
          }
        }
      }
      var listOfUrl = <String>[];
      for (String element in finalAddList ?? []) {
        String? url =
            await CommonFirebaseFunctions.uploadImageToFirebase(element);
        if (url != null) {
          listOfUrl.add(url);
        }
      }
      if (listOfUrl.isNotEmpty) {
        var upload = await CommonFirebaseFunctions.addImagesToFirestore(
            recordName, listOfUrl);
      }
      // await CommonFirebaseFunctions.addImagesToFirestore(recordName,['https://www.shutterstock.com/image-photo/macro-imagr-bee-beautiful-cosmos-260nw-1282844242.jpg']);
      loading.value = false;
    } else {
      loading.value = false;
      snackbar(CommonErrorMsg.atLeastOneImage.tr);
    }
  }

  onClickItem(SaveDataModel saveDataModel) {
    Get.toNamed(Routes.homeDetailScreen, arguments: saveDataModel);
  }
}
