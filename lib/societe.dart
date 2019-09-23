import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rapide_achat/api/api.dart';
import 'package:rapide_achat/detail.dart';
import 'package:rapide_achat/detail1.dart';
import 'package:rapide_achat/home.dart';
import 'package:rapide_achat/models/distance.dart';
import 'package:rapide_achat/models/societeResponse.dart';
import 'package:rapide_achat/technicien.dart';

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

class SocietePage extends StatefulWidget {
  SocietePage(
      {Key key,
      this.appareil,
      this.modele,
      this.probleme,
      this.ecran,
      this.pb,
      this.rdv,
      this.date,
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
      prix,
      adresse,
      code,
      etage,
      infos;
  @override
  _SocietePage createState() => _SocietePage(appareil, modele, probleme, ecran,
      pb, rdv, date, prix, adresse, code, etage, infos);
}

class _SocietePage extends State<SocietePage> {
  _SocietePage(
      this.appareil,
      this.modele,
      this.probleme,
      this.ecran,
      this.pb,
      this.rdv,
      this.date,
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
      societe,
      rdv,
      date,
      prix,
      adresse,
      code,
      etage,
      infos;
  double long = 5.00000, lat = 5.00000, longd, latd;
  final String _simpleValue1 = 'logout';
  String _simpleValue;
  var societeF = new List<Societe>();
  Timer timer;
  bool _isLoading = false;
  ApiRest api = new ApiRest();
  bool a = false;
  double dist;
  int pri;
  String b;

  Future getSociete() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    long = position.longitude;
    lat = position.latitude;

    String lo = format(long);
    String la = format(lat);

    api.getSociete("Rapide Achat").then((SocieteResponse societeresponse) {
      setState(() async {
        if (societeresponse.status == "success") {
          societeF = societeresponse.societe;
          //  await getD(lo,la);

        }
      });
    });
  }

  @override
  void initState() {
    setState(() => _isLoading = true);
    super.initState();
    Timer(new Duration(milliseconds: 1500), () async {
      await getSociete();

      setState(() => _isLoading = false);
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 4);
  }

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

    return Scaffold(
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
          : ListView.builder(
              itemCount: societeF.length,
              itemBuilder: (context, index) {
                void eventDetail() async {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(
                            appareil: appareil,
                            ecran: ecran,
                            modele: modele,
                            pb: pb,
                            probleme: probleme,
                            societe: societeF[index].nom,
                            rdv: rdv,
                            date: date,
                            prix: prix,
                            adresse: adresse,
                            code: code,
                            etage: etage,
                            infos: infos
                            // b: b,
                            )), //MaterialPageRoute
                  );
                }

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.10), BlendMode.dstATop),
                      image: AssetImage('assets/images/12.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      autoPlayDemo,
                      Divider(color: Colors.transparent, height: 20),
                      Text(
                        "Entreprise pour réparation à domicile",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red[900],
                          fontSize: 15,
                        ),
                      ),
                      Divider(color: Colors.transparent, height: 40),
                      Card(
                        elevation: 5.0,
                        child: ListTile(
                          title: Text(
                            societeF[index].nom,
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: eventDetail,
                        ),
                      ),
                    ],
                  ),
                );
              }),
      /* Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.10), BlendMode.dstATop),
            image: AssetImage('assets/images/12.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 01.0),
              child: new Column(
                children: <Widget>[
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
                        Container(
                          padding: EdgeInsets.all(20.0),
                          child: Center(
                            child: Image.asset(
                              "assets/images/icon/icon.png",
                            ),
                          ),
                        ),
                        Text(
                          "Entreprise de réparation",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red[900],
                            fontSize: 15,
                          ),
                        ),
                        Divider(color: Colors.transparent),
                        new Expanded(
                          child: ListView.builder(
                                itemCount: societeF.length,
                                itemBuilder: (context, index) {
                                  void eventDetail() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailPage(
                                                appareil: appareil,
                                                ecran: ecran,
                                                modele: modele,
                                                pb: pb,
                                                probleme: probleme,
                                                societe: societeF[index].nom,
                                                rdv: rdv,
                                                date: date,

                                              )), //MaterialPageRoute
                                    );
                                  }

                                  return Card(
                                    elevation: 5.0,
                                    child: ListTile(
                                      title: Text(
                                        societeF[index].nom,
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onTap: eventDetail,
                                    ),
                                  );
                                }
                                ),
                        ),
                       
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),*/
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
