import 'dart:async';
import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:rapide_achat/api/api.dart';
import 'package:rapide_achat/choix.dart';
import 'package:rapide_achat/detail.dart';
import 'package:rapide_achat/detail1.dart';
import 'package:rapide_achat/home.dart';
import 'package:rapide_achat/login.dart';
import 'package:rapide_achat/modele.dart';
import 'package:rapide_achat/models/nominatimResponse.dart';
import 'package:rapide_achat/models/nominatimSearch.dart';
import 'package:rapide_achat/societe.dart';
import 'package:http/http.dart' as http;
import 'package:search_widget/search_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

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

class TechnicienPage extends StatefulWidget {
  TechnicienPage(
      {Key key,
      this.appareil,
      this.modele,
      this.probleme,
      this.ecran,
      this.pb,
      this.prix})
      : super(key: key);

  final String appareil, modele, probleme, ecran, pb, prix;
  @override
  _TechnicienPage createState() =>
      _TechnicienPage(appareil, modele, probleme, ecran, pb, prix);
}

class _TechnicienPage extends State<TechnicienPage> {
  _TechnicienPage(this.appareil, this.modele, this.probleme, this.ecran,
      this.pb, this.prix);
  String appareil, modele, probleme, ecran, pb, prix;
  final String _simpleValue1 = 'logout';
  String _simpleValue, date;
  bool e = false;

  InputType inputType = InputType.both;
  bool editable = true;
  DateTime date1;
  /* bool isLoading = true;
  bool b = true;
  String locate = "Mon adresse";*/
  ApiRest api = new ApiRest();

  TextEditingController dateController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    if (ecran == null) {
      e = true;
    } else {
      e = false;
    }
    if (pb != null) {
      probleme = pb;
    } else {
      if (appareil == "tablette") {
        probleme = "Ma" + " " + appareil;
      } else if (appareil == "ordinateur") {
        probleme = "Mon" + " " + appareil;
      } else if (appareil == "smartphone") {
        probleme = probleme;
      }
    }
  }

