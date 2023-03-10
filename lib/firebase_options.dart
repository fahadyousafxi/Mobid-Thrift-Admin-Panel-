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
    apiKey: 'AIzaSyAEK4MhIdlttRyAL8lJGX8BUIlr6Rx81tg',
    appId: '1:180059824746:web:7092b0eedf32d816486013',
    messagingSenderId: '180059824746',
    projectId: 'mobidthrift',
    authDomain: 'mobidthrift.firebaseapp.com',
    storageBucket: 'mobidthrift.appspot.com',
    measurementId: 'G-WFY10GFC9P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyARBT7145tMi6x9hru5fakYKU-CMcKwDik',
    appId: '1:180059824746:android:9682bbd9195b7e6f486013',
    messagingSenderId: '180059824746',
    projectId: 'mobidthrift',
    storageBucket: 'mobidthrift.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAwDfiAUf222AVAiqjLRAvi2Kp1YZxYmfY',
    appId: '1:180059824746:ios:bf325ee99d8a3858486013',
    messagingSenderId: '180059824746',
    projectId: 'mobidthrift',
    storageBucket: 'mobidthrift.appspot.com',
    iosClientId: '180059824746-e3cm0j7ea1hgl8fijk8b6sb2h06d7j5p.apps.googleusercontent.com',
    iosBundleId: 'com.example.mobidthriftAdminPanel',
  );
}
