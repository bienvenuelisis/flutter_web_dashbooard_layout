import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'pages/404.dart';
import 'pages/dashboard.dart';
import 'pages/login.dart';
import 'pages/splash_screen.dart';

class Application {
  static late FluroRouter router;
}

class Routes {
  static String root = "/";

  static String home = "/home";


  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
      handlerFunc: (
        BuildContext? context,
        Map<String, List<String>> params,
      ) {
        return const Page404();
      },
    );

    router.define(root, handler: rootHandler);

    router.define(
      home,
      handler: homehandler,
      transitionType: TransitionType.none,
    );
  }
}

var rootHandler = Handler(
  handlerFunc: (
    BuildContext? context,
    Map<String, List<String>> params,
  ) {
    return const SplashScreen();
  },
);

var homehandler = Handler(
  handlerFunc: (
    BuildContext? context,
    Map<String, List<String>> params,
  ) {
    return true ? const DashboardHome() : const LoginPage(title : "Login Page");
  },
);