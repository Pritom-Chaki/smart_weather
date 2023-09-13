import 'dart:async';

import 'package:flutter/material.dart';

import '../../components/location/fetch_location.dart';
import '../../utils/constant_data.dart';
import '../../utils/local_storage/local_store_manager.dart';
import '../landing_page.dart';
import 'on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final Tween<double> _tween = Tween(begin: 0.75, end: 1);
  @override
  void initState() {
    super.initState();
    _getLocation();
    _timer();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _controller.repeat(reverse: true, max: 1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _getLocation() {
    FetchLocation().getCurrentLocation().then((value) {
      if (value != null) {
        LocalStorageManager.saveData(AppConstant.location, "${value.latitude}, ${value.longitude}");
        debugPrint("Location Value = $value");
      }
    });
  }

  void _timer() async {
    final isOnBoarding =
        await LocalStorageManager.readData(AppConstant.onBoarding);

    Timer(const Duration(seconds: 3), () {
      // Navigator.pushReplacement(context,
      //         MaterialPageRoute(builder: (context) => const LandingPage(pageNo: 0,)));
      if (isOnBoarding == true || isOnBoarding == null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const OnBoardingScreen()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LandingPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        alignment: Alignment.center,
        child: Image.asset("assets/images/full_logo.png"),
      ),
    );
  }
}
