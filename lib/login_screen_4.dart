import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:intl/intl.dart';
import 'package:rapide_achat/accueil.dart';
import 'package:rapide_achat/accueilPro.dart';
import 'package:rapide_achat/api/api.dart';
import 'package:rapide_achat/register.dart';
import 'package:rapide_achat/register1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginScreen4 extends StatefulWidget {
  @override
  _LoginScreen4State createState() => new _LoginScreen4State();
}

class _LoginScreen4State extends State<LoginScreen4>
    with TickerProviderStateMixin {
  String email, password, email1, password1, cpassword, telephone;

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupCPasswordController = new TextEditingController();
  // TextEditingController emailResetController = new TextEditingController();
  ApiRest api = new ApiRest();
  bool _isLoading = false;
  bool _isLoading1 = false;
  bool _isLoading2 = false;

  @override
  void initState() {
    super.initState();
  }

  reset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(
          msg: "Un lien vous a été envoyé",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Cette adresse n'existe pas",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<String> dialog(BuildContext context) async {
    String teamName = '';
    return showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reinitialisation de mot de passe'),
          content: new Row(
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                keyboardType: TextInputType.emailAddress,
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'Votre Email',
                    hintText: 'votremail@xyz.com',
                    fillColor: Colors.red[900]),
                onChanged: (value) {
                  teamName = value;
                },
              ))
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Valider', style: TextStyle(color: Colors.red[900])),
              onPressed: () {
                reset(teamName);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  login() async {
    setState(() => _isLoading = true);
    email = loginEmailController.text;
    password = loginPasswordController.text;

    if (email.isEmpty || password.isEmpty) {
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
      try {
        final FirebaseUser user = await _auth.signInWithEmailAndPassword(
          email: loginEmailController.text,
          password: loginPasswordController.text,
        );

        if (user != null) {
          setState(() => _isLoading = false);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AccueilProPage(),
            ),
          );
        }
      } catch (e) {
        setState(() => _isLoading = false);
        Fluttertoast.showToast(
            msg: "votre compte n'existe pas",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.red[900],
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  register() async {
    setState(() => _isLoading1 = true);
    password = signupPasswordController.text;
    password1 = signupCPasswordController.text;
    email1 = signupEmailController.text;

    if (email1.isEmpty || password.isEmpty || password1.isEmpty) {
      setState(() => _isLoading1 = false);
      Fluttertoast.showToast(
          msg: "Remplissez tous les champs",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      if(password.length < 6 ) {
          setState(() => _isLoading1 = false);
      Fluttertoast.showToast(
          msg: "Votre mot de passe doit avoir au moins 6 caratères",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      } else {
          if (password1 == password) {
        try {
          final FirebaseUser user = await _auth.createUserWithEmailAndPassword(
            email: signupEmailController.text,
            password: signupPasswordController.text,
          );
          if (user != null) {
            setState(() => _isLoading1 = false);
            setState(() {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterPage1(connectType: "email"),
                ),
              );
            });
          }
        } catch (e) {
          setState(() => _isLoading1 = false);
          Fluttertoast.showToast(
              msg: "Cette adresse mail existe déjà",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.red[900],
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } 
      else {
        setState(() => _isLoading1 = false);
        Fluttertoast.showToast(
            msg: "Mots de passe non identiques",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.red[900],
            textColor: Colors.white,
            fontSize: 16.0);
      }
      }
      
    }
  }

  loginFacebook() async {
    setState(() => _isLoading2 = true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token == null) {
      final facebookLogin = FacebookLogin();
      final result = await facebookLogin
          .logInWithReadPermissions(['email', 'public_profile']);
      try {
        switch (result.status) {
          case FacebookLoginStatus.loggedIn:
            final AuthCredential credential =
                FacebookAuthProvider.getCredential(
              accessToken: result.accessToken.token,
            );
            final FirebaseUser user =
                await _auth.signInWithCredential(credential);
            await prefs.setString('token', result.accessToken.token);
            /*  DateFormat df = new DateFormat('yyyy-MM-dd HH:mm:ss');
            DateTime e = df.parse(result.accessToken.expires.toString());
            String expire = e.toString();
            await prefs.setString('expire', expire);*/
            setState(() => _isLoading2 = false);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterPage1(connectType: "facebook"),
              ),
            );
            break;
          case FacebookLoginStatus.cancelledByUser:
            setState(() => _isLoading2 = false);
            Fluttertoast.showToast(
                msg: "Facebook cancel",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.orange[400],
                textColor: Colors.white,
                fontSize: 16.0);
            break;
          case FacebookLoginStatus.error:
            setState(() => _isLoading2 = false);
            Fluttertoast.showToast(
                msg: "Facebook error",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.red[900],
                textColor: Colors.white,
                fontSize: 16.0);
            break;
        }
      } catch (e) {
        setState(() => _isLoading2 = false);
        Fluttertoast.showToast(
            msg: "Cette adresse mail existe déjà",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.red[900],
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      final AuthCredential credential = FacebookAuthProvider.getCredential(
        accessToken: token,
      );
      final FirebaseUser user = await _auth.signInWithCredential(credential);
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AccueilProPage(),
          ),
        );
      } else {
        user.reauthenticateWithCredential(credential);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AccueilProPage(),
          ),
        );
      }
    }
  }

  Widget HomePage() {
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.red[900],
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.1), BlendMode.dstATop),
          image: AssetImage('assets/images/mountains.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 250.0),
            child: Center(
              child: Image.asset(
                "assets/images/icon/icon.png",
                color: Colors.white,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 150.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new OutlineButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.red[900],
                    highlightedBorderColor: Colors.white,
                    onPressed: () => gotoSignup(),
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
                              "NOUVEAU COMPTE",
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
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.white,
                    onPressed: () => gotoLogin(),
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
                              "CONNECTEZ VOUS",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.red[900],
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
    );
  }

  Widget LoginPage() {
    return new SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
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
              padding: EdgeInsets.all(120.0),
              child: Center(
                child: Image.asset(
                  "assets/images/icon/icon.png",
                  color: Colors.red[900],
                ),
              ),
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: new Text(
                      "EMAIL",
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
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.red[900],
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
                      controller: loginEmailController,
                      obscureText: false,
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'votremail@xyz.com',
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
                      "MOT DE PASSE",
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
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.red[900],
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
                      controller: loginPasswordController,
                      obscureText: true,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '*********',
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: new FlatButton(
                    child: new Text(
                      "Mot de passe oublié?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red[900],
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    onPressed: () {
                      dialog(context);
                    },
                  ),
                ),
              ],
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
              alignment: Alignment.center,
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new FlatButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      color: Colors.red[900],
                      onPressed: login,
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
                                      "CONNEXION",
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
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
              alignment: Alignment.center,
              child: Row(
                children: <Widget>[
                  new Expanded(
                    child: new Container(
                      margin: EdgeInsets.all(8.0),
                      decoration:
                          BoxDecoration(border: Border.all(width: 0.25)),
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

  Widget SignupPage() {
    return new SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
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
                  color: Colors.red[900],
                ),
              ),
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: new Text(
                      "EMAIL",
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
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 2.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.red[900],
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
                      controller: signupEmailController,
                      obscureText: false,
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'votremail@xyz.com',
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
                      "MOT DE PASSE",
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
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 2.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.red[900],
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
                      controller: signupPasswordController,
                      obscureText: true,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '*********',
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
                      "CONFIRMER VOTRE MOT DE PASSE",
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
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 2.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.red[900],
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
                      controller: signupCPasswordController,
                      obscureText: true,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '*********',
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
                      color: Colors.red[900],
                      onPressed: register,
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
                                      "CREER MON COMPTE ENTREPRISE",
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
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: new FlatButton(
                    child: new Text(
                      "Avez vous déja un compte?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red[900],
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    onPressed: () => gotoLogin(),
                  ),
                ),
              ],
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
          children: <Widget>[LoginPage(), HomePage(), SignupPage()],
          scrollDirection: Axis.horizontal,
        ));
  }
}
