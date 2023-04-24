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
    apiKey: 'AIzaSyD_Im3tDJCfxAk_eYrKUP3Y7sJyLJvP2fE',
    appId: '1:544511616263:web:96f57451c2884cc8f011a2',
    messagingSenderId: '544511616263',
    projectId: 'elobyte-task-202304',
    authDomain: 'elobyte-task-202304.firebaseapp.com',
    storageBucket: 'elobyte-task-202304.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCh0VH1oQDQqsph4XJ04Dzu7SrEUQhiuoU',
    appId: '1:544511616263:android:28b07d3ca8961a96f011a2',
    messagingSenderId: '544511616263',
    projectId: 'elobyte-task-202304',
    storageBucket: 'elobyte-task-202304.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBb4xG6QLxU0e_o-qEHWHotGDvJdf6PNIE',
    appId: '1:544511616263:ios:2c2796daca4edaf1f011a2',
    messagingSenderId: '544511616263',
    projectId: 'elobyte-task-202304',
    storageBucket: 'elobyte-task-202304.appspot.com',
    iosClientId: '544511616263-50gmh1jogjphbv1hpe62vgtt0l5etl8i.apps.googleusercontent.com',
    iosBundleId: 'com.example.eloByteTask',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBb4xG6QLxU0e_o-qEHWHotGDvJdf6PNIE',
    appId: '1:544511616263:ios:2c2796daca4edaf1f011a2',
    messagingSenderId: '544511616263',
    projectId: 'elobyte-task-202304',
    storageBucket: 'elobyte-task-202304.appspot.com',
    iosClientId: '544511616263-50gmh1jogjphbv1hpe62vgtt0l5etl8i.apps.googleusercontent.com',
    iosBundleId: 'com.example.eloByteTask',
  );
}
