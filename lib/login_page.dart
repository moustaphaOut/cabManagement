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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
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
            )),
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
        Navigator.of(context).pushNamed(HomeDriver.tag);
      else if (user.email == 'owner@gmail.com')
        Navigator.of(context).pushNamed(HomeOwner.tag);
        
    } else {
      setState(() {
        _success = false;
      });
    }
  }
}
