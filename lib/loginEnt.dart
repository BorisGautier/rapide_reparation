import 'package:flutter/material.dart';
import 'package:rapide_achat/login_screen_4.dart';

class LoginENT extends StatefulWidget {
  @override
  _LoginENTState createState() => new _LoginENTState();
}

class _LoginENTState extends State<LoginENT> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: LoginScreen4(),
      ),
    );
  }
}
