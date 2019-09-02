import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestion_taxi/driver/home_page.dart';
import 'package:gestion_taxi/driver/traffic_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../update_field_dialog.dart';
import '../widgets/info_card.dart';
import '../login_page.dart';

const photo = 'assets/alucard.jpg';
const job = 'Driver';
const city = 'Rabat, Morocco';

class ProfileDriver extends StatefulWidget {
  static String tag = 'profile-driver';
  @override
  State<StatefulWidget> createState() {
    return _ProfileDriver();
  }
}

class _ProfileDriver extends State<ProfileDriver> {
  String _cin_chauffeur = "",
      _email_chauffeur = "",
      _nom_chauffeur = "",
      _prenom_chauffeur = "",
      _telephone_chauffeur = "",
      _date_naissance_chauffeur = "";
  StreamSubscription _subscriptionTodo;
 @override
  void initState() {
    //FirebaseTodos.getTodo("-KriJ8Sg4lWIoNswKWc4").then(_updateTodo);
    FirebaseTodos.getChauffeur(_updateChauffeur)
        .then((StreamSubscription s) => _subscriptionTodo = s);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 0, 0, 0.7),
        title: Text('Profile'),
        actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.outlined_flag),
                onPressed: () => _signOut(),
              ),
            ],
      ),
      body: Container(
        child: Center(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: <Widget>[
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(photo),
              ),
              Text(
                _prenom_chauffeur + " " + _nom_chauffeur,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pacifico',
                ),
              ),
              Text(
                job,
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  fontSize: 10.0,
                  color: Colors.teal[50],
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.teal.shade700,
                ),
              ),
              InfoCard(
                text: _cin_chauffeur,
                icon: Icons.web,
                colorText: Colors.teal,
                onPressed: () {},
              ),
              InfoCard(
                text: _telephone_chauffeur,
                icon: Icons.phone,
                colorText: Colors.teal,
                onPressed: () {},
              ),
              InfoCard(
                text: _email_chauffeur,
                icon: Icons.email,
                colorText: Colors.teal,
                onPressed: () {},
              ),
              InfoCard(
                text: _date_naissance_chauffeur,
                colorText: Colors.teal,
                icon: Icons.calendar_today,
                onPressed: () => showEditWidget(
                     _date_naissance_chauffeur, "date_naissance_chauffeur"),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            title: Text('My traffic'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            title: Text('Profile'),
          ),
        ],
        currentIndex: 2,
        onTap: (currentIndex) {
          if (currentIndex == 0)
            Navigator.of(context).pushNamedAndRemoveUntil(HomeDriver.tag,(Route<dynamic> route) => false);
          else if (currentIndex == 1)
            Navigator.of(context).pushNamedAndRemoveUntil(TrafficDriver.tag,(Route<dynamic> route) => false);
          //Navigator.of(context).pushNamed(Profile.tag);
        },
        selectedItemColor: Colors.amber[800],
      ),
       backgroundColor: Colors.teal[200],
       
    );
  }
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil(LoginPage.tag,(Route<dynamic> route) => false);
  }
Future<String> getCurrentEmail() async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  return user.email;
}
 Future<String> getCurrentUid() async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  String uid = user.uid;
  return uid;
}
  showEditWidget( String currentData, String attributeName) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          new UpdateFieldDialog().buildAboutDialog(context, attributeName, currentData),
    );
  }

  _updateChauffeur(TodoChauffeur value) {
    setState(() {
      _cin_chauffeur = value.cin_chauffeur;
      _email_chauffeur = value.email_chauffeur;
      _nom_chauffeur = value.nom_chauffeur;
      _prenom_chauffeur = value.prenom_chauffeur;
      _telephone_chauffeur = value.telephone_chauffeur;
      _date_naissance_chauffeur = value.date_naissance_chauffeur;
    });
  }
}

class TodoChauffeur {
  final String key;
  String cin_chauffeur,
      email_chauffeur,
      nom_chauffeur,
      prenom_chauffeur,
      telephone_chauffeur,
      date_naissance_chauffeur;
  TodoChauffeur.fromJson(this.key, Map data) {
    cin_chauffeur =
        (data['cin_chauffeur'] == null ? '' : data['cin_chauffeur']);
    email_chauffeur =
        (data['email_chauffeur'] == null ? '' : data['email_chauffeur']);
    nom_chauffeur =
        (data['nom_chauffeur'] == null ? '' : data['nom_chauffeur']);
    prenom_chauffeur = (data['prenom_chauffeur'] == null
        ? ''
        : data['prenom_chauffeur']);
    telephone_chauffeur = (data['telephone_chauffeur'] == null
        ? ''
        : data['telephone_chauffeur']);
    date_naissance_chauffeur = (data['date_naissance_chauffeur'] == null
        ? ''
        : data['date_naissance_chauffeur']);
  }
}

class FirebaseTodos {
  /// FirebaseTodos.getTodoStream("-KriJ8Sg4lWIoNswKWc4", _updateTodo)
  /// .then((StreamSubscription s) => _subscriptionTodo = s);
  static Future<StreamSubscription<Event>> getChauffeur(
      void onData(TodoChauffeur todo)) async {
    String accountKey = await Preferences.getAccountKey();

    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child("proprietaire")
        .child(accountKey)
        .child("agreement")
        .child("agr1")
        .child("vehicule")
        .child("chauffeur")
        .child("cha1")//.child(await getCurrentUid())
        .onValue
        .listen((Event event) {
      var todo = new TodoChauffeur.fromJson(
          event.snapshot.key, event.snapshot.value);
      onData(todo);
    });

    return subscription;
  }
}

class Preferences {
  static const String ACCOUNT_KEY = "accountKey";

  static Future<bool> setAccountKey(String accountKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ACCOUNT_KEY, accountKey);
    return prefs.commit;
  }

  static Future<String> getAccountKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accountKey = prefs.getString(ACCOUNT_KEY);
    // workaround - simulate a login setting this
    if (accountKey == null) {
      accountKey = "21YOLwa4ITRAdUNy824AfkHBRZ23";
    }

    return accountKey;
  }
}
