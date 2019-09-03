import 'dart:async';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/info_card.dart';
import './profile_page.dart';
import './traffic_page.dart';

class HomeDriver extends StatefulWidget {
  static String tag = 'home-driver';
  @override
  State<StatefulWidget> createState() {
    return _HomeDriver();
  }
}

class _HomeDriver extends State<HomeDriver> {
  //var now = formatDate(DateTime(2019, 08, 29), [dd, '_', mm, '_', yyyy]);
  String  _consommationJour = "0",
      _depenseJour = "0",
      _recetteJour = "0",
      _nombreClient = "0",
      _kmParcouru = "0",
      _heureTravaille = "0";
  StreamSubscription _subscriptionTodo;
  @override
  void initState() {
    FirebaseTodos.getDetailsJournalier(_updateDetailsJournalier)
        .then((StreamSubscription s) => _subscriptionTodo = s);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 0, 0, 0.7),
        leading: IconButton(
          icon: Icon(
            Icons.bluetooth,
          ),
          onPressed: () {},
        ),
        title: Text('Connected'),
        actions: <Widget>[
          Center(
            child: new Text("Riding"),
          ),
          new IconButton(
            icon: new Icon(Icons.check),
            onPressed: () => {},
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 7.0),
        child: ListView(
          children: [
            Text(
              "Message",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.all(5.0),
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(),
              ),
              child: Column(
                children: [
                  Text("Everything is going fine",
                      style: TextStyle(fontSize: 18, color: Colors.green)),
                  Text("Enable your bluetooth",
                      style: TextStyle(fontSize: 18, color: Colors.red)),
                ],
              ),
            ),
            Divider(),
            Container(
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.all(0.0),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(),
              child: Column(children: [
                new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new Text(
                        "Today",
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w800),
                      ),
                      new Text(
                        getCurrentDate('dd-MM-yyyy'),
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ]),
                InfoCard(
                  vertical: 0.0,
                  text: _recetteJour + ' DH',
                  icon: Icons.attach_money,
                  colorText: Colors.teal,
                ),
                InfoCard(
                  vertical: 0.0,
                  text: _kmParcouru + ' KM',
                  icon: Icons.directions_car,
                  colorText: Colors.teal,
                ),
                InfoCard(
                  vertical: 0.0,
                  text: _nombreClient,
                  icon: Icons.people,
                  colorText: Colors.teal,
                ),
                InfoCard(
                  vertical: 0.0,
                  text: _heureTravaille + ' H',
                  icon: Icons.timelapse,
                  colorText: Colors.teal,
                ),
              ]),
            ),
            //Divider(),
          ],
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
        currentIndex: 0,
        onTap: (currentIndex) {
          if (currentIndex == 2)
            Navigator.of(context).pushNamedAndRemoveUntil(
                ProfileDriver.tag, (Route<dynamic> route) => false);
          else if (currentIndex == 1)
            Navigator.of(context).pushNamedAndRemoveUntil(
                TrafficDriver.tag, (Route<dynamic> route) => false);
          //Navigator.of(context).pushNamed(Profile.tag);
        },
        selectedItemColor: Colors.amber[800],
      ),
    );
  }

  _updateDetailsJournalier(DetailsJournalier value) {
    setState(() {
      _consommationJour = value.consommationJour;
      _depenseJour = value.depenseJour;
      _recetteJour = value.recetteJour;
      _nombreClient = value.nombreClient;
      _kmParcouru = value.kmParcouru;
      _heureTravaille = value.heureTravaille;
    });
  }

  String getCurrentDate(String format) {
    var now = new DateTime.now();
    var formatter = new DateFormat(format);
    return formatter.format(now);
  }
}

class DetailsJournalier {
  final String key;
  String consommationJour = '0',
      depenseJour = '0',
      recetteJour = '0',
      nombreClient = '0',
      kmParcouru = '0',
      heureTravaille = '0';
  DetailsJournalier.fromJson(this.key, Map data) {
    if (data != null) {
      consommationJour =
          (data['consommation_jour'] == null ? '' : data['consommation_jour']);
      depenseJour = (data['depense_jour'] == null ? '' : data['depense_jour']);
      recetteJour = (data['recette_jour'] == null ? '' : data['recette_jour']);
      nombreClient =
          (data['nombre_client'] == null ? '' : data['nombre_client']);
      kmParcouru = (data['km_parcouru'] == null ? '' : data['km_parcouru']);
      heureTravaille =
          (data['heure_travaille'] == null ? '' : data['heure_travaille']);
    }
  }
}

class FirebaseTodos {
  static Future<StreamSubscription<Event>> getDetailsJournalier(
      void onData(DetailsJournalier todo)) async {
    String accountKey = await Preferences.getAccountKey();
    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child("proprietaire")
        .child(accountKey)
        .child("agreement")
        .child("agr1")
        .child("vehicule")
        .child("chauffeur")
        .child("cha1") //.child(await getCurrentUid())
        .child("details_journalier")
        .child(_HomeDriver().getCurrentDate('dd_MM_yyyy'))
        .onValue
        .listen((Event event) {
      var todo = new DetailsJournalier.fromJson(
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
