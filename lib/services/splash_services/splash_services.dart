
import 'package:flutter/material.dart';

import '../../routes/route_name.dart';

class SplashService{

  void service(BuildContext context){
    Future.delayed(const Duration(seconds: 3),(){
      Navigator.pushNamed(context, RouteNames.postsScreen);
    });
  }
}