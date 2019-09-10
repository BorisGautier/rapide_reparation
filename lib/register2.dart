import 'package:flutter/material.dart';
import 'package:rapide_achat/register_screen2.dart';

class RegisterPage2 extends StatefulWidget {
  RegisterPage2({Key key, this.ent}) : super(key: key);

  final String ent;
  @override
  _RegisterPageState2 createState() => new _RegisterPageState2(ent);
}

class _RegisterPageState2 extends State<RegisterPage2> {
   _RegisterPageState2(this.ent);
  final String ent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: RegisterScreen2(ent: ent),
        ),
    );
  }
}