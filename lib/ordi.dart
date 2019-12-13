import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rapide_achat/choix.dart';
import 'package:rapide_achat/home.dart';
import 'package:rapide_achat/phoneList.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

List imac = [""];

List lenovo = [""];

List toshiba = [""];

List hp = [""];

List<DropdownMenuItem<String>> _dropDownMenuItems;
String _currentModele;

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

class OrdiPage extends StatefulWidget {
  @override
  _OrdiPage createState() => _OrdiPage();
}

class _OrdiPage extends State<OrdiPage> {
  final String _simpleValue1 = 'logout';
  String _simpleValue;
  String modele, val;
  bool a = false;
  bool bu = false;

  bool i = false, h = false, ht = false, b = false, s = false;

  static final PRODUIT_URL =
      "https://www.rapide-achat.com/wp-json/public-woo/v1/products";

  @override
  void initState() {
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    if (val == "405") {
      for (String mod in imac) {
        // here we are creating the drop down menu items, you can customize the item right here
        // but I'll just use a simple text for this
        items.add(new DropdownMenuItem(value: mod, child: new Text(mod)));
      }
      return items;
    } else if (val == "411") {
      for (String mod in lenovo) {
        // here we are creating the drop down menu items, you can customize the item right here
        // but I'll just use a simple text for this
        items.add(new DropdownMenuItem(value: mod, child: new Text(mod)));
      }
      return items;
    } else if (val == "404") {
      for (String mod in toshiba) {
        // here we are creating the drop down menu items, you can customize the item right here
        // but I'll just use a simple text for this
        items.add(new DropdownMenuItem(value: mod, child: new Text(mod)));
      }
      return items;
    } else if (val == "403") {
      for (String mod in hp) {
        // here we are creating the drop down menu items, you can customize the item right here
        // but I'll just use a simple text for this
        items.add(new DropdownMenuItem(value: mod, child: new Text(mod)));
      }
      return items;
    }
  }

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
      MaterialPageRoute(builder: (context) => HomeScreen()), //MaterialPageRoute
    );
  }

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              children: [
                autoPlayDemo,
                new Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.10), BlendMode.dstATop),
                      image: AssetImage('assets/images/12.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: new Column(
                    children: <Widget>[
                      Divider(
                        color: Colors.transparent,
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: IconButton(
                                  icon: new Icon(
                                    Icons.backspace,
                                    color: Colors.red[900],
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChoixPage()), //MaterialPageRoute
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 63.0),
                          ),
                          Text("ETAPE 2/3",
                              style: TextStyle(
                                  color: Colors.red[900],
                                  fontStyle: FontStyle.italic,
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ],
                      ),
                      Divider(
                        color: Colors.transparent,
                        height: 50,
                      ),
                      Text("Marque de votre Ordinateur",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold)),
                      DropdownButton<String>(
                        items: [
                          DropdownMenuItem<String>(
                            value: "403",
                            child: Text(
                              "HP",
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: "405",
                            child: Text(
                              "Toshiba",
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: "404",
                            child: Text(
                              "Imac",
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: "411",
                            child: Text(
                              "Lenovo",
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            val = value;

                            if (value == "403") {
                              _dropDownMenuItems = getDropDownMenuItems();
                              setState(() => i = true);
                            }
                            if (value == "404") {
                              _dropDownMenuItems = getDropDownMenuItems();
                              setState(() => i = true);
                            }

                            if (value == "405") {
                              _dropDownMenuItems = getDropDownMenuItems();
                              setState(() => i = true);
                            }

                            if (value == "411") {
                              _dropDownMenuItems = getDropDownMenuItems();
                              setState(() => i = true);
                            }
                          });
                        },
                        value: val,
                        hint: Text(
                          "Selectionnez votre marque",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      Text("Modèle de votre Ordinateur",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold)),
                      i
                          ? DropdownButton(
                              elevation: 5,
                              value: _currentModele,
                              items: _dropDownMenuItems,
                              onChanged: changedDropDownItem,
                              hint: Text(
                                "Selectionnez votre modèle",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            )
                          : Divider(color: Colors.transparent),
                      Center(
                        heightFactor: 2,
                        child: new SizedBox(
                          width: 200,
                          child: new RaisedButton(
                            elevation: 10,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            color: Colors.red[900],
                            onPressed: () => bu
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PhoneListPage(
                                              value: modele,
                                              page: 1,
                                            )), //MaterialPageRoute
                                  )
                                : Fluttertoast.showToast(
                                    msg: "Choisissez un modèle",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIos: 1,
                                    backgroundColor: Colors.red[400],
                                    textColor: Colors.white,
                                    fontSize: 16.0),
                            child: new Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20.0,
                                horizontal: 20.0,
                              ),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Expanded(
                                    child: Text(
                                      "SUIVANT",
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void changedDropDownItem(String selectModele) {
    setState(() {
      _currentModele = selectModele;

      if (val == "403") {
        modele = _currentModele;
        bu = true;
      } else if (val == "404") {
        modele = _currentModele;
        bu = true;
      } else if (val == "405") {
        modele = _currentModele;
        bu = true;
      } else if (val == "411") {
        modele = _currentModele;
        bu = true;
      }
    });
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