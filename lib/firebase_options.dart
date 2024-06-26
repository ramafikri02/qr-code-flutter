// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBz52BM6_rPC1Lf0LohTjUsPrJiC7uJH1E',
    appId: '1:435499663337:web:17777a888006fe8cfcd578',
    messagingSenderId: '435499663337',
    projectId: 'learn-qr-code',
    authDomain: 'learn-qr-code.firebaseapp.com',
    storageBucket: 'learn-qr-code.appspot.com',
    measurementId: 'G-800RY58WMW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAtMz-N_O22qjfGOe9yuPD2iQUZnQnMz0I',
    appId: '1:435499663337:android:4fc91a06d372760cfcd578',
    messagingSenderId: '435499663337',
    projectId: 'learn-qr-code',
    storageBucket: 'learn-qr-code.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAxOFzEl586QxX-Z8bEJRG-mdKh4L05MCo',
    appId: '1:435499663337:ios:352739f0a9b20b69fcd578',
    messagingSenderId: '435499663337',
    projectId: 'learn-qr-code',
    storageBucket: 'learn-qr-code.appspot.com',
    iosBundleId: 'com.lucasapps.qrCode',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAxOFzEl586QxX-Z8bEJRG-mdKh4L05MCo',
    appId: '1:435499663337:ios:352739f0a9b20b69fcd578',
    messagingSenderId: '435499663337',
    projectId: 'learn-qr-code',
    storageBucket: 'learn-qr-code.appspot.com',
    iosBundleId: 'com.lucasapps.qrCode',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBz52BM6_rPC1Lf0LohTjUsPrJiC7uJH1E',
    appId: '1:435499663337:web:878531bbdb5695dcfcd578',
    messagingSenderId: '435499663337',
    projectId: 'learn-qr-code',
    authDomain: 'learn-qr-code.firebaseapp.com',
    storageBucket: 'learn-qr-code.appspot.com',
    measurementId: 'G-RNQFCE2LHR',
  );
}