/*  Future<String> dialog(BuildContext context) async {
    String adresse = '';
    return showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Entrez votre adresse'),
          content: new Row(
            children: <Widget>[
                /*  child: new TextField(
                keyboardType: TextInputType.text,
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'Votre Adresse',
                    fillColor: Colors.red[900]),
                onChanged: (value) {
                  adresse = value;
                },
                  )*/
                   Center(
                    child: isLoading ?  Text(locate) : CircularProgressIndicator() ,
                  
                  ),
              
            ],
          ),
          actions: <Widget>[
          b ?  FlatButton(
              child: Text('Me localiser', style: TextStyle(color: Colors.red[900])),
              onPressed: () {
                setState(() => isLoading = false);
                search();
                
              //  Navigator.of(context).pop();
              },
            ) : FlatButton(
              child: Text('Valider', style: TextStyle(color: Colors.red[900])),
              onPressed: () {
                confirmerD(locate);
              //  Navigator.of(context).pop();
              },
            ) ,
             FlatButton(
              child: Text('Retour', style: TextStyle(color: Colors.red[900])),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }*/

  /* String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 6);
  }

  search() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    double long = position.longitude;
    double lat = position.latitude;

    String lo = format(long);
    String la = format(lat);

    api.nominatim(la, lo).then((NominatimResponse nominatim) {
      locate = nominatim.displayName;
      setState(() => isLoading = true);
      setState(() => b = false);
    });
  }

  confirmerD(String adr) async {
    date = dateController.text;
    if (date.isEmpty) {
      Fluttertoast.showToast(
          msg: "Choisissez une date",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.blue[900],
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SocietePage(
                appareil: appareil,
                date: date,
                ecran: ecran,
                modele: modele,
                pb: pb,
                probleme: probleme,
                rdv: "domicile",
                prix: prix,
                adresse: adr)), //MaterialPageRoute
      );
    }
  }*/

  confirmerB() {
    date = dateController.text;
    if (date.isEmpty) {
      Fluttertoast.showToast(
          msg: "Choisissez une date",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.blue[900],
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Detail1Page(
                appareil: appareil,
                date: date,
                ecran: ecran,
                modele: modele,
                pb: pb,
                probleme: probleme,
                rdv: "boutique",
                societe: "Rapide Achat",
                prix: prix)), //MaterialPageRoute
      );
    }
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

    // TODO: implement build
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
      body: Container(
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
                      color: Colors.transparent,
                    ),
                    child: new Column(
                      children: <Widget>[
                        Divider(color: Colors.transparent, height: 20),
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
                              padding: EdgeInsets.only(right: 70.0),
                            ),
                            Text("ETAPE 3/3",
                                style: TextStyle(
                                    color: Colors.red[900],
                                    fontStyle: FontStyle.italic,
                                    fontSize: 27,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                          ],
                        ),
                        Divider(color: Colors.transparent, height: 60),
                        /*   e
                          ? Text("Le problème de votre" +
                              " " +
                              appareil +
                              " " +
                              "est" +
                              " " +
                              probleme)
                          : Text("Le problème de votre" +
                              " " +
                              appareil +
                              " " +
                              "est" +
                              " " +
                              probleme +
                              ":" +
                              " " +
                              ecran,textAlign: TextAlign.center),*/
                        new Row(
                          children: <Widget>[
                            new Expanded(
                              child: new Padding(
                                padding: const EdgeInsets.only(left: 40.0),
                                child: new Text(
                                  "PLANIFIEZ L'INTERVENTION",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[900],
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        new Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(
                              left: 40.0, right: 40.0, top: 2.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: Colors.redAccent,
                                  width: 0.5,
                                  style: BorderStyle.solid),
                            ),
                          ),
                          padding:
                              const EdgeInsets.only(left: 0.0, right: 10.0),
                          child: new Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Expanded(
                                child: DateTimePickerFormField(
                                  selectableDayPredicate: (DateTime val) =>
                                      val.isBefore(DateTime.now())
                                          ? false
                                          : true,
                                  controller: dateController,
                                  inputType: inputType,
                                  format: DateFormat('yyyy-MM-dd HH:mm:ss'),
                                  editable: editable,
                                  obscureText: false,
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                    prefixIcon: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 12.0),
                                      child: Icon(Icons
                                          .calendar_today), // myIcon is a 48px-wide widget.
                                    ),
                                    border: InputBorder.none,
                                    hintText: '1990-01-01 10:00:00',
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                  onChanged: (dt) => setState(() => date1 = dt),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: Colors.transparent, height: 40),
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
                                                'assets/images/shopp.png'),
                                            fit: BoxFit.contain,
                                            width: 120.0,
                                            height: 120.0,
                                            child: InkWell(
                                              onTap: () {
                                                confirmerB();
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
                                      Text(
                                        "RDV Boutique",
                                        style: TextStyle(
                                            color: Colors.red[900],
                                            fontWeight: FontWeight.bold),
                                      ),
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
                                                'assets/images/home123.jpg'),
                                            fit: BoxFit.contain,
                                            width: 120.0,
                                            height: 120.0,
                                            child: InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) {
                                                      date =
                                                          dateController.text;
                                                      return MyDialogContent(
                                                        api: api,
                                                        appareil: appareil,
                                                        date: date,
                                                        ecran: ecran,
                                                        modele: modele,
                                                        pb: pb,
                                                        prix: prix,
                                                        probleme: probleme,
                                                      );
                                                    });
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
                                      Text(
                                        "Technicien à domicile",
                                        style: TextStyle(
                                            color: Colors.red[900],
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(color: Colors.transparent, height: 60),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
}

class MyDialogContent extends StatefulWidget {
  MyDialogContent(
      {Key key,
      this.appareil,
      this.modele,
      this.probleme,
      this.ecran,
      this.pb,
      this.prix,
      this.api,
      this.date})
      : super(key: key);

  final String appareil, modele, probleme, ecran, pb, prix, date;
  final ApiRest api;
  @override
  _MyDialogContentState createState() => new _MyDialogContentState(
      appareil, modele, probleme, ecran, pb, prix, api, date);
}

class _MyDialogContentState extends State<MyDialogContent> {
  _MyDialogContentState(this.appareil, this.modele, this.probleme, this.ecran,
      this.pb, this.prix, this.api, this.date);
  String appareil, modele, probleme, ecran, pb, prix, date;
  ApiRest api;
  bool isLoading = true;
  bool b = true;
  String locate = "Mon adresse";
  TextEditingController adresseController = new TextEditingController();
  List<String> result;
  List<NominatimResponse> nominatimResponse = new List<NominatimResponse>();
  GlobalKey<AutoCompleteTextFieldState<NominatimResponse>> key =
      new GlobalKey();
  AutoCompleteTextField searchTextField;

  FutureOr<List<NominatimResponse>> getPlace(String search) async {
    try {
      final response = await http.get(
          "https://nominatim.openstreetmap.org/search" +
              "?" +
              "q=" +
              search +
              "&format=json&polygon=0&addressdetails=1&countrycodes=fr");
      if (response.statusCode == 200) {
        setState(() {
          nominatimResponse = loadPlace(response.body);
          print('Users: ${nominatimResponse.length}');
          return nominatimResponse;
        });
      } else {
        print("Error getting places");
      }
    } catch (e) {
      print("Error getting places");
    }
    return nominatimResponse;
  }

  static List<NominatimResponse> loadPlace(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed
        .map<NominatimResponse>((json) => NominatimResponse.fromJson(json))
        .toList();
  }

  Widget row(NominatimResponse nomin) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          nomin.displayName,
          style: TextStyle(fontSize: 16.0),
        ),
        /*  SizedBox(
         width: 10.0,
       ),
       Text(
         nomin.placeId.toString(),
       ),*/
      ],
    );
  }

  String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 6);
  }

  search() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    double long = position.longitude;
    double lat = position.latitude;

    String lo = format(long);
    String la = format(lat);

    api.nominatim(la, lo).then((NominatimResponse nominatim) {
      locate = nominatim.displayName;
      setState(() => adresseController.text = locate);
      setState(() => isLoading = true);
      //  setState(() => b = false);
    });
  }

  confirmerD(String adr, String code, String etage, String infos) async {
    // date = dateController.text;
    if (date.isEmpty) {
      Fluttertoast.showToast(
          msg: "Choisissez une date",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.blue[900],
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SocietePage(
                appareil: appareil,
                date: date,
                ecran: ecran,
                modele: modele,
                pb: pb,
                probleme: probleme,
                rdv: "domicile",
                prix: prix,
                adresse: adr,
                code: code,
                etage: etage,
                infos: infos)), //MaterialPageRoute
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String code = '', etage = '', infos = '';
    return AlertDialog(
      title: Text('Adresse'),
      content: new Column(
          children: <Widget>[
            Expanded(
                child: isLoading
                    ? TypeAheadField(
                        hideSuggestionsOnKeyboardHide: false,
                        textFieldConfiguration: TextFieldConfiguration(
                          autofocus: true,
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                          decoration: new InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() => isLoading = false);
                                search();
                              },
                              child: Icon(
                                FontAwesomeIcons.mapMarker,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          controller: adresseController,
                        ),
                        suggestionsCallback: (pattern) async {
                          return await getPlace(pattern);
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            leading: Icon(Icons.place),
                            title: Text(suggestion.displayName),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          adresseController.text = suggestion.displayName;
                        },
                      )
                    : new Center(
                        child: CircularProgressIndicator(),
                      )),
                      Divider(color: Colors.transparent,),
            new Expanded(
                child: new TextField(
              keyboardType: TextInputType.text,
              autofocus: true,
              decoration: new InputDecoration(
                  hintText: 'votre code',
                  fillColor: Colors.red[900]),
              onChanged: (value) {
                code = value;
              },
            )),
            Divider(color: Colors.transparent,),
            new Expanded(
                child: new TextField(
              keyboardType: TextInputType.text,
              autofocus: true,
              decoration: new InputDecoration(
                  hintText: 'votre étage',
                  fillColor: Colors.red[900]),
              onChanged: (value) {
                etage = value;
              },
            )),
            Divider(color: Colors.transparent,),
            new Expanded(
                child: new TextField(
              keyboardType: TextInputType.text,
              autofocus: true,
              decoration: new InputDecoration(
                  hintText: 'infos',
                  fillColor: Colors.red[900]),
              onChanged: (value) {
                infos = value;
              },
            )),
          ],
        ),
      actions: <Widget>[
        FlatButton(
          child: Text('Valider', style: TextStyle(color: Colors.red[900])),
          onPressed: () {
            if (adresseController.text.isNotEmpty) {
              confirmerD(locate, code, etage, infos);
            } else {
              Fluttertoast.showToast(
                  msg: "Entrer une adresse",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.red[900],
                  textColor: Colors.white,
                  fontSize: 16.0);
            }

            //  Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Retour', style: TextStyle(color: Colors.red[900])),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
