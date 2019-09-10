import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rapide_achat/api/api.dart';
import 'package:rapide_achat/choix.dart';
import 'package:rapide_achat/home.dart';
import 'package:rapide_achat/login.dart';
import 'package:rapide_achat/models/reservationResponse.dart';
import 'package:rapide_achat/models/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class AccueilProPage extends StatefulWidget {
  @override
  _AccueilProPage createState() => _AccueilProPage();
}

class _AccueilProPage extends State<AccueilProPage> {
  var reservationF = new List<Reservation>();
  Timer timer;
  bool _isLoading = false;
  ApiRest api = new ApiRest();

 Future _getReservation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ent = (prefs.getString('ent'));

    api.getReseration("Rapide Réparation").then((ReservationResponse reservationresponse) {
      setState(() {
        if (reservationresponse.status == "success") {
          
               
          reservationF = reservationresponse.reservation;
          
            setState(() => _isLoading = false);
          
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    timer =Timer(new Duration(milliseconds: 3000), ()  {
      setState(() => _isLoading = true);
         _getReservation();
    });
    
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  final String _simpleValue1 = 'logout';
  String _simpleValue;
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

    return new Scaffold(
      appBar: AppBar(
        leading: new Container(
          child: Image.asset('assets/images/icon/rr.jpg'),
        ),
        title: Text("Liste des demandes de réparation"),
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
      body: _isLoading ? Center(child:new CircularProgressIndicator()) : ListView.builder(
       itemCount: reservationF.length,
                                itemBuilder: (context, index) {

                                  confirme(String id) {
                                    // String id = reservationF[index].id;
                                    api.confirmer(id).then((Response response) {
                                      setState(() {
                                        if (response.status == "success") {
                                          Fluttertoast.showToast(
                                              msg: "validée",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIos: 1,
                                              backgroundColor: Colors.blue,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                      });
                                    });
                                  }
          return  Card(
                                    elevation: 5.0,
                                    child: ListTile(
                                      title: Text(
                                        reservationF[index].modele,
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle:Text(
                                       "problème: "+reservationF[index].probleme+" "+"Date de la reservation: "+reservationF[index].date,
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,),
                                      ) ,
                                   
                                      
                                    ),
                                    );
                                
          
        },
      ),
    /*  ListView.builder(
                                itemCount: reservationF.length,
                                itemBuilder: (context, index) {

                                  confirmer(String id) {
                                    // String id = reservationF[index].id;
                                    api.confirmer(id).then((Response response) {
                                      setState(() {
                                        if (response.status == "success") {
                                          Fluttertoast.showToast(
                                              msg: "Confirmation validée",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIos: 1,
                                              backgroundColor: Colors.blue,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                      });
                                    });
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
                                      Divider(color: Colors.transparent,height: 20),
                                         Text(
                          "Liste des reservations",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red[900],
                            fontSize: 15,
                          ),
                        ),
                        Divider(color: Colors.transparent,height: 40),
                                         Card(
                                    elevation: 5.0,
                                    child: ListTile(
                                      title: Text(
                                        reservationF[index].modele,
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold),
                                      ),
                                     onTap: () {
                                        Fluttertoast.showToast(
                                            msg: "Pressez long pour confirmer",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIos: 1,
                                            backgroundColor: Colors.blue,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      },
                                      onLongPress:
                                          confirmer(reservationF[index].id),
                                    ),
                                    ),
                                
                                    ],
                                  ),
                                );

                                 
                                }
      ),*/
      
      
      /*ListView(
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
                      ),
                      Text(
                        "Entreprise bien enregistrée",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red[900],
                        ),
                      ),
                      Divider(color: Colors.transparent),
                    /*  new Expanded(
                        child: _isLoading
                            ? new CircularProgressIndicator()
                            : new ListView.builder(
                                itemCount: reservationF.length,
                                itemBuilder: (context, index) {
                                  confirmer(String id) {
                                    // String id = reservationF[index].id;
                                    api.confirmer(id).then((Response response) {
                                      setState(() {
                                        if (response.status == "success") {
                                          Fluttertoast.showToast(
                                              msg: "Confirmation validée",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIos: 1,
                                              backgroundColor: Colors.blue,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                      });
                                    });
                                  }

                                  return Card(
                                    elevation: 5.0,
                                    child: ListTile(
                                      title: Text(
                                        reservationF[index].appareil,
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        reservationF[index].probleme,
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onTap: () {
                                        Fluttertoast.showToast(
                                            msg: "Pressez long pour confirmer",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIos: 1,
                                            backgroundColor: Colors.blue,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      },
                                      onLongPress:
                                          confirmer(reservationF[index].id),
                                    ),
                                  );
                                }),
                      ),*/
                    ],
                  ),
                ),
              ])),
        ],
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
