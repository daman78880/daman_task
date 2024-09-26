import 'package:daman_task/core/routes/routes.dart';
import 'package:daman_task/core/snackbar/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../features/home/model/save_data_model.dart';

bool validateEmail({required String email}) {
  final bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  return emailValid;
}

bool validatePwd({required String pwd}) {
  return pwd.length > 5 ? true : false;
}

dismissKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

Future<XFile?> compressImage(
    {required XFile? file, required lowQuality}) async {
  if (file == null) {
    return null;
  }
  final filePath = file.path;
  final dir = await (await getTemporaryDirectory()).absolute.path;
  final targetPath =
      '${dir}/${DateTime.now().toString().trim().removeAllWhitespace}.png';
  XFile? result = await FlutterImageCompress.compressAndGetFile(
      filePath, targetPath,
      minWidth: 400,
      minHeight: 400,
      quality: lowQuality ? 30 : 50,
      format: CompressFormat.png);
  return result;
}

Future<bool> moreThanFiveMb(int size) async {
  const fiveMbInBytes = 5 * 1024 * 1024; // 5 MB in bytes
  return size > fiveMbInBytes;
}

Stream<List<SaveDataModel>> getDataList() async* {
  String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
  if (currentUserId == null) {
    snackbar('User is not logged in.');
    Get.offAllNamed(Routes.loginScreen);
    return;
  }
  await for (QuerySnapshot snap in FirebaseFirestore.instance
      .collection('Data')
      .where('user_id', isEqualTo: currentUserId)
      .snapshots()) {
    if (snap.docs.isNotEmpty) {
      try {
        List<SaveDataModel> listOfData = snap.docs
            .map(
              (e) => SaveDataModel.fromJson(e.data() as Map<String, dynamic>),
            )
            .toList();
        yield listOfData;
      } catch (e) {
        print('Error mapping Firestore data: $e');
        yield []; // Yield an empty list in case of error
      }
    } else {
      yield []; // Yield an empty list if no documents are found
    }
  }
}
