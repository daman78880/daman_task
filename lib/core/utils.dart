import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

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
