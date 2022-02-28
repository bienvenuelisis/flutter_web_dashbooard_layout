import 'package:flutter/material.dart';

import '../widgets/components.dart';
import 'dashboard.dart';

const greenColor = Color(0xFF6bab58);

const secondaryColor = Color(0xFF292929);

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
    required this.title,
    this.redirectTo,
  }) : super(key: key);

  final String title;

  final String? redirectTo;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> with SingleTickerProviderStateMixin {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width / 4),
        height: size.height,
        width: size.width,
        child: Center(
          child: Card(
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.all(42),
              width: size.width / 3.6,
              height: size.height / 1.1,
              child: Column(
                children: <Widget>[
                  Image.asset(
                    "assets/logo.jpg",
                    height: size.height * 0.15,
                  ),
                  const SizedBox(height: 24.0),
                  SizedBox(
                    width: double.infinity,
                    child: Form(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            InputWidget(
                              keyboardType: TextInputType.phone,
                              kController: _emailController,
                              topLabel: "Your email address",
                              hintText: "agbavonbienvenu@gmail.com",
                            ),
                            const SizedBox(height: 8.0),
                            InputWidget(
                              topLabel: "Your password",
                              obscureText: true,
                              hintText: "********",
                              kController: _passwordController,
                              onSaved: (String? uPassword) {},
                              onChanged: (String? value) {},
                              validator: (String? value) {
                                return null;
                              },
                            ),
                            const SizedBox(height: 24.0),
                            AppButton(
                              type: ButtonType.PRIMARY,
                              text: "Log in",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const DashboardHome(),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 24.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                      value: isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isChecked = value ?? false;
                                        });
                                      },
                                    ),
                                    const Text("Restez connecté"),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 24.0),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "I have forgotten the password",
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(color: greenColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
