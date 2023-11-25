import 'package:user_app/views/view_book_details.dart';

import '/views/login_screen.dart';
import '/views/signup_screen.dart';
import '/views/splash_screen.dart';
import '/views/start_screen.dart';
import 'package:flutter/material.dart';

import '../routes/route_name.dart';
import '../../views/home_screen.dart';

class MyRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const MyHomePage(),
        );
      case RouteName.viewBookDetails:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ViewBookDetails(),
        );
      case RouteName.splash:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const SplashScreen(),
        );
      case RouteName.start:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const StartScreen(),
        );
      case RouteName.signup:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const Signup(),
        );
      case RouteName.login:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const Login(),
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('No Route'),
            ),
          ),
        );
    }
  }
}
