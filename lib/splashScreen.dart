import 'dart:async';
import 'package:ilab_mobile/dashboard.dart';
import 'package:ilab_mobile/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(SplashScreen());
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var name = "";

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString('username');
    setState(() {
      name = user;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
    startSplashScreen();
  }

  startSplashScreen() async {
    var duration = const Duration(milliseconds: 4500);
    return Timer(duration, () {
      if (name == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) {
            return loginPage();
          }),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) {
            return dashboard();
          }),
        );
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/lottie/loading.json'),
      ),
    );
  }
}
