//MediaQuery.of(context).size.width * 0.65
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import './driver/home_page.dart';
import './owner/home_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'model/Colors.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

enum authProblems {
  UserNotFound,
  PasswordNotValid,
  NetworkError,
  EmailNotValid
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _errorLogin = '';
  String _errorEmail = 'Provide an email';
  String _email, _password;

  bool _saving = false;
//
  String phoneNumber;
  String smsCode;
  String verificationCode;
//
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: primaryDark,
      body: ModalProgressHUD(
        color: primary,
        inAsyncCall: _saving,
        child: Center(
          child: Card(
            margin: EdgeInsets.all(percentageSize(context, 8)),
            elevation: 8,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 30.0, right: 30.0,bottom: 20),
                children: <Widget>[
                  Hero(
                    tag: 'hero',
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 48.0,
                      child: Image.asset('assets/logo.png'),
                    ),
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return _errorEmail;
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10),
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email, color: primaryLight),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(new Radius.circular(30.0))),
                    ),
                    onSaved: (input) => _email = input,
                    //textInputAction: TextInputAction.continueAction,//only for ios
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input.length < 6) {
                        return 'Longer password please';
                      }
                    },
                    decoration: InputDecoration(
                      focusColor: Colors.redAccent,
                      hoverColor: Colors.greenAccent,
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10),
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock, color: primaryLight),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(new Radius.circular(30.0))),
                    ),
                    onSaved: (input) => _password = input,
                    obscureText: true,
                    textInputAction: TextInputAction.send,
                  ),
                  RaisedButton(
                    color: primary,
                    onPressed: () async {
                      if (_formKey.currentState.validate())
                        _signInWithEmailAndPassword();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Text(
                      'Sign in',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      _errorLogin,
                      style: TextStyle(color: errorMessage),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    /*Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(left: 24.0, right: 24.0),
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: TextField(
                              decoration:
                                  InputDecoration(labelText: "Phone Number"),
                              keyboardType: TextInputType.phone,
                              onChanged: (value) => phoneNumber = value,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 10.0),
                                  child: RaisedButton(
                                    onPressed: _submit,
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(
                                          fontSize: 15.0, color: Colors.white),
                                    ),
                                    color: Color(0xFF18D191),
                                    elevation: 7.0,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),*/
  }

  void _signInWithEmailAndPassword() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _formKey.currentState.save();

    final AuthResult user = await _auth
        .signInWithEmailAndPassword(
      email: _email,
      password: _password,
    )
        .catchError((e) {
      authProblems errorType;
      if (Platform.isAndroid)
        switch (e.message) {
          case 'There is no user record corresponding to this identifier. The user may have been deleted.':
            errorType = authProblems.UserNotFound;
            setState(() {
              _errorLogin = "User not found";
            });
            break;
          case 'The password is invalid or the user does not have a password.':
            errorType = authProblems.PasswordNotValid;
            setState(() {
              _errorLogin = "The password is invalid";
            });
            break;
          case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
            errorType = authProblems.NetworkError;
            setState(() {
              _errorLogin = "A network error";
            });
            break;
          case 'The email address is badly formatted.':
            errorType = authProblems.EmailNotValid;
            setState(() {
              _errorLogin = "Email not valid";
            });
            break;
          // ...
          default:
            print('Case: ${e.message} is not yet implemented');
        }
      else if (Platform.isIOS) {
        switch (e.code) {
          case 'Error 17011':
            errorType = authProblems.UserNotFound;
            break;
          case 'Error 17009':
            errorType = authProblems.PasswordNotValid;
            break;
          case 'Error 17020':
            errorType = authProblems.NetworkError;
            break;
          // ...
          default:
            print('Case ${e.message} is not yet implemented');
        }
      }
      print('The error is $errorType');
    });
    if (user != null) {
      setState(() {
        _saving = true;
      });
      FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
      var ref = FirebaseDatabase.instance
          .reference()
          .child("proprietaire")
          .child(currentUser.uid);
      ref.onValue.listen((onData) {
        if (onData.snapshot.value != null)
          Navigator.of(context).pushNamedAndRemoveUntil(
              HomeOwner.tag, (Route<dynamic> route) => false);
        else
          Navigator.of(context).pushNamedAndRemoveUntil(
              HomeDriver.tag, (Route<dynamic> route) => false);
      });
    }
  }

  /*
  Future<void> _submit() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId) {
      this.verificationCode = verId;
    };

    final PhoneCodeSent phoneCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationCode = verId;
      smsCodeDialog(context).then((value) => print("Signed In"));
    };

    final PhoneVerificationCompleted phoneVerificationCompleted =
        (AuthCredential user) {
      print("Success");
    };

    final PhoneVerificationFailed phoneVerificationFailed =
        (AuthException exception) {
      print("${exception.message}");
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Enter Code"),
            content: TextField(
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              FlatButton(
                child: Text("Verify"),
                onPressed: () {
                  FirebaseAuth.instance.currentUser().then((user) {
                    if (user != null) {
                      print('uf:hello');
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          HomeOwner.tag, (Route<dynamic> route) => false);
                    } else {
                      print('else:hello');
                      Navigator.of(context).pop();
                    }
                  });
                },
              )
            ],
          );
        });
  }*/
}
