import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_list_app/listScreen.dart';
import 'package:grocery_list_app/loginScreen.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  Future<void> navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 5));
    if (FirebaseAuth.instance.currentUser != null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MyHomeScreen()));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Lottie.network(
          'https://lottie.host/3db83d39-4211-4bc9-b517-b9835791efa5/stoY5bReal.json'),
    );
  }
}
