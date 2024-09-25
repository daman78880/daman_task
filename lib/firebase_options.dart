import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'dart:io';
import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS || Platform.isMacOS) {
      // iOS and macOS Firebase configuration
      return const FirebaseOptions(
        appId: '1:815858497439:ios:c5237c04e4328e3cdf6faa', // iOS app ID
        apiKey: 'AIzaSyBIqeF_iTMDdngI1_1HI3QbYz3okWxOHig',  // iOS API key
        projectId: 'damantask',                            // Project ID
        messagingSenderId: '815858497439',                 // GCM sender ID
        iosBundleId: 'com.daman.damanTask',                // iOS Bundle ID
        storageBucket: 'damantask.appspot.com',            // Storage bucket
      );
    } else {
      // Android Firebase configuration
      return const FirebaseOptions(
        appId: '1:815858497439:android:8835497d84730c09df6faa', // Android app ID
        apiKey: 'AIzaSyA2UdsHJ6aADBr1h89nPC0k2Zb1oTLvswI',      // Android API key
        projectId: 'damantask',                                 // Project ID
        messagingSenderId: '815858497439',                      // GCM sender ID
        storageBucket: 'damantask.appspot.com',                 // Storage bucket
      );
    }
  }
}
