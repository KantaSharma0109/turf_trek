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
    apiKey: 'AIzaSyCsR2mr4s6mUU-W8UI_xAtC6eYyAQMJkP4',
    appId: '1:759324678452:web:7438ba32e1f4ac4443ed61',
    messagingSenderId: '759324678452',
    projectId: 'turf-trek-3d9dc',
    authDomain: 'turf-trek-3d9dc.firebaseapp.com',
    storageBucket: 'turf-trek-3d9dc.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCTwl0e8IhJTc8BYyB1F-7FfZETfBCS9L8',
    appId: '1:759324678452:android:c1a515752bd3c52843ed61',
    messagingSenderId: '759324678452',
    projectId: 'turf-trek-3d9dc',
    storageBucket: 'turf-trek-3d9dc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJqHvdrlCK-3X7p6HeUJIuPIo0yYbfhrg',
    appId: '1:759324678452:ios:6e4a366691cfb66143ed61',
    messagingSenderId: '759324678452',
    projectId: 'turf-trek-3d9dc',
    storageBucket: 'turf-trek-3d9dc.appspot.com',
    iosBundleId: 'com.example.turfTrek',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBJqHvdrlCK-3X7p6HeUJIuPIo0yYbfhrg',
    appId: '1:759324678452:ios:6e4a366691cfb66143ed61',
    messagingSenderId: '759324678452',
    projectId: 'turf-trek-3d9dc',
    storageBucket: 'turf-trek-3d9dc.appspot.com',
    iosBundleId: 'com.example.turfTrek',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCsR2mr4s6mUU-W8UI_xAtC6eYyAQMJkP4',
    appId: '1:759324678452:web:87be3c426011410343ed61',
    messagingSenderId: '759324678452',
    projectId: 'turf-trek-3d9dc',
    authDomain: 'turf-trek-3d9dc.firebaseapp.com',
    storageBucket: 'turf-trek-3d9dc.appspot.com',
  );

}