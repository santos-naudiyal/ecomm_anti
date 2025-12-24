// File generated manually to unblock build.
// Run `flutterfire configure` to replace this with real credentials.

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDOm9DO15nQhcPjGuh6vxo6nFTwSIqfhqw',
    appId: '1:198491870386:android:d90a3f38caa7e34c9e25ab',
    messagingSenderId: '198491870386',
    projectId: 'encomanti',
    databaseURL: 'https://encomanti-default-rtdb.firebaseio.com',
    storageBucket: 'encomanti.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDjY_YIixn09-zXvxB_2U8cbc5xjTQ6VkU',
    appId: '1:198491870386:ios:bac2189097a8807e9e25ab',
    messagingSenderId: '198491870386',
    projectId: 'encomanti',
    databaseURL: 'https://encomanti-default-rtdb.firebaseio.com',
    storageBucket: 'encomanti.firebasestorage.app',
    iosBundleId: 'com.antigravity.antigravity',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDjY_YIixn09-zXvxB_2U8cbc5xjTQ6VkU',
    appId: '1:198491870386:ios:bac2189097a8807e9e25ab',
    messagingSenderId: '198491870386',
    projectId: 'encomanti',
    databaseURL: 'https://encomanti-default-rtdb.firebaseio.com',
    storageBucket: 'encomanti.firebasestorage.app',
    iosBundleId: 'com.antigravity.antigravity',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBBXeYI-A0QLFuWzE1W5ZqMe2Ccuhn-l4Y',
    appId: '1:198491870386:web:7355aa5c8c8fd9709e25ab',
    messagingSenderId: '198491870386',
    projectId: 'encomanti',
    authDomain: 'encomanti.firebaseapp.com',
    databaseURL: 'https://encomanti-default-rtdb.firebaseio.com',
    storageBucket: 'encomanti.firebasestorage.app',
    measurementId: 'G-GGGKF8BX88',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBBXeYI-A0QLFuWzE1W5ZqMe2Ccuhn-l4Y',
    appId: '1:198491870386:web:6ce037c25325f1df9e25ab',
    messagingSenderId: '198491870386',
    projectId: 'encomanti',
    authDomain: 'encomanti.firebaseapp.com',
    databaseURL: 'https://encomanti-default-rtdb.firebaseio.com',
    storageBucket: 'encomanti.firebasestorage.app',
    measurementId: 'G-5XKK1B5HE7',
  );

}