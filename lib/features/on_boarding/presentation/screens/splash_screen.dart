import 'dart:async';

import 'package:naser_alqtami/utils/app_utils/assets_manager.dart';
import 'package:naser_alqtami/utils/app_utils/preference.dart';
import 'package:flutter/material.dart';

import '../../../../config/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  _goNext() {
    bool fristTime = Preference.getBool(PrefKeys.fristTime) ?? true;
    if (fristTime) {
      Preference.setBool(PrefKeys.fristTime, false);
      Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
    } else {
      Navigator.pushReplacementNamed(context, Routes.mainScreen);
    }
  }

  _startDelay() {
    _timer = Timer(const Duration(milliseconds: 0), () => _goNext());
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagesPaths.splash),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
