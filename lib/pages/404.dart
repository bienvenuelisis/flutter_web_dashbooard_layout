import 'package:flutter/material.dart';

import '../layouts/main.dart';

class Page404 extends StatelessWidget {
  const Page404({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      title: 'Page not found',
      child: const Center(
        child: Text(
          '404',
          style: TextStyle(
            fontSize: 100,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
