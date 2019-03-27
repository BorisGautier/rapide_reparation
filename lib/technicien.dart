import 'package:carousel_slider/carousel_slider.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:rapide_achat/detail.dart';
import 'package:rapide_achat/login.dart';
import 'package:rapide_achat/modele.dart';

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
      {Key key, this.appareil, this.modele, this.probleme, this.ecran,this.pb})
      : super(key: key);

  final String appareil, modele, probleme, ecran,pb;
  @override
  _TechnicienPage createState() =>
      _TechnicienPage(appareil, modele, probleme, ecran,pb);
}

class _TechnicienPage extends State<TechnicienPage> {
  _TechnicienPage(this.appareil, this.modele, this.probleme, this.ecran,this.pb);
   String appareil, modele, probleme, ecran,pb;
  final String _simpleValue1 = 'logout';
  String _simpleValue,date;
  bool e = false;

  InputType inputType = InputType.both;
  bool editable = true;
  DateTime date1;

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
    } 
  }

  confirmerD() {
    date =dateController.text;
    if(date.isEmpty) {
       Fluttertoast.showToast(
            msg: "Choisissez une date",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.blue[900],
            textColor: Colors.white,
            fontSize: 16.0);
    }
    else{
       Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(appareil: appareil,date: date,ecran: ecran,modele: modele,pb: pb,probleme: probleme,rdv: "domicile",)), //MaterialPageRoute
      );
    }
    
  }

  confirmerB() {
    date =dateController.text;
    if(date.isEmpty) {
      Fluttertoast.showToast(
            msg: "Choisissez une date",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.blue[900],
            textColor: Colors.white,
            fontSize: 16.0);
    }
    else{
       Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(appareil: appareil,date: date,ecran: ecran,modele: modele,pb: pb,probleme: probleme,rdv: "boutique",)), //MaterialPageRoute
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

    // TODO: implement build
    return Scaffold(
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
                            Padding(padding: EdgeInsets.only(left: 10.0),
                        child:  IconButton(
                          icon: new Icon(Icons.backspace,color: Colors.red[900],),
                          onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ModelePage(appareil: appareil)), //MaterialPageRoute
                              );
                          },
                        ) ,
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
                                              'assets/images/shop.png'),
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
                                    Text("Rendez-Vous à la boutique",
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
                                              'assets/images/home.png'),
                                          fit: BoxFit.contain,
                                          width: 120.0,
                                          height: 120.0,
                                          child: InkWell(
                                            onTap: () {
                                              confirmerD();
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
                                    Text("Technicien à domicile",
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
