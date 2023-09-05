import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocery_list_app/firebase_options.dart';
import 'package:grocery_list_app/loginScreen.dart';
import 'splash.dart';

import 'listScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MaterialApp(
    home: Splash(),
    //  (FirebaseAuth.instance.currentUser != null) ? MyHomeScreen() : Login(),
    debugShowCheckedModeBanner: false,
  ));
}
