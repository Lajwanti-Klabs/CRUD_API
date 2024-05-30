
import 'package:flutter/material.dart';

import '../../services/splash_services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  SplashService splashService = SplashService();
  @override
  void initState() {
    super.initState();
    splashService.service(context);
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:Center(
        child: Text(
          "Splash Screen",
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
