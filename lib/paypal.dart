import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:rapide_achat/home.dart';
import 'package:rapide_achat/login.dart';

class PayPalPage extends StatefulWidget {
  PayPalPage({Key key, this.url}) : super(key: key);
  final String url;
  @override
  _PayPalPage createState() => _PayPalPage(url);
}

class _PayPalPage extends State<PayPalPage> {
  _PayPalPage(this.url);
  String url;
  final String _simpleValue1 = 'logout';
  String _simpleValue;

  void showMenuSelection(String value) async {
    if (<String>[_simpleValue1].contains(value)) _simpleValue = value;

    // Navigator.pushNamed(_context,"/$_simpleValue");
    if (value == "logout") {
      logout();
    } else {}
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()), //MaterialPageRoute
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WebviewScaffold(
      url: url,
      appBar: AppBar(
        leading: new Container(
          child: Image.asset('assets/images/icon/rr.jpg'),
        ),
        title: Text("Rapide Réparation"),
        backgroundColor: Colors.red[900],
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: showMenuSelection,
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              const PopupMenuItem<String>(
                  value: 'logout', child: Text('Deconnexion')),
              /*  const PopupMenuItem<String>(
                      value: 'setting', child: Text('Paramètres')),*/
            ],
          )
        ],
      ),
      scrollBar: true,
      withJavascript: true,
      withZoom: true,
      hidden: true,
    );
  }
}
