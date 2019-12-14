import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rapide_achat/accueil.dart';
import 'package:rapide_achat/api/api.dart';
import 'package:rapide_achat/home.dart';
import 'package:rapide_achat/models/response.dart';
import 'package:rapide_achat/models/vivawallet.dart';
import 'package:rapide_achat/paypal.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

final List<String> itemList = [
  'assets/images/11.jpg',
  'assets/images/12.jpg',
  'assets/images/13.jpg',
  'assets/images/14.jpg',
  'assets/images/15.jpeg'
];

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class StripePage extends StatefulWidget {
  StripePage(
      {Key key,
      this.appareil,
      this.modele,
      this.probleme,
      this.ecran,
      this.pb,
      this.rdv,
      this.date,
      this.societe,
      this.prix,
      this.adresse,
      this.code,
      this.etage,
      this.infos})
      : super(key: key);

  final String appareil,
      modele,
      probleme,
      ecran,
      pb,
      rdv,
      date,
      societe,
      prix,
      adresse,
      code,
      etage,
      infos;
  @override
  _StripePageState createState() => new _StripePageState(
      appareil,
      modele,
      probleme,
      ecran,
      pb,
      rdv,
      date,
      societe,
      prix,
      adresse,
      code,
      etage,
      infos);
}

class _StripePageState extends State<StripePage> {
  ApiRest api = new ApiRest();
  bool _isLoading = false;
  bool _isLoading1 = false;
  final String _simpleValue1 = 'logout';
  String _simpleValue;

  @override
  initState() {
    super.initState();

    // StripeSource.setPublishableKey("pk_test_yAUuyJ1BIf8WVbFOhiIX1etV");
  }

  _StripePageState(
      this.appareil,
      this.modele,
      this.probleme,
      this.ecran,
      this.pb,
      this.rdv,
      this.date,
      this.societe,
      this.prix,
      this.adresse,
      this.code,
      this.etage,
      this.infos);
  String appareil,
      modele,
      probleme,
      ecran,
      pb,
      rdv,
      date,
      societe,
      prix,
      adresse,
      code,
      etage,
      infos;
  @override
  Widget build(BuildContext context) {
    logout() async {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen()), //MaterialPageRoute
      );
    }

    void showMenuSelection(String value) async {
      if (<String>[_simpleValue1].contains(value)) _simpleValue = value;

      // Navigator.pushNamed(_context,"/$_simpleValue");
      if (value == "logout") {
        logout();
      } else {}
    }

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
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
        body: ListView(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(vertical: 01.0),
                child: Column(children: [
                  autoPlayDemo,
                  new Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.10), BlendMode.dstATop),
                        image: AssetImage('assets/images/15.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: new Column(
                      children: <Widget>[
                        Divider(
                          color: Colors.transparent,
                          height: 40,
                        ),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          child: Center(
                            child: Image.asset(
                              "assets/images/icon/rr.jpg",
                              height: 80,
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.transparent,
                          height: 35,
                        ),
                        Text(
                          "Votre compte sera débité",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[900],
                          ),
                        ),
                        Center(
                          heightFactor: 3,
                          child: new SizedBox(
                            width: 200,
                            child: new RaisedButton(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                              color: Colors.red[900],
                              onPressed: () {
                                vivaWallet();
                                /*  print("Ready: ${StripeSource.ready}");
                                StripeSource.addSource().then((String token) {
                                  if (token != null) {
                                    _sendOnline(token);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Echec de l'ajout de la carte",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIos: 1,
                                        backgroundColor: Colors.green[400],
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                });*/
                              },
                              child: _isLoading
                                  ? new CircularProgressIndicator(
                                      backgroundColor: Colors.white)
                                  : new Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 20.0,
                                        horizontal: 20.0,
                                      ),
                                      child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Expanded(
                                            child: Text(
                                              "Passer au paiement",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        /*  Center(
                          child: new SizedBox(
                            width: 200,
                            child: new RaisedButton(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                              color: Colors.red[900],
                              onPressed: () async {
                                setState(() => _isLoading1 = true);
                                payPal();
                              },
                              child: _isLoading1
                                  ? new CircularProgressIndicator(
                                      backgroundColor: Colors.white)
                                  : new Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 20.0,
                                        horizontal: 20.0,
                                      ),
                                      child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Expanded(
                                            child: Text(
                                              "Payer avec PayPal",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ])),
          ],
        ),
      ),
    );
  }

  final CarouselSlider autoPlayDemo = CarouselSlider(
    viewportFraction: 1.0,
    aspectRatio: 2.0,
    autoPlay: true,
    autoPlayInterval: Duration(seconds: 3),
    enlargeCenterPage: false,
    height: 200.0,
    items: map<Widget>(
      itemList,
      (index, i) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(i), fit: BoxFit.cover),
          ),
        );
      },
    ),
  );

  _sendOnline(String token) async {
    setState(() => _isLoading = true);

    print(token);
    final FirebaseUser currentUser = await _auth.currentUser();

    setState(() {
      if (currentUser != null) {
        api.stripe(token, currentUser.email, prix).then((Response response) {
          if (response.status == "success") {
            api
                .reservation(appareil, currentUser.email, modele, probleme, rdv,
                    date, "token", societe, adresse, code, etage, infos)
                .then((Response response) {
              if (response.status == "success") {
                setState(() => _isLoading = false);
                Fluttertoast.showToast(
                    msg: "Demande envoyée et Paiement confirmé",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.green[400],
                    textColor: Colors.white,
                    fontSize: 16.0);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccueilPage(),
                  ),
                );
              }
            });
          } else {
            setState(() => _isLoading = false);
            Fluttertoast.showToast(
                msg: "Erreur lors du paiement",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.red[400],
                textColor: Colors.white,
                fontSize: 16.0);
          }
        });
      }
    });
  }

  payPal() async {
    final FirebaseUser currentUser = await _auth.currentUser();
    api.getPaypal(prix, probleme).then((Response response) {
      if (response.status != "failed") {
        setState(() => _isLoading1 = false);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PayPalPage(url: response.status),
          ),
        );
      } else {
        setState(() => _isLoading1 = false);
        Fluttertoast.showToast(
            msg: "Erreur lors du paiement",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.red[400],
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  vivaWallet() async {
    setState(() => _isLoading = true);
    final FirebaseUser currentUser = await _auth.currentUser();
    double p = double.parse(prix);
    double pf = p * 100;

    int pr = pf.toInt();

    Firestore.instance.collection('reservations').document().setData({
      'appareil': appareil,
      'email': currentUser.email,
      'modele': modele,
      'probleme': probleme,
      'rdv': rdv,
      'date': date,
      'societe': societe,
      'adresse': adresse,
      'code': code,
      'etage': etage,
      'infos': infos
    });

    api
        .reservation(appareil, currentUser.email, modele, probleme, rdv, date,
            "token", societe, adresse, code, etage, infos)
        .then((Response response) {
      if (response.status == "success") {}
    });

    api
        .getVivawallet("Rapide réparation", currentUser.email, pr, modele)
        .then((VivaWallet response) {
      if (response.errorCode == 0) {
        setState(() => _isLoading = false);
        int code = response.orderCode;
        print(code);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PayPalPage(
                url: "https://www.vivapayments.com/web/checkout?ref=$code"),
          ),
        );
      } else {
        setState(() => _isLoading = false);
        Fluttertoast.showToast(
            msg: "Erreur lors du paiement",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.red[400],
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

}
