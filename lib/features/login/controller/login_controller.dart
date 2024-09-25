import 'package:daman_task/core/common_constants/common_strings.dart';
import 'package:daman_task/core/snackbar/snackbar.dart';
import 'package:daman_task/core/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/common_firebase/common_firebase_functions.dart';
import '../../../core/routes/routes.dart';
import '../../../core/social_login/social_login.dart';
import '../../../core/storage/local_storage.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var pwdController = TextEditingController();
  var emailErrorMsg = ''.obs;
  var pwdErrorMsg = ''.obs;
  var loading = false.obs;

  onClickLogin() {
    dismissKeyboard();
    validate();
  }

  validate({bool onChangeEmail = false, bool onChangePwd = false}) {
    String email = emailController.text.trim();
    String pwd = pwdController.text.trim();
    if (onChangeEmail) {
      emailCheck(email: email);
    } else if (onChangePwd) {
      pwdCheck(pwd: pwd);
    } else {
      emailCheck(email: email);
      pwdCheck(pwd: pwd);
      if (emailErrorMsg.value.isEmpty && pwdErrorMsg.value.isEmpty) {
        loginEmailPwd(email: email, pwd: pwd);
      }
    }
  }

  loginEmailPwd({required String email, required String pwd}) async {
    loading.value = true;
    User? user =
        await CommonFirebaseFunctions.loginOrRegisterWithEmailPassword(
            email, pwd);
    loading.value = false;
    if (user != null) {
      Get.toNamed(Routes.homeScreen);
    }
  }

  void emailCheck({required String email}) {
    if (email.isEmpty) {
      pwdErrorMsg.value = CommonErrorMsg.pwdEmpty.tr;
    } else {
      if (!validateEmail(email: email)) {
        emailErrorMsg.value = CommonErrorMsg.emailInvalid.tr;
      } else {
        emailErrorMsg.value = '';
      }
    }
  }

  void pwdCheck({required String pwd}) {
    if (pwd.isEmpty) {
      emailErrorMsg.value = CommonErrorMsg.emailEmpty.tr;
    } else {
      if (!validatePwd(pwd: pwd)) {
        pwdErrorMsg.value = CommonErrorMsg.pwdInvalidEmpty.tr;
      } else {
        pwdErrorMsg.value = '';
      }
    }
  }

  onGoogleLoginClick() {
    dismissKeyboard();
    loading.value = true;
    SocialLogin.signInWithGoogle().then((value) async {
      loading.value = false;
      if (value != null) {
        var name = value.displayName ?? '';
        var email = value.email ?? '';
        var number = value.phoneNumber ?? '';
        var profile = value.photoURL ?? "";
        if (email.trim().isEmpty == true) {
          email = '${(value.phoneNumber ?? '123456789')}@apple.com';
        }
        print('email ${value.email} and phonenO.${value.phoneNumber}');
        await Prefs.write(Prefs.userLogin, true);
        await Prefs.write(Prefs.email, email);
        Get.toNamed(Routes.homeScreen);
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      snackbar(error.toString());
      print('on Error $error');
    });
  }
}
