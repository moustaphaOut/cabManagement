import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


import './home_page.dart';
import './profile_page.dart';
import '../widgets/info_card.dart';

const photo = 'assets/alucard.jpg';
const full_name = 'Single rider';
const rating = 3;
const job = 'Driver';
const email = 'Moustapha.out@gmail.com';
const phone = '+212 697 19 58 69';
const city = 'Rabat, Morocco';
const work_time = 'From 8 AM To 5 PM';
const username = 'moustapha_out';
const birthday = '18/05/1998';

class TrafficDriver extends StatefulWidget {
  static String tag = 'traffic-driver';
  @override
  State<StatefulWidget> createState() {
    return _TrafficDriver();
  }
}

class _TrafficDriver extends State<TrafficDriver> {
  DateTime pickedDate = DateTime.now();
  
  Future<Null> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: pickedDate,
        firstDate: DateTime(2019, 08,27),
        lastDate: selectedDate);
    if (picked != null && picked != selectedDate)
      setState(() {
        pickedDate = picked;
       FirebaseTodos.getDetailsJournalier(picked, _updateDetailsJournalier)
        .then((StreamSubscription s) => _subscriptionTodo = s);
      });
  }

  String _consommation_jour = "",
      _depense_jour = "",
      _recette_jour = "",
      _nombre_client = "",
      _km_parcouru = "",
      _heure_travaille = "";
  StreamSubscription _subscriptionTodo;
  @override
  void initState() {
    FirebaseTodos.getDetailsJournalier(pickedDate, _updateDetailsJournalier)
        .then((StreamSubscription s) => _subscriptionTodo = s);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepPurple),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.track_changes,
              semanticLabel: 'menu',
            ),
            onPressed: () {
              print('Menu button');
            },
          ),
          title: Text('My traffic'),
        ),
        body: Container(
          child: ListView(
            children: [
              Container(
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //Text("${selectedDate.toLocal()}"),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      onPressed: () { _selectDate(context);
                      },
                      child: Text('Select date'),
                    ),
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
                          DateFormat('EEEE').format(pickedDate),
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w800),
                        ),
                        new Text(
                          formatDate('dd-MM-yyyy',pickedDate),
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ]),
                  InfoCard(
                    vertical: 0.0,
                    text: _recette_jour + ' DH',
                    icon: Icons.attach_money,
                    colorText: Colors.teal,
                  ),
                  InfoCard(
                    vertical: 0.0,
                    text: _km_parcouru + ' KM',
                    icon: Icons.directions_car,
                    colorText: Colors.teal,
                  ),
                  InfoCard(
                    vertical: 0.0,
                    text: _nombre_client,
                    icon: Icons.people,
                    colorText: Colors.teal,
                  ),
                  InfoCard(
                    vertical: 0.0,
                    text:  _heure_travaille + ' H',
                    icon: Icons.timelapse,
                    colorText: Colors.teal,
                  ),
                ]),
              ),
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
          currentIndex: 1,
          onTap: (currentIndex) {
            if (currentIndex == 0)
              Navigator.of(context).pushNamedAndRemoveUntil(HomeDriver.tag,(Route<dynamic> route) => false);
            else if (currentIndex == 2)
              Navigator.of(context).pushNamedAndRemoveUntil(ProfileDriver.tag,(Route<dynamic> route) => false);
            //Navigator.of(context).pushNamed(Profile.tag);
          },
          selectedItemColor: Colors.amber[300],
        ),
      ),
    );
  }
 
  _updateDetailsJournalier(DetailsJournalier value) {
    setState(() {
      _consommation_jour = value.consommation_jour;
      _depense_jour = value.depense_jour;
      _recette_jour = value.recette_jour;
      _nombre_client = value.nombre_client;
      _km_parcouru = value.km_parcouru;
      _heure_travaille = value.heure_travaille;
    });
  }
   String getCurrentDate(String format) {
    var now = new DateTime.now();
    var formatter = new DateFormat(format);
    return formatter.format(now);
  }
  String formatDate(String format,DateTime x) {
    var formatter = new DateFormat(format);
    return formatter.format(x);
  }
}

class DetailsJournalier {
  final String key;
  String consommation_jour ='0',
      depense_jour='0',
      recette_jour='0',
      nombre_client='0',
      km_parcouru='0',
      heure_travaille='0';
  DetailsJournalier.fromJson(this.key, Map data) {
    if(data != null){
      consommation_jour =
          (data['consommation_jour'] == null ? '' : data['consommation_jour']);
      depense_jour = (data['depense_jour'] == null ? '' : data['depense_jour']);
      recette_jour = (data['recette_jour'] == null ? '' : data['recette_jour']);
      nombre_client =
          (data['nombre_client'] == null ? '' : data['nombre_client']);
      km_parcouru = (data['km_parcouru'] == null ? '' : data['km_parcouru']);
      heure_travaille =
          (data['heure_travaille'] == null ? '' : data['heure_travaille']);
    }
  }
 
}

class FirebaseTodos {
  static Future<StreamSubscription<Event>> getDetailsJournalier(DateTime filterDate,
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
        .child(_TrafficDriver().formatDate('dd_MM_yyyy',filterDate))
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
