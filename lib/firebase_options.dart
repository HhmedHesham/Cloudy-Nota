// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCd5Luu43wgE90pybuyUiCUtTm-BgGHApk',
    appId: '1:691627877270:web:cc8a0347362d9e6c5333b7',
    messagingSenderId: '691627877270',
    projectId: 'cloud-nota',
    authDomain: 'cloud-nota.firebaseapp.com',
    storageBucket: 'cloud-nota.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBUIdBaqDI2pkeXtaPpGLCX-lAZZFITAp4',
    appId: '1:691627877270:android:e21b61cda5a0bda75333b7',
    messagingSenderId: '691627877270',
    projectId: 'cloud-nota',
    storageBucket: 'cloud-nota.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAq_KT5aJPM3Bh-smR_aZFXYwoaTYQnmUE',
    appId: '1:691627877270:ios:692e0a746dd0b8cf5333b7',
    messagingSenderId: '691627877270',
    projectId: 'cloud-nota',
    storageBucket: 'cloud-nota.appspot.com',
    iosClientId: '691627877270-lgt0fmsg71nnsuftavn6c0e2fer4q9d3.apps.googleusercontent.com',
    iosBundleId: 'com.example.cloudyNota',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAq_KT5aJPM3Bh-smR_aZFXYwoaTYQnmUE',
    appId: '1:691627877270:ios:692e0a746dd0b8cf5333b7',
    messagingSenderId: '691627877270',
    projectId: 'cloud-nota',
    storageBucket: 'cloud-nota.appspot.com',
    iosClientId: '691627877270-lgt0fmsg71nnsuftavn6c0e2fer4q9d3.apps.googleusercontent.com',
    iosBundleId: 'com.example.cloudyNota',
  );
}