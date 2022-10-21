import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infootprints_ebook/activity/general/EnterLoginDetailsScreen.dart';
import 'package:infootprints_ebook/activity/Welcome/HomePage.dart';
import 'package:infootprints_ebook/activity/utils/BottomNavBar.dart';
import 'package:infootprints_ebook/activity/utils/CONFIG.dart';
import 'package:infootprints_ebook/activity/utils/SharedPrefrence.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin { // TickerProviderStateMixin is iheretied property for showing animation in stateful widget
  late AnimationController controller;/*
  To control the dummy linear progress bar animation
  * declaring AnimationController as controller
   */
// initializing before calling build
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    controller.forward();
    endSplashScreen();
    super.initState();
  }
// disposing the initialize contents after being initialized to prevent memory leak
  @override
  void dispose() {
    controller.dispose();
    endSplashScreen();
    super.dispose();
  }

  Future<void> endSplashScreen() async {
    Timer(Duration(seconds: 3), () async {
      if(await SharePreference.getBooleanValue(CONFIG.IS_LOGIN) == true){
      if (mounted)
        setState(() {
          
          Navigator.pushReplacement<void, void>(
            context,
            CupertinoPageRoute<void>(
              builder: (BuildContext context) => BottomNavBar(),
            ),
          );
        });}
        else{
          if (mounted)
        setState(() {
          
          Navigator.pushReplacement<void, void>(
            context,
            CupertinoPageRoute<void>(
              builder: (BuildContext context) => EnterLoginDetails(),
            ),
          );
        });
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/infootprints_logo.png",
            filterQuality: FilterQuality.high,
            scale: 1.5,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 100.0, vertical: 30),
            child: LinearProgressIndicator(
              value: controller.value,
              backgroundColor: CupertinoColors.systemGrey2,
              color: Color(0xff132EBE),
            ),
          )
        ],
      ),
    );
  }
}
