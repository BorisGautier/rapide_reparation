import 'package:flutter/material.dart';
import 'package:rapide_achat/register_screen.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.connectType}) : super(key: key);

  final String connectType;
  @override
  _RegisterPageState createState() => new _RegisterPageState(connectType);
}

class _RegisterPageState extends State<RegisterPage> {
   _RegisterPageState(this.connectType);
  final String connectType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: RegisterScreen(connectType: connectType),
        ),
    );
  }
}