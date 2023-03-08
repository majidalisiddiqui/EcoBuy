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
    apiKey: 'AIzaSyAh_mFd2swdRmRzZz3fKqH3ubCdSDjs8nY',
    appId: '1:388386903485:web:c14af524c1b219c0672ed4',
    messagingSenderId: '388386903485',
    projectId: 'eco-buy-a65a4',
    authDomain: 'eco-buy-a65a4.firebaseapp.com',
    databaseURL: 'https://eco-buy-a65a4-default-rtdb.firebaseio.com',
    storageBucket: 'eco-buy-a65a4.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBFUhcKnKPIph5h9FZejBO-mJfWA4W9jGs',
    appId: '1:388386903485:android:0b5c57e6858ffeef672ed4',
    messagingSenderId: '388386903485',
    projectId: 'eco-buy-a65a4',
    databaseURL: 'https://eco-buy-a65a4-default-rtdb.firebaseio.com',
    storageBucket: 'eco-buy-a65a4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA-8PWeXh-4RPhnipCzeidDq6aimEHrw-U',
    appId: '1:388386903485:ios:58b9e44193cb6920672ed4',
    messagingSenderId: '388386903485',
    projectId: 'eco-buy-a65a4',
    databaseURL: 'https://eco-buy-a65a4-default-rtdb.firebaseio.com',
    storageBucket: 'eco-buy-a65a4.appspot.com',
    iosClientId: '388386903485-19igas6hvt237927vdrsa75el1vcstgg.apps.googleusercontent.com',
    iosBundleId: 'com.example.ecoBuy',
  );
}