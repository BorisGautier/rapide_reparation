import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rapide_achat/api/api.dart';
import 'package:rapide_achat/login.dart';
import 'package:rapide_achat/stripe.dart';

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

class Detail1Page extends StatefulWidget {
  Detail1Page(
      {Key key,
      this.appareil,
      this.modele,
      this.probleme,
      this.ecran,
      this.pb,
      this.rdv,
      this.date,
      this.societe,
      this.prix})
      : super(key: key);

  final String appareil, modele, probleme, ecran, pb, rdv, date, societe, prix;
  @override
  _Detail1Page createState() => _Detail1Page(
      appareil, modele, probleme, ecran, pb, rdv, date, societe, prix);
}

class _Detail1Page extends State<Detail1Page> {
  _Detail1Page(this.appareil, this.modele, this.probleme, this.ecran, this.pb,
      this.rdv, this.date, this.societe, this.prix);
  String appareil, modele, probleme, ecran, pb, rdv, date, societe, prix;
  final String _simpleValue1 = 'logout';
  String simpleValue, email, r, t;
  bool e, p, m = false;
  bool rd = false;
  Timer timer;
  bool _isLoading = false;
  bool _isLoading1 = false;
  ApiRest api = new ApiRest();
  String d;
  int pri;
  double pr = 0;
  DateTime day;
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    setState(() => _isLoading = true);
    day = DateTime.parse(date);
    Timer(new Duration(milliseconds: 1500), () async {
      user = await _auth.currentUser();
      email = user.email;
      if (modele == null) {
        modele = "";
        m = true;
      }
      if (probleme == null) {
        p = true;
      } else {
        p = false;
        if (ecran == null) {
          e = true;
        } else {
          e = false;
        }
      }
      if (rdv == "domicile") {
        r = "Technicien à domicile";
        rd = true;
      } else {
        r = "Rendez-vous à la boutique";
        rd = false;
      }
      double p1 = (pr*20)/100;
      pr = double.parse(prix) + 20 + p1;
      setState(() => _isLoading = false);
    });
  }

  confirmer() {
    setState(() => _isLoading1 = true);
    if (rdv == "domicile") {
      setState(() => _isLoading1 = false);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => StripePage(
            appareil: appareil,
            date: date,
            ecran: ecran,
            modele: modele,
            pb: pb,
            probleme: probleme,
            rdv: rdv,
            societe: societe,
            prix: prix,
            user: user,
          ),
        ),
      );
    } else {
      setState(() => _isLoading1 = false);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => StripePage(
            appareil: appareil,
            date: date,
            adresse: "",
            code: "",
            etage: "",
            infos: "",
            ecran: ecran,
            modele: modele,
            pb: pb,
            probleme: probleme,
            rdv: rdv,
            societe: societe,
            prix: pr.toString(),
            user: user,
          ),
        ),
      );

      /*   setState(() {
        api.reservation(appareil, email, modele, probleme, rdv, date, "token",societe,"Rapide achat","","","").then((Response response){
          if (response.status == "success") {
            setState(() => _isLoading1 = false);
             Fluttertoast.showToast(
                msg: "Demande de réparation envoyée",
                toastLength: Toast.LENGTH_SHORT,
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
      });*/
    }
  }

