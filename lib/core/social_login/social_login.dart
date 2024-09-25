import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialLogin {
  static var firebaseAuth = FirebaseAuth.instance;

  static Future<void> signOut({required bool showError}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    if (await googleSignIn.isSignedIn()) {
      try {
        if (!kIsWeb) {
          await googleSignIn.signOut();
        }
        await firebaseAuth.signOut();
      } catch (e) {
        if (showError) {
          Get.snackbar("Error", 'Error signing out. Try again.');
        }
      }
    }
  }

  static Future<User?> signInWithGoogle() async {
    FirebaseAuth auth = firebaseAuth;
    User? user;
    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();
      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);
        user = userCredential.user;
      } catch (e) {
        if (kDebugMode) {
          print('Web User Login Failed Due to $e');
        }
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        if (kDebugMode) {}
        if (!kIsWeb) {
          await googleSignIn.signOut();
        } else {
          await auth.signOut();
        }
      } else {
        if (kDebugMode) {}
      }
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);
          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (kDebugMode) {
            print('User Login Failed Due to $e');
          }
          if (e.code == 'account-exists-with-different-credential') {
            // ...
          } else if (e.code == 'invalid-credential') {
            // ...
          }
        } catch (e) {
          // ...
        }
      }
    }
    return user;
  }
}
