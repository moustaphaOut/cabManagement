import 'package:flutter/material.dart';
import './driver/home_page.dart';
import './owner/home_page.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool _success;
  String _userEmail;
//
  String phoneNumber;
  String smsCode;
  String verificationCode;
//
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            bottom: TabBar(
              indicatorColor: Colors.green[400],
              tabs: [
                Tab(text: "Email"),
                Tab(text: "Phone"),
              ],
            ),
            title: Text('Login'),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(left: 24.0, right: 24.0),
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
                                return 'Provide an email';
                              }
                            },
                            decoration: InputDecoration(labelText: 'Email'),
                            onSaved: (input) => _email = input,
                          ),
                          TextFormField(
                            validator: (input) {
                              if (input.length < 6) {
                                return 'Longer password please';
                              }
                            },
                            decoration: InputDecoration(labelText: 'Password'),
                            onSaved: (input) => _password = input,
                            obscureText: true,
                          ),
                          RaisedButton(
                            color: Colors.green,
                            onPressed: () async {
                              if (_formKey.currentState.validate())
                                _signInWithEmailAndPassword();
                            },
                            child: Text('Sign in'),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              _success == null
                                  ? ''
                                  : (_success
                                      ? 'Successfully signed in ' + _userEmail
                                      : 'Sign in failed'),
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
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
              ),
            ],
          ),
          backgroundColor: Colors.red[50],
        ),
      ),
    );
  }

  void _signInWithEmailAndPassword() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _formKey.currentState.save();
    final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
      email: _email,
      password: _password,
    ))
        .user;
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
      if (user.email == 'driver@gmail.com')
        Navigator.of(context).pushNamedAndRemoveUntil(HomeDriver.tag,(Route<dynamic> route) => false);
      else if (user.email == 'owner@gmail.com')
        Navigator.of(context).pushNamedAndRemoveUntil(HomeOwner.tag,(Route<dynamic> route) => false);
    } else {
      setState(() {
        _success = false;
      });
    }
  }

  //---------------
  Future<void> _submit() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId) {
      this.verificationCode = verId;
    };

    final PhoneCodeSent phoneCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationCode = verId;
      smsCodeDialog(context).then((value) => print("Signed In"));
    };

    final PhoneVerificationCompleted phoneVerificationCompleted =
        (AuthCredential  user) {
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
                      Navigator.of(context).pushNamedAndRemoveUntil(HomeOwner.tag,(Route<dynamic> route) => false);
                    } else {
                      print('else:hello');
                      Navigator.of(context).pop();
                      //signIn();
                    }
                  });
                },
              )
            ],
          );
        });
  }

  signIn() {
    /*FirebaseAuth.instance
        .signInWithPhoneNumber(
            verificationId: verificationCode, smsCode: smsCode)
        .then((user) => Navigator.of(context).pushNamed(HomeOwner.tag))
        .catchError((e) => print(e));*/
  }
}
