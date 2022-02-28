import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_dashbooard_layout/extensions/context.dart';

import '../providers/app_settings_notifier.dart';
import '../utils.dart';
import 'dashboard.dart';
import 'login.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
// import 'package:woodtracking_web/providers/commons/app_status_notifier.dart';
// import 'package:woodtracking_web/utils/utils.dart';
// import 'package:woodtracking_web/views/home/home_page.dart';
// import 'package:woodtracking_web/views/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  //Animation controller
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      //to use "this" we need to add "with SingleTickerProviderStateMixin"
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward().then((value) => loading = true);
  }

  bool _loading = false;

  bool get loading => _loading;

  set loading(value) {
    setState(() {
      _loading = value;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      AppSettingsModel app = watch(appSettingsProvider);

      return app.isAppInit
          ? ((app.userConnected
              ? const DashboardHome()
              : const LoginPage(
                  title: "Login Page",
                )))
          : (loading
              ? Material(
                  child: Column(
                    children: [
                      SizedBox(
                        child: _Logo(_animation),
                        height: context.height / 3,
                      ),
                      const CircularLoader(),
                      const Padding(
                        padding: EdgeInsets.all(24),
                        child: Text(
                          "Please wait while the page loads...",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : _Logo(_animation));
    });
  }
}

class _Logo extends StatelessWidget {
  const _Logo(this.animation, {Key? key}) : super(key: key);

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FadeTransition(
        opacity: animation,
        child: Center(
          child: Image.asset(
            "assets/logo.jpg",
            height: context.height / 2,
          ),
        ),
      ),
    );
  }
}
