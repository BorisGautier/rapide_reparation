import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rapide_achat/login.dart';
import 'package:rapide_achat/technicien.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

final List<String> itemList = [
  'assets/images/11.jpg',
  'assets/images/12.jpg',
  'assets/images/13.jpg',
  'assets/images/14.jpg',
  'assets/images/15.jpeg'
];

List _modelePhone = ["modele1", "modele2", "modele3", "modele4", "modele5"];

List _modeleOrdi = ["modele11", "modele22", "modele33", "modele44", "modele55"];

List _modeleTab = [
  "modele111",
  "modele222",
  "modele333",
  "modele444",
  "modele555"
];

List _degat = ["Connecteur", "Ecran cassé"];

List<DropdownMenuItem<String>> _dropDownMenuItems, _dropPb;
String _currentModele, _currentProbleme;

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class ModelePage extends StatefulWidget {
  ModelePage({Key key, this.appareil}) : super(key: key);

  final String appareil;
  @override
  _ModelePage createState() => _ModelePage(appareil);
}

class _ModelePage extends State<ModelePage> {
  _ModelePage(this.appareil);
  final String appareil;
  final String _simpleValue1 = 'logout';
  String _simpleValue;
  String modele, probleme, ecran;
  bool blanc = false;
  bool noir = false;
  bool c = false;

  List<DropdownMenuItem<String>> getDropDownMenuItemsProbleme() {
    List<DropdownMenuItem<String>> items = new List();

    for (String mod in _degat) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(value: mod, child: new Text(mod)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    if (appareil == "telephone") {
      for (String mod in _modelePhone) {
        // here we are creating the drop down menu items, you can customize the item right here
        // but I'll just use a simple text for this
        items.add(new DropdownMenuItem(value: mod, child: new Text(mod)));
      }
      return items;
    } else if (appareil == "ordinateur") {
      for (String mod in _modeleOrdi) {
        // here we are creating the drop down menu items, you can customize the item right here
        // but I'll just use a simple text for this
        items.add(new DropdownMenuItem(value: mod, child: new Text(mod)));
      }
      return items;
    } else if (appareil == "tablette") {
      for (String mod in _modeleTab) {
        // here we are creating the drop down menu items, you can customize the item right here
        // but I'll just use a simple text for this
        items.add(new DropdownMenuItem(value: mod, child: new Text(mod)));
      }
      return items;
    }
  }

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentModele = _dropDownMenuItems[0].value;
    modele = _currentModele;
    _dropPb = getDropDownMenuItemsProbleme();
    _currentProbleme = _dropPb[0].value;
    probleme = _currentProbleme;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var row = new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Ecran blanc"),
            Checkbox(
              value: blanc,
              onChanged: (bool value) {
                setState(() {
                  blanc = value;
                  if (value == true) {
                    blanc = value;
                    noir = false;
                    ecran = "ecran blanc";
                  } else {
                    blanc = value;
                    ecran = null;
                  }
                });
              },
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Ecran noir"),
            Checkbox(
              value: noir,
              onChanged: (bool value) {
                setState(() {
                  if (value == true) {
                    blanc = false;
                    noir = value;
                    ecran = "ecran noir";
                  } else {
                    noir = value;
                    ecran = null;
                  }
                });
              },
            ),
          ],
        ),
      ],
    );

    logout() async {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage()), //MaterialPageRoute
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
          child: Image.asset('assets/images/icon/icon.png'),
        ),
        title: Text("Rapide Achat"),
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
                    Text("ETAPE 2/3",
                        style: TextStyle(
                            color: Colors.red[900],
                            fontStyle: FontStyle.italic,
                            fontSize: 27,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    Divider(
                      color: Colors.transparent,
                      height: 10,
                    ),
                    Container(
                      child: Text(
                          "Choississez le modèle de votre" + " " + appareil,
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold)),
                    ),
                    Divider(
                      color: Colors.transparent,
                      height: 10,
                    ),
                    DropdownButton(
                      elevation: 5,
                      value: _currentModele,
                      items: _dropDownMenuItems,
                      onChanged: changedDropDownItem,
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    Text("Quel est votre problème?",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold)),
                    Divider(
                      color: Colors.transparent,
                    ),
                    DropdownButton(
                      elevation: 5,
                      value: _currentProbleme,
                      items: _dropPb,
                      onChanged: changedDropDownItemProbleme,
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    c ? row : Divider(color: Colors.transparent),
                    Center(
                      heightFactor: 2,
                      child: new FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        color: Colors.red[900],
                        onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TechnicienPage(
                                      appareil: appareil,
                                      modele: modele,
                                      probleme: probleme,
                                      ecran: ecran)), //MaterialPageRoute
                            ),
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
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  void changedDropDownItem(String selectModele) {
    setState(() {
      _currentModele = selectModele;
      modele = _currentModele;
    });
  }

  void changedDropDownItemProbleme(String selectPb) {
    setState(() {
      _currentProbleme = selectPb;
      if (_currentProbleme == _dropPb[1].value) {
        c = true;
        probleme = _currentProbleme;
      } else if (_currentProbleme == _dropPb[0].value) {
        c = false;
        probleme = _currentProbleme;
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
