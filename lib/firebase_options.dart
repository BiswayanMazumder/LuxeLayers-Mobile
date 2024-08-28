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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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
    apiKey: 'AIzaSyD41NyARs3bbdag0NQBQE6BTqmO08c52jI',
    appId: '1:293993080821:android:eb557b280cdcd0740922bc',
    messagingSenderId: '293993080821',
    projectId: 'luxelayers',
    storageBucket: 'luxelayers.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBW6qcBOsQa0kJt8DRHxXvWEOr61pXj-Bc',
    appId: '1:293993080821:ios:e3f3815cbd654e870922bc',
    messagingSenderId: '293993080821',
    projectId: 'luxelayers',
    storageBucket: 'luxelayers.appspot.com',
    iosBundleId: 'com.example.luxelayers',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBW6qcBOsQa0kJt8DRHxXvWEOr61pXj-Bc',
    appId: '1:293993080821:ios:e3f3815cbd654e870922bc',
    messagingSenderId: '293993080821',
    projectId: 'luxelayers',
    storageBucket: 'luxelayers.appspot.com',
    iosBundleId: 'com.example.luxelayers',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAvYR2_B7BVNKufzGZHaaUcxJYWKyQ-_Jk',
    appId: '1:293993080821:web:1882421e5bb705bb0922bc',
    messagingSenderId: '293993080821',
    projectId: 'luxelayers',
    authDomain: 'luxelayers.firebaseapp.com',
    storageBucket: 'luxelayers.appspot.com',
    measurementId: 'G-M3G99TB05F',
  );
}
