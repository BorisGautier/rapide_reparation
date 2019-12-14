import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rapide_achat/api/api.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:rapide_achat/models/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rapide_achat/register2.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterScreen1 extends StatefulWidget {
  RegisterScreen1({Key key, this.connectType}) : super(key: key);

  final String connectType;
  @override
  _RegisterScreenState1 createState() => new _RegisterScreenState1(connectType);
}

class _RegisterScreenState1 extends State<RegisterScreen1>
    with TickerProviderStateMixin {
  _RegisterScreenState1(this.connectType);
  final String connectType;
  bool _isLoading = false;

  // Changeable in demo
  InputType inputType = InputType.date;
  bool editable = true;
  DateTime date1;

  String nom_entreprise, file, file1, tof1, tof2;

  TextEditingController controllerName = new TextEditingController();

  File kbis, rib;

  ApiRest api = new ApiRest();

  String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 6);
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 250, maxWidth: 400);

    setState(() {
      kbis = image;
    });
  }

  Future getImage1() async {
    var image1 = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 250, maxWidth: 400);

    setState(() {
      rib = image1;
    });
  }

  register() async {
    setState(() => _isLoading = true);
    List<int> imageBytes = await kbis.readAsBytesSync();
    List<int> imageBytes1 = await rib.readAsBytesSync();
    tof1 = base64Encode(imageBytes);
    tof2 = base64Encode(imageBytes1);
    nom_entreprise = controllerName.text;
    file = kbis.path.split("/").last;
    file1 = rib.path.split("/").last;

    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    double lng = position.longitude;
    double lat = position.latitude;

    String l1 = format(lng);
    String l2 = format(lat);

    if (nom_entreprise.isEmpty) {
      setState(() => _isLoading = false);
      Fluttertoast.showToast(
          msg: "Remplissez tous les champs",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      final FirebaseUser currentUser = await _auth.currentUser();

      /*  if (connectType == "facebook") {
        setState(() {
          if (currentUser != null) {
           
      api.registerE(nom_entreprise, currentUser.email, "data:image/jpeg;base64,"+tof1, "data:image/jpeg;base64,"+tof2,currentUser.uid,l1,l2).then((Response response) {
      if (response.status == "success") {
         setState(() => _isLoading = false);
            Fluttertoast.showToast(
                msg: "Enregistrement terminé avec succès",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.green[400],
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterPage2(ent : nom_entreprise),
              ),
            );
      } else {
         setState(() => _isLoading = false);
          Fluttertoast.showToast(
              msg: "Erreur lors de l'enregistrement",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.red[400],
              textColor: Colors.white,
              fontSize: 16.0);
      }
    });
          } 
          else {
            setState(() => _isLoading = false);
            Fluttertoast.showToast(
                msg: "Erreur de connexion au compte",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.red[400],
                textColor: Colors.white,
                fontSize: 16.0);
          }
        });
      } */

      //    else {
      setState(() async {
        if (currentUser != null) {
          api
              .registerES(nom_entreprise, currentUser.email, "a," + tof1,
                  "a," + tof2, l1, l2)
              .then((Response response) async {
            if (response.status == "success") {
              setState(() => _isLoading = false);
              Fluttertoast.showToast(
                  msg: "Enregistrement de l'entreprise terminé avec succès",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.green[400],
                  textColor: Colors.white,
                  fontSize: 16.0);

              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('ent', nom_entreprise);
              await prefs.setString('compte', "ent");

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterPage2(ent: nom_entreprise),
                ),
              );
            } else {
              setState(() => _isLoading = false);
              Fluttertoast.showToast(
                  msg: "Erreur lors de l'enregistrement",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.red[400],
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          });
        } else {
          setState(() => _isLoading = false);
          Fluttertoast.showToast(
              msg: "Erreur de connexion au compte",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.red[400],
              textColor: Colors.white,
              fontSize: 16.0);
        }
      });
      //   }
    }
  }

  Widget SignupPage() {
    return new SingleChildScrollView(
      child: Container(
        height: 1000,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.05), BlendMode.dstATop),
            image: AssetImage('assets/images/mountains.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: new Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(80.0),
              child: Center(),
            ),
            Text(
                "NB: Votre position actuelle sera utilisée comme position de votre entreprise"),
            Divider(),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: new Text(
                      "NOM DE L'ENTREPRISE",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 2.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.redAccent,
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Expanded(
                    child: TextField(
                      controller: controllerName,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Nom de l\'entrepise',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 24.0,
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: new Text(
                      "KBIS",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 2.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.redAccent,
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  kbis == null
                      ? new Expanded(
                          child: TextField(
                            keyboardType: TextInputType.text,
                            onTap: getImage,
                            style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.file,
                                color: Colors.black,
                              ),
                              hintText: file,
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0),
                              suffixIcon: GestureDetector(
                                onTap: getImage,
                                child: Icon(
                                  FontAwesomeIcons.image,
                                  size: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            onChanged: (dt) => setState(() => file = dt),
                          ),
                        )
                      : Container(
                          width: 100,
                          height: 100,
                          child: Card(
                            child: Image.file(kbis),
                          ),
                        ),
                ],
              ),
            ),
            Divider(
              height: 24.0,
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: new Text(
                      "RIB",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 2.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.redAccent,
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  rib == null
                      ? new Expanded(
                          child: TextField(
                            onTap: getImage1,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.file,
                                color: Colors.black,
                              ),
                              hintText: file1,
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0),
                              suffixIcon: GestureDetector(
                                onTap: getImage,
                                child: Icon(
                                  FontAwesomeIcons.image,
                                  size: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            onChanged: (dt) => setState(() => file1 = dt),
                          ),
                        )
                      : Container(
                          width: 100,
                          height: 100,
                          child: Card(
                            child: Image.file(rib),
                          ),
                        ),
                ],
              ),
            ),
            Divider(
              height: 24.0,
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
              alignment: Alignment.center,
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new FlatButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      color: Colors.redAccent,
                      onPressed: register,
                      child: _isLoading
                          ? new CircularProgressIndicator(
                              backgroundColor: Colors.white)
                          : new Container(
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
          ],
        ),
      ),
    );
  }

  gotoLogin() {
    //controller_0To1.forward(from: 0.0);
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  gotoSignup() {
    //controller_minus1To0.reverse(from: 0.0);
    _controller.animateToPage(
      2,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  PageController _controller =
      new PageController(initialPage: 1, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
//      child: new GestureDetector(
//        onHorizontalDragStart: _onHorizontalDragStart,
//        onHorizontalDragUpdate: _onHorizontalDragUpdate,
//        onHorizontalDragEnd: _onHorizontalDragEnd,
//        behavior: HitTestBehavior.translucent,
//        child: Stack(
//          children: <Widget>[
//            new FractionalTranslation(
//              translation: Offset(-1 - (scrollPercent / (1 / numCards)), 0.0),
//              child: SignupPage(),
//            ),
//            new FractionalTranslation(
//              translation: Offset(0 - (scrollPercent / (1 / numCards)), 0.0),
//              child: HomePage(),
//            ),
//            new FractionalTranslation(
//              translation: Offset(1 - (scrollPercent / (1 / numCards)), 0.0),
//              child: LoginPage(),
//            ),
//          ],
//        ),
//      ),
        child: PageView(
          controller: _controller,
          physics: new AlwaysScrollableScrollPhysics(),
          children: <Widget>[SignupPage()],
          scrollDirection: Axis.horizontal,
        ));
  }
}
