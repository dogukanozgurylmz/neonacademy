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
    apiKey: 'AIzaSyAyPLx9qzUa76zwXtuASQMr9ifsMmb4gtU',
    appId: '1:350248674158:web:89b3a409364ebc68df577f',
    messagingSenderId: '350248674158',
    projectId: 'todoapp-f5733',
    authDomain: 'todoapp-f5733.firebaseapp.com',
    storageBucket: 'todoapp-f5733.appspot.com',
    measurementId: 'G-491T5THXYQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDY1zah0WdlwQcNm3Nh4X7CJT0Aoph-WHQ',
    appId: '1:350248674158:android:bcef5fa179cc21fcdf577f',
    messagingSenderId: '350248674158',
    projectId: 'todoapp-f5733',
    storageBucket: 'todoapp-f5733.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDBdw1NXMvqS_GRYoQsqR5xj9CM-ILSMcM',
    appId: '1:350248674158:ios:af8feedb9933333edf577f',
    messagingSenderId: '350248674158',
    projectId: 'todoapp-f5733',
    storageBucket: 'todoapp-f5733.appspot.com',
    iosClientId: '350248674158-loj1pbp2bara8b50ucinpsho6bkt8tnh.apps.googleusercontent.com',
    iosBundleId: 'com.example.librariesTasks',
  );
}
