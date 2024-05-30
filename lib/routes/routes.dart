


import 'package:crud_api/routes/route_name.dart';
import 'package:flutter/material.dart';

import '../screens/posts/posts_screen.dart';
import '../screens/splash/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(builder: (_)=>const SplashScreen());

      case RouteNames.postsScreen:
        return MaterialPageRoute(builder: (_)=>const PostsScreen());

      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text("no route define"),
            ),
          );
        });
    }
  }
}