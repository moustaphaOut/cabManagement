import 'dart:async';
import 'package:intl/intl.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/info_card.dart';
import './profile_page.dart';
import './traffic_owner.dart';

class HomeOwner extends StatefulWidget {
  static String tag = 'home-owner';
  @override
  State<StatefulWidget> createState() {
    return _HomeOwner();
  }
}

class _HomeOwner extends State<HomeOwner> {
  List vehicules = [
    "Moustapha",
    "Hassan",
  ];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentVehicule;

  String _consommation_jour = "",
      _depense_jour = "",
      _recette_jour = "",
      _nombre_client = "",
      _km_parcouru = "",
      _heure_travaille = "";
  StreamSubscription _subscriptionTodo;

  @override
  void initState() {
    initVehicules();

    FirebaseTodos.getDetailsJournalier(_currentVehicule, pickedDate, _updateDetailsJournalier)
        .then((StreamSubscription s) => _subscriptionTodo = s);

    super.initState();
  }

  DateTime pickedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: pickedDate,
        firstDate: DateTime(2019, 08, 27),
        lastDate: selectedDate);
    if (picked != null && picked != selectedDate)
      setState(() {
        pickedDate = picked;
        FirebaseTodos.getDetailsJournalier(_currentVehicule, picked, _updateDetailsJournalier)
            .then((StreamSubscription s) => _subscriptionTodo = s);
      });
  }

  final databaseReference = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 0, 0, 0.7),
        title: Text('Home'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.supervised_user_circle),
            onPressed: () => _onAlertButtonPressed(context),
          ),
          Center(
            child: new Text("1/3"),
          ),
          new IconButton(
            icon: new Icon(Icons.message),
            onPressed: () => {},
          ),
          Center(
            child: new Text("1"),
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
                  Text("sensor_1 of ahmed doesn't work",
                      style: TextStyle(fontSize: 18, color: Colors.red)),
                  Text("Simo didn't ride this day !",
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    //Text("${selectedDate.toLocal()}"),
                    DropdownButton(
                      value: _currentVehicule,
                      items: _dropDownMenuItems,
                      onChanged: changedDropDownItem,
                    ),
                    RaisedButton(
                      onPressed: () => _selectDate(context),
                      child: Text(formatDate('dd-MM-yyyy', pickedDate)),
                    ),
                  ],
                ),
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
                  text: _heure_travaille + ' H',
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
        onTap: (currentIndex) {
          if (currentIndex == 2)
            Navigator.of(context).pushNamedAndRemoveUntil(ProfileOwner.tag,(Route<dynamic> route) => false);
          else if (currentIndex == 1)
            Navigator.of(context).pushNamedAndRemoveUntil(TrafficOwner2.tag,(Route<dynamic> route) => false);
          //Navigator.of(context).pushNamed(Profile.tag);
        },
        selectedItemColor: Colors.amber[800],
      ),
    );
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      _currentVehicule = selectedCity;
       FirebaseTodos.getDetailsJournalier(_currentVehicule, pickedDate, _updateDetailsJournalier)
            .then((StreamSubscription s) => _subscriptionTodo = s);
    });
  }

  void initVehicules() {
    var ref = FirebaseDatabase.instance
        .reference()
        .child("proprietaire")
        .child("21YOLwa4ITRAdUNy824AfkHBRZ23")
        .child("agreement");
    ref.orderByKey().once().then((onValue) {
      Map<dynamic, dynamic> map = onValue.value;
      //print(map.keys);
      print("------------1----------------");
      
      setState(() {
        vehicules.add(map.values.toList()[0]["vehicule"]["num_immatriculation"]);
        vehicules.add(map.values.toList()[1]["vehicule"]["num_immatriculation"]);
      });
      print("------------2----------------");
    });

    List<DropdownMenuItem<String>> getDropDownMenuItems() {
      List<DropdownMenuItem<String>> items = new List();
      for (String vehicule in vehicules) {
        items.add(
            new DropdownMenuItem(value: vehicule, child: new Text(vehicule)));
      }
      return items;
    }
    _dropDownMenuItems = getDropDownMenuItems();
    _currentVehicule = _dropDownMenuItems[0].value;
  }

  // Alert with single button.
  _onAlertButtonPressed(context) {
    Alert(
      context: context,
      title: "Drivers 1/3",
      desc: "simo Riding\n Ahmed free\n Yasine free",
      buttons: [
        DialogButton(
          child: Text(
            "COOL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        ),
      ],
    ).show();
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

  String formatDate(String format, DateTime x) {
    var formatter = new DateFormat(format);
    return formatter.format(x);
  }
}

class DetailsJournalier {
  final String key;
  String consommation_jour = '0',
      depense_jour = '0',
      recette_jour = '0',
      nombre_client = '0',
      km_parcouru = '0',
      heure_travaille = '0';
  DetailsJournalier.fromJson(this.key, Map data) {
    if (data != null) {
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
  static Future<StreamSubscription<Event>> getDetailsJournalier(String _currentVehicule,
      DateTime filterDate, void onData(DetailsJournalier todo)) async {
    String accountKey = await Preferences.getAccountKey();
    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child("proprietaire")
        .child(accountKey)
        .child("agreement")
        .child("agr1")
        .child("vehicule")
        .child("chauffeur")
        .child(_currentVehicule) //.child(await getCurrentUid())
        .child("details_journalier")
        .child(_HomeOwner().formatDate('dd_MM_yyyy', filterDate))
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
    return prefs.commit();
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

//-----------------------QUERY------------------------------
/*
//-------------select * from proprietaire where nom_proprietaire='med';
var ref = FirebaseDatabase.instance.reference().child("proprietaire");
    ref.orderByChild("nom_proprietaire").equalTo('med').once().then((snap) {
      print(snap.value);
    });
*/
//----------------------- END ------------------------------
/* map.forEach((key, values) {
        ref.child(key).child("vehicule").once().then((onValue2) {
          print(onValue2.value['num_immatriculation']);
          vehicules.add(onValue2.value['num_immatriculation']);
        });
      //});*/
/*
var ref = FirebaseDatabase.instance.reference().child("proprietaire").child("21YOLwa4ITRAdUNy824AfkHBRZ23").child("agreement");
    ref.orderByKey().once().then((onValue) {
      Map<dynamic, dynamic> map = onValue.value;
          print("----------------------------");

        map.forEach((key,values) {
          print("key: "+key);
          ref.child(key).child("vehicule").once().then((onValue2) {
            Map<dynamic, dynamic> map2 = onValue2.value;
            map2.forEach((key2,values2) {
              print("value: "+values2['num_immatriculation']);
            });
          });
        });
          print("----------------------------");

    });
*/
