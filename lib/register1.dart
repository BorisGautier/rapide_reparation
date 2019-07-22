import 'package:flutter/material.dart';
import 'package:rapide_achat/register_screen1.dart';

class RegisterPage1 extends StatefulWidget {
  RegisterPage1({Key key, this.connectType}) : super(key: key);

  final String connectType;
  @override
  _RegisterPageState1 createState() => new _RegisterPageState1(connectType);
}

class _RegisterPageState1 extends State<RegisterPage1> {
   _RegisterPageState1(this.connectType);
  final String connectType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: RegisterScreen1(connectType: connectType),
        ),
    );
  }
}