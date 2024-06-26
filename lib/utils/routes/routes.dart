import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/route_names.dart';
import 'package:mvvm/view/home_screen.dart';
import 'package:mvvm/view/login_view.dart';
import 'package:mvvm/view/splash_view.dart';

import '../../view/signup_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen());
      case RouteNames.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginView());
      case RouteNames.signUp:
        return MaterialPageRoute(
            builder: (BuildContext context) => SignUpView());
      case RouteNames.splash:
        return MaterialPageRoute(
            builder: (BuildContext conext) => SplashView());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text("No routes defined"),
            ),
          );
        });
    }
  }
}
