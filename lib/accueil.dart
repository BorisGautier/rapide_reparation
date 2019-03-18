import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rapide_achat/login.dart';

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

class AccueilPage extends StatefulWidget {
  @override
  _AccueilPage createState() => _AccueilPage();
}

class _AccueilPage extends State<AccueilPage> {
  final String _simpleValue1 = 'logout';
  String _simpleValue;
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

    return new Scaffold(
      appBar: AppBar(
        title: Text("Rapide Achat"),
        backgroundColor: Colors.red[400],
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
              padding: EdgeInsets.symmetric(vertical: 11.0),
              child: Column(children: [
                autoPlayDemo,
              ])),
              new Container(
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
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Image.asset(
                "assets/images/icon/icon.png",
              ),
            ),
          ),
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
            child: Center(child: Material(
                elevation: 4.0,
                shape: CircleBorder(),
                color: Colors.white,
                child: Ink.image(
                  image: AssetImage('assets/images/15.jpg'),
                  fit: BoxFit.cover,
                  width: 120.0,
                  height: 120.0,
                  child: InkWell(
                    onTap:  () {},
                    child: null,
                  ),
                ),
                
              )
              
              ),
                    ),
                  ),
                  
                ),
                 Divider(
            color: Colors.white,
          ),
                Column(
                  children: <Widget>[
                    Text("Téléphones"),
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
            child: Center(child: Material(
                elevation: 4.0,
                shape: CircleBorder(),
                color: Colors.white,
                child: Ink.image(
                  image: AssetImage('assets/images/14.jpg'),
                  fit: BoxFit.contain,
                  width: 120.0,
                  height: 120.0,
                  child: InkWell(
                    onTap:  () {},
                    child: null,
                  ),
                ),
                
              )
              
              ),
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
            child: Center(child: Material(
                elevation: 4.0,
                shape: CircleBorder(),
                color: Colors.white,
                child: Ink.image(
                  image: AssetImage('assets/images/20.jpg'),
                  fit: BoxFit.contain,
                  width: 120.0,
                  height: 120.0,
                  child: InkWell(
                    onTap:  () {},
                    child: null,
                  ),
                ),
                
              )
              
              ),
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
