import 'package:flutter/material.dart';
import 'package:flutter_web_dashbooard_layout/extensions/context.dart';

import '../layouts/main.dart';

class DashboardHome extends StatelessWidget {
  const DashboardHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      title: 'Dashboard',
      child: SizedBox(
        width: context.width * (3.6 / 5),
        height: context.height * (5 / 7),
      ),
    );
  }
}
