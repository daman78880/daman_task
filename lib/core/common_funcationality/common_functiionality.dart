import 'package:firebase_auth/firebase_auth.dart';

import '../snackbar/snackbar.dart';
import '../storage/local_storage.dart';

class CommonFunctionality {
  static Future<bool> checkUserFirstTimeLoginOrNot() async {
    if (await Prefs.read(Prefs.firstTime) ?? true) {
      Prefs.write(Prefs.firstTime, false);
      var instance = await FirebaseAuth.instance.currentUser;
      if (instance != null || instance?.uid.isNotEmpty == true) {
        await FirebaseAuth.instance
            .signOut()
            .then((value) {})
            .onError((error, stackTrace) {
          snackbar('Failed to logout please try again $error');
        });
      }
    }
    return true;
  }
}
