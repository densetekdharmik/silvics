import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silvics/contain_page.dart';
import 'package:silvics/values/colors.dart';

import 'auth/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

bool? _isLoggedIn;

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _getStatus().then((value) {
      Timer(
          Duration(seconds: 3),
          () => _isLoggedIn == true
              ? Get.offAll(() => ContainPage())
              : Get.offAll(() => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }

  Future<void> _getStatus() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = _prefs.getBool("isLoggedIn");
    });
  }
}