/*  getEmail() async {
    FirebaseUser user = await  _auth.currentUser();
    if (user != null) {
      email = user.email;
    }
    else{
      email = "boris@gautier.com";
    }
      
       
}*/

  @override
  Widget build(BuildContext context) {
    logout() async {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage()), //MaterialPageRoute
      );
    }

    void showMenuSelection(String value) async {
      if (<String>[_simpleValue1].contains(value)) simpleValue = value;

      // Navigator.pushNamed(_context,"/$_simpleValue");
      if (value == "logout") {
        logout();
      } else {}
    }

    return new Scaffold(
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
      body: _isLoading
          ? Center(child: new CircularProgressIndicator())
          : ListView(
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
                                Colors.black.withOpacity(0.10),
                                BlendMode.dstATop),
                            image: AssetImage('assets/images/15.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: new Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(20.0),
                              child: Center(
                                child: Image.asset(
                                  "assets/images/icon/rr.jpg",
                                  height: 80,
                                ),
                              ),
                            ),
                            Text(
                              "Récapitulatif de votre demande de réparation",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red[900],
                                fontSize: 15,
                              ),
                            ),
                            Divider(color: Colors.transparent, height: 15),
                            Container(
                                // height: MediaQuery.of(context).size.height,
                                child: Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Table(
                                      border: TableBorder.all(
                                          width: 1.0, color: Colors.black),
                                      children: [
                                        TableRow(children: [
                                          TableCell(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                new Text(" " + 'Adresse Mail'),
                                              ],
                                            ),
                                          ),
                                          TableCell(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                new Text(" " + email),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                new Text(" " + 'Appareil'),
                                              ],
                                            ),
                                          ),
                                          TableCell(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                m
                                                    ? new Text(" " + appareil)
                                                    : new Text(" " +
                                                        appareil +
                                                        " " +
                                                        modele),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                new Text(" " + 'Problème'),
                                              ],
                                            ),
                                          ),
                                          TableCell(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                p
                                                    ? Text(" " +
                                                        "PROBLEME AVEC VOTRE :" +
                                                        " " +
                                                        appareil)
                                                    : e
                                                        ? new Text(
                                                            " " + probleme)
                                                        : new Text(" " +
                                                            probleme +
                                                            " " +
                                                            ":" +
                                                            " " +
                                                            ecran),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                new Text(" " + 'Rendez-vous'),
                                              ],
                                            ),
                                          ),
                                          TableCell(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                new Text(" " + r),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                new Text(
                                                    " " + 'Date Rendez-vous'),
                                              ],
                                            ),
                                          ),
                                          TableCell(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                new Text(" " +
                                                    day.day.toString() +
                                                    "-" +
                                                    day.month.toString() +
                                                    "-" +
                                                    day.year.toString() +
                                                    " à " +
                                                    day.hour.toString() +
                                                    ":" +
                                                    day.minute.toString()),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                new Text(
                                                  " " + 'Prix de la pièce',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red[900],
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          TableCell(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                new Text(
                                                  " " + prix + "€",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red[900],
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                new Text(
                                                  " " + 'Main d\'oeuvre',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red[900],
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          TableCell(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                new Text(
                                                  " " + "20" + "€",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red[900],
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                new Text(
                                                  " " + 'Prix total',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red[900],
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          TableCell(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                new Text(
                                                  " " + pr.toString() + "€",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red[900],
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ))),

                            /*             Text("VOTRE ADRESSE EMAIL :"+" "+email,textAlign: TextAlign.center),
                      Divider(color: Colors.transparent,height: 15),
              m ? Text("VOTRE APPAREIL :"+" "+appareil,textAlign: TextAlign.center) : Text("VOTRE APPAREIL :"+" "+appareil+" "+"modèle"+" "+modele,textAlign: TextAlign.center),
                      Divider(color: Colors.transparent,height: 15),
                p ? Text("VOUS RENCONTREZ UN PROBLEME AVEC VOTRE :"+" "+appareil,textAlign: TextAlign.center) : e ?Text("VOTRE PROBLEME :"+" "+probleme,textAlign: TextAlign.center) : Text("VOTRE PROBLEME :"+" "+probleme+" "+":"+" "+ecran,textAlign: TextAlign.center),
                   Divider(color: Colors.transparent,height: 15),
                   Text("VOUS AVEZ CHOISI D'AVOIR UN :"+" "+r,textAlign: TextAlign.center),
                   Divider(color: Colors.transparent,height: 15),
                   Text("RENDEZ-VOUS PRIS POUR LE :"+" "+date,textAlign: TextAlign.center),
                   Divider(color: Colors.transparent,height: 25),
          rd ? Text("NB: l'assistance à domicile vous coutera "+pri.toString()+"€",style: TextStyle(fontStyle: FontStyle.italic,color: Colors.red[900]),) : Divider(color: Colors.transparent,height: 5),
                   */

                            Center(
                              heightFactor: 1.5,
                              child: new FlatButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                color: Colors.red[900],
                                onPressed: confirmer,
                                child: _isLoading1
                                    ? new CircularProgressIndicator()
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
                                                "CONFIRMER",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                    ])),
              ],
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
}
