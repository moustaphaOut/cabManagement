import 'package:flutter/material.dart';
//import 'package:flutter_firebase_auth/user.dart';
import './model/chauffeur.dart';

class AddUserDialog {
  final teName = TextEditingController();
  var mydata= "";
  Chauffeur user;

  static const TextStyle linkStyle = const TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );
  AddUserDialog(String textt){
    this.mydata = textt;
  }
  Widget buildAboutDialog(BuildContext context,
      AddUserCallback _myHomePageState, Chauffeur user) {
    if (user != null) {
      this.user = user;
      teName.text =mydata;
    }

    return new AlertDialog(
      title: new Text('Edit'),
      content: new SingleChildScrollView(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTextField("Name", teName),
            new GestureDetector(
              onTap: () => onTap(_myHomePageState, context),
              child: new Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: getAppBorderButton("Edit",
                    EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTextField(
      String inputBoxName, TextEditingController inputBoxController) {
    var loginBtn = new Padding(
      padding: const EdgeInsets.all(5.0),
      child: new TextFormField(
        controller: inputBoxController,
        decoration: new InputDecoration(
          hintText: inputBoxName,
        ),
      ),
    );

    return loginBtn;
  }

  Widget getAppBorderButton(String buttonLabel, EdgeInsets margin) {
    var loginBtn = new Container(
      margin: margin,
      padding: EdgeInsets.all(8.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        border: Border.all(color: const Color(0xFF28324E)),
        borderRadius: new BorderRadius.all(const Radius.circular(6.0)),
      ),
      child: new Text(
        buttonLabel,
        style: new TextStyle(
          color: const Color(0xFF28324E),
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      ),
    );
    return loginBtn;
  }

  Chauffeur getData() {
    return new Chauffeur(teName.text);
  }

  onTap( AddUserCallback _myHomePageState, BuildContext context) {
    
      _myHomePageState.update(getData());
      Navigator.of(context).pop();
    
  }
}

abstract class AddUserCallback {
  void addUser(Chauffeur user);

  void update(Chauffeur user);
}
