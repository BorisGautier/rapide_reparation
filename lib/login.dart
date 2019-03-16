import 'package:flutter/material.dart';
import 'package:rapide_achat/login_screen_3.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: LoginScreen3(),
        ),
    );
  }
}