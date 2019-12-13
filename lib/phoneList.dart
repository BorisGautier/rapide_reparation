import 'dart:async';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:rapide_achat/api/api.dart';
import 'package:rapide_achat/home.dart';
import 'package:rapide_achat/models/produitResponse.dart';
import 'package:http/http.dart' as http;
import 'package:rapide_achat/technicien.dart';

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

class PhoneListPage extends StatefulWidget {
  PhoneListPage({prefix0.Key key, this.value, this.page}) : super(key: key);
  final String value;
  final int page;
  @override
  _PhoneListPage createState() => _PhoneListPage(value, page);
}

class _PhoneListPage extends State<PhoneListPage> {
  _PhoneListPage(this.value, this.page);
  String value;
  int page;

  bool a = false;

  var product = new List<ProduitResponse>();
  ApiRest api = new ApiRest();
  final String _simpleValue1 = 'logout';
  String _simpleValue;
  Timer timer;
  List<ProduitResponse> _produit;

  static final PRODUIT_URL =
      "https://www.rapide-achat.com/wp-json/public-woo/v1/products";

  Future<List<ProduitResponse>> _fetchProduit(
      String categorie, String id) async {
    var response = await http.get(
        PRODUIT_URL + "?" + categorie + "=" + id + "&page=" + page.toString());

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      _produit = items.map<ProduitResponse>((json) {
        return ProduitResponse.fromMap(json);
      }).toList();

      return _produit;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  initState() {
    super.initState();
    setState(() => a = true);
    Timer(new Duration(milliseconds: 3500), () async {
      await _fetchProduit("category", value);
      setState(() => a = false);
    });
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
      ), //Appbar
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            autoPlayDemo,
            Divider(color: Colors.transparent, height: 10),
            Center(
              child: Text(
                'Quelle est la source du problème de votre appareil?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[900],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            Expanded(
              child: a
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: _produit.length,
                      itemBuilder: (context, index) {
                        void eventDetail() {
                          int i;
                          if (value == "420" ||
                              value == "421" ||
                              value == "422" ||
                              value == "423" ||
                              value == "440" ||
                              value == "441" ||
                              value == "503" ||
                              value == "504" ||
                              value == "505" ||
                              value == "506") {
                            i = 2;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TechnicienPage(
                                        appareil: _produit[index]
                                            .categories[i - 1]
                                            .name,
                                        modele:
                                            _produit[index].categories[i].name,
                                        pb: null,
                                        probleme: _produit[index].name,
                                        prix: _produit[index].price,
                                        ecran: null,
                                      )), //MaterialPageRoute
                            );
                          } else if (value == "455" || value == "446") {
                            i = 3;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TechnicienPage(
                                        appareil:
                                            _produit[index].categories[i].name,
                                        modele: _produit[index]
                                            .categories[i - 1]
                                            .name,
                                        pb: null,
                                        probleme: _produit[index].name,
                                        prix: _produit[index].price,
                                        ecran: null,
                                      )), //MaterialPageRoute
                            );
                          } else if (value == "526" || value == "529") {
                            i = 2;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TechnicienPage(
                                        appareil:
                                            _produit[index].categories[i].name,
                                        modele: _produit[index]
                                            .categories[i + 3]
                                            .name,
                                        pb: null,
                                        probleme: _produit[index].name,
                                        prix: _produit[index].price,
                                        ecran: null,
                                      )), //MaterialPageRoute
                            );
                          } else if (value == "527" ||
                              value == "531" ||
                              value == "532" ||
                              value == "533") {
                            i = 3;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TechnicienPage(
                                        appareil:
                                            _produit[index].categories[i].name,
                                        modele: _produit[index]
                                            .categories[i - 2]
                                            .name,
                                        pb: null,
                                        probleme: _produit[index].name,
                                        prix: _produit[index].price,
                                        ecran: null,
                                      )), //MaterialPageRoute
                            );
                          }
                        }

                        return Card(
                          elevation: 5.0,
                          child: ListTile(
                            title: Text(
                              _produit[index].name,
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: eventDetail,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[900],
        onPressed: () => plus(),
        tooltip: 'Plus',
        child: Icon(Icons.add),
        elevation: 2.0,
      ), //Center
    ); //Scaffold
  }

  plus() {
    print(page + 1);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PhoneListPage(
                value: value,
                page: page + 1,
              )), //MaterialPageRoute
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
