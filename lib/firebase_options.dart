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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBSysZiTlg2eDUKgXe04O63z808gEuwo14',
    appId: '1:475681557383:web:edaa4c1769aaabcb172122',
    messagingSenderId: '475681557383',
    projectId: 'lunch-votte',
    authDomain: 'lunch-votte.firebaseapp.com',
    storageBucket: 'lunch-votte.appspot.com',
    measurementId: 'G-1Z9GJXJ7XW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyATrBEMBfp-XDBpvzFfot2Bg6fWNe1FPrU',
    appId: '1:475681557383:android:e9114bdc76fac147172122',
    messagingSenderId: '475681557383',
    projectId: 'lunch-votte',
    storageBucket: 'lunch-votte.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDP5nT0EufzNbvgR83xMqdlVAtPTFSIKM4',
    appId: '1:475681557383:ios:14ce36c7df810d84172122',
    messagingSenderId: '475681557383',
    projectId: 'lunch-votte',
    storageBucket: 'lunch-votte.appspot.com',
    iosBundleId: 'com.example.lunchVote',
  );
}