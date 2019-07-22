import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rapide_achat/accueil.dart';
import 'package:rapide_achat/accueilPro.dart';
import 'package:rapide_achat/api/api.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
//import 'package:rapide_achat/models/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rapide_achat/models/response.dart';
import 'package:rapide_achat/register2.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterScreen2 extends StatefulWidget {
  RegisterScreen2({Key key, this.ent}) : super(key: key);

  final String ent;
  @override
  _RegisterScreenState2 createState() => new _RegisterScreenState2(ent);
}

class _RegisterScreenState2 extends State<RegisterScreen2>
    with TickerProviderStateMixin {
  _RegisterScreenState2(this.ent);
  final String ent;
  bool _isLoading = false;
  bool _isLoading1 = false;

  // Changeable in demo
  InputType inputType = InputType.date;
  bool editable = true;
  DateTime date1;

  String file,file1,nomTechnicien,tof1,tof2;

  TextEditingController controllerName = new TextEditingController();

  File cv,diplome;

 
  ApiRest api = new ApiRest();

  @override
  void initState() {
    super.initState();
  }


 register() async {
    setState(() => _isLoading = true);
     List<int> imageBytes = await cv.readAsBytesSync();
     List<int> imageBytes1 = await diplome.readAsBytesSync();
     tof1 = base64Encode(imageBytes);
     tof2 = base64Encode(imageBytes1);
     nomTechnicien = controllerName.text;
     file = cv.path.split("/").last;
     file1 = diplome.path.split("/").last;

    if (nomTechnicien.isEmpty) {
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

        setState(() {
          if (currentUser != null) {
          
     api.registerT(nomTechnicien,ent,"a,"+tof1, "a,"+tof2).then((Response response) {
      if (response.status == "success") {
           setState(() => _isLoading = false);
            Fluttertoast.showToast(
                msg: "Enregistrement du technicien terminé avec succès",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.green[400],
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterPage2(),
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
              child: Center(
                child: Image.asset(
                  "assets/images/icon/icon.png",
                  color: Colors.redAccent,
                ),
              ),
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: new Text(
                      "NOM DU TECHNICIEN",
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
                        hintText: 'Nom du technicien',
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
                      "CV du TECHNICEN",
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
                 cv == null ? new Expanded(
                    child: TextField(
                      onTap:getImage ,
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
                            hintText: "Image CV",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
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
                  ):  Container(
              width: 100,
              height: 100,
              child: Card(
              child:Image.file(cv),
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
                      "Diplome du TECHNICIEN",
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
                 diplome == null ? new Expanded(
                    child: TextField(
                      onTap:getImage1 ,
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
                            hintText: "Diplome",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
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
                  ):  Container(
              width: 100,
              height: 100,
              child: Card(
              child:Image.file(diplome),
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
                                      "VALIDER ET CREER UN NOUVEAU",
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

                   new Expanded(
                    child: new FlatButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      color: Colors.redAccent,
                      onPressed: () {
                         Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AccueilProPage(),
              ),
            );
                      } ,
                      child: _isLoading1
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
                                      "TERMINER",
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

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery,maxHeight: 250,maxWidth:400);
  
    setState(() {
      cv = image;
    });
  }

   Future getImage1() async {
    var image1 = await ImagePicker.pickImage(source: ImageSource.gallery,maxHeight: 250,maxWidth:400);
  
    setState(() {
      diplome = image1;
    });
  }
}
