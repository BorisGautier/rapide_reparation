import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rapide_achat/home.dart';
import 'package:rapide_achat/ordi.dart';
import 'package:rapide_achat/tablette.dart';
import 'package:rapide_achat/telephone.dart';

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

class ChoixPage extends StatefulWidget {
  @override
  _ChoixPage createState() => _ChoixPage();
}

class _ChoixPage extends State<ChoixPage> {
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

    /* toast() {
        Fluttertoast.showToast(
                    msg: "Bientot disponible",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.green[400],
                    textColor: Colors.white,
                    fontSize: 16.0);
    }*/

    goTomodele(int i) {
      if (i == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => TelephonePage()), //MaterialPageRoute
        );
      } else if (i == 2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => OrdiPage()), //MaterialPageRoute
        );
      } else if (i == 3) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => TablettePage()), //MaterialPageRoute
        );
      }
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
                      image: AssetImage('assets/images/14.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: new Column(
                    children: <Widget>[
                      Divider(color: Colors.transparent, height: 20),
                      Container(
                        padding: EdgeInsets.all(0.0),
                        child: Center(
                            child: Text("ETAPE 1/3",
                                style: TextStyle(
                                    color: Colors.red[900],
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center)),
                      ),
                      Container(
                        padding: EdgeInsets.all(05.0),
                        child: Center(
                            child: Text(
                                "Quel appareil souhaitez-vous réparer ?",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic, fontSize: 15),
                                textAlign: TextAlign.center)),
                      ),
                      Divider(color: Colors.transparent, height: 15),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {},
                                  child: ClipOval(
                                    child: Container(
                                      color: Colors.transparent,
                                      height: 120.0, // height of the button
                                      width: 120.0, // width of the button
                                      child: Center(
                                          child: Material(
                                        elevation: 4.0,
                                        shape: CircleBorder(),
                                        color: Colors.white,
                                        child: Ink.image(
                                          image: AssetImage(
                                              'assets/images/smartphone.jpg'),
                                          fit: BoxFit.contain,
                                          width: 120.0,
                                          height: 120.0,
                                          child: InkWell(
                                            onTap: () {
                                              goTomodele(1);
                                            },
                                            child: null,
                                          ),
                                        ),
                                      )),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                Column(
                                  children: <Widget>[
                                    Text("Smartphone"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {},
                                  child: ClipOval(
                                    child: Container(
                                      color: Colors.transparent,
                                      height: 120.0, // height of the button
                                      width: 120.0, // width of the button
                                      child: Center(
                                          child: Material(
                                        elevation: 4.0,
                                        shape: CircleBorder(),
                                        color: Colors.white,
                                        child: Ink.image(
                                          image: AssetImage(
                                              'assets/images/ordi.jpg'),
                                          fit: BoxFit.contain,
                                          width: 120.0,
                                          height: 120.0,
                                          child: InkWell(
                                            onTap: () {
                                              goTomodele(2);
                                              //toast();
                                            },
                                            child: null,
                                          ),
                                        ),
                                      )),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                Column(
                                  children: <Widget>[
                                    Text("Ordinateurs"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {},
                                  child: ClipOval(
                                    child: Container(
                                      color: Colors.transparent,
                                      height: 120.0, // height of the button
                                      width: 120.0, // width of the button
                                      child: Center(
                                          child: Material(
                                        elevation: 4.0,
                                        shape: CircleBorder(),
                                        color: Colors.white,
                                        child: Ink.image(
                                          image: AssetImage(
                                              'assets/images/tab.jpg'),
                                          fit: BoxFit.contain,
                                          width: 120.0,
                                          height: 120.0,
                                          child: InkWell(
                                            onTap: () {
                                              goTomodele(3);
                                              //toast();
                                            },
                                            child: null,
                                          ),
                                        ),
                                      )),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                Column(
                                  children: <Widget>[
                                    Text("Tablettes"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
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
