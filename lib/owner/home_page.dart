import 'dart:async';
import 'package:unicorndial/unicorndial.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart';
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
  List<int> _drivers = [0, 0];
  List<Widget> _content;
  Map<String, String> _chauffeurs = {"hola": "test"};
  Map<String, String> _vehicules = {"hola": "test"};
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  List<DropdownMenuItem<String>> _dropDownMenuItemsVehicule;
  String _currentChauffeur, _currentKeyChauffeur;
  String _currentVehicule, _currentKeyVehicule;
  var _childButtons = List<UnicornButton>();

  String _consommationJour = "0",
      _depenseJour = "0",
      _recetteJour = "0",
      _nombreClient = "0",
      _kmParcouru = "0",
      _heureTravaille = "0",
      _numImmatriculation = "0";
  StreamSubscription _subscriptionTodo;

  @override
  void initState() {
    FirebaseTodos.getItems(_updateItems)
        .then((StreamSubscription s) => _subscriptionTodo = s);

    super.initState();
  }

  DateTime pickedDate = DateTime.now();

  final databaseReference = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: UnicornDialer(
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
          parentButtonBackground: Color.fromRGBO(2,238,238,1),
          orientation: UnicornOrientation.VERTICAL,
          parentButton: Icon(Icons.supervised_user_circle),
          childButtons: _childButtons),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 0, 0, 0.7),
        title: Text('Home'),
        actions: <Widget>[
          Badge(
            badgeContent: Text('1'),
            child: Icon(
              Icons.notification_important,
              size: 30,
            ),
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
                  //Text("sensor_1 of ahmed doesn't work",
                     // style: TextStyle(fontSize: 18, color: Colors.red)),
                  Text("Keep going !",
                      style: TextStyle(fontSize: 18, color: Colors.green)),
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
                    /*DropdownButton(
                      value: _currentVehicule,
                      items: _dropDownMenuItemsVehicule,
                      onChanged: changedDropDownItemVehicule,
                    ),*/
                    RaisedButton(
                      onPressed: () => _selectDate(context),
                      child: Text(formatDate('dd-MM-yyyy', pickedDate)),
                      color: Colors.green,
                      textTheme: ButtonTextTheme.primary,
                    ),
                    DropdownButton(
                      iconEnabledColor: Colors.green,
                      value: _currentChauffeur,
                      items: _dropDownMenuItems,
                      onChanged: changedDropDownItem,
                    ),
                  ],
                ),
                InfoCard(
                  vertical: 0.0,
                  text: "Num Immatriculation: " + _numImmatriculation,
                  icon: Icons.local_taxi,
                  colorText: Colors.black,
                ),
                InfoCard(
                  vertical: 0.0,
                  text: _recetteJour + ' DH',
                  icon: Icons.monetization_on,
                  colorText: Colors.teal,
                ),
                InfoCard(
                  vertical: 0.0,
                  text: _kmParcouru + ' KM',
                  icon: Icons.multiline_chart,
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
        //backgroundColor: ,
        onTap: (currentIndex) {
          if (currentIndex == 2)
            Navigator.of(context).pushNamedAndRemoveUntil(
                ProfileOwner.tag, (Route<dynamic> route) => false);
          else if (currentIndex == 1)
            Navigator.of(context).pushNamedAndRemoveUntil(
                TrafficOwner2.tag, (Route<dynamic> route) => false);
          //Navigator.of(context).pushNamed(Profile.tag);
        },
        selectedItemColor: Colors.amber[800],
      ),
    );
  }

  void changedDropDownItem(String selectedChauffeur) {
    setState(() {
      _currentChauffeur = selectedChauffeur;
      _currentKeyChauffeur = _chauffeurs.keys.firstWhere(
          (k) => _chauffeurs[k] == _currentChauffeur,
          orElse: () => null);
      FirebaseTodos.getDetailsJournalier(
              _currentKeyChauffeur, pickedDate, _updateDetailsJournalier)
          .then((StreamSubscription s) => _subscriptionTodo = s);
    });
  }

  void changedDropDownItemVehicule(String selectedVehicule) {
    setState(() {
      _currentVehicule = selectedVehicule;
      _currentKeyVehicule = _vehicules.keys.firstWhere(
          (k) => _vehicules[k] == _currentVehicule,
          orElse: () => null);
      FirebaseTodos.getDetailsJournalier(
              _currentKeyChauffeur, pickedDate, _updateDetailsJournalier)
          .then((StreamSubscription s) => _subscriptionTodo = s);
    });
  }

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
        FirebaseTodos.getDetailsJournalier(
                _currentKeyChauffeur, picked, _updateDetailsJournalier)
            .then((StreamSubscription s) => _subscriptionTodo = s);
      });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems(ss) {
    List<DropdownMenuItem<String>> items = new List();
    ss.forEach((key, values) {
      items.add(new DropdownMenuItem(
          value: values, child: new Text(values), key: Key(key)));
    });
    return items;
  }

  // Alert with single button.
  _onAlertButtonPressed(context) {
    Alert(
      context: context,
      title:
          "Chauffeurs " + _drivers[1].toString() + "/" + _drivers[0].toString(),
      content: Column(
        children: _content,
      ),
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
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
      _consommationJour = value.consommationJour;
      _depenseJour = value.depenseJour;
      _recetteJour = value.recetteJour;
      _nombreClient = value.nombreClient;
      _kmParcouru = value.kmParcouru;
      _heureTravaille = value.heureTravaille;
      _numImmatriculation = value.numImmatriculation;
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

  _updateItems(TodoItems value) {
    setState(() {
      _childButtons = value.childButtons;
      _drivers = value.nbDrivers;
      _content = value.content;

      _chauffeurs = value.chauffeurs;
      _dropDownMenuItems = getDropDownMenuItems(_chauffeurs);
      _currentChauffeur = _dropDownMenuItems[0].value;
      _currentKeyChauffeur = _chauffeurs.keys.firstWhere(
          (k) => _chauffeurs[k] == _currentChauffeur,
          orElse: () => null);

      _vehicules = value.vehicules;
      _dropDownMenuItemsVehicule = getDropDownMenuItems(_vehicules);
      _currentVehicule = _dropDownMenuItemsVehicule[0].value;
      _currentKeyVehicule = _vehicules.keys.firstWhere(
          (k) => _vehicules[k] == _currentVehicule,
          orElse: () => null);
    });
  }
}

class DetailsJournalier {
  final String key;
  String consommationJour = '0',
      depenseJour = '0',
      recetteJour = '0',
      nombreClient = '0',
      kmParcouru = '0',
      heureTravaille = '0',
      numImmatriculation = "0";
  DetailsJournalier.fromJson(
      this.key, Map data, String currentKeyChauffeur, String filterDate) {
    var mapChauffeurs;
    if (data != null) {
      for (int i = 0; i < data.keys.toList().length; i++) {
        if (data.values.toList()[i]["vehicule"]["chauffeur"]
                [currentKeyChauffeur] !=
            null) {
          numImmatriculation =
              data.values.toList()[i]["vehicule"]["num_immatriculation"];
          mapChauffeurs = data.values.toList()[i]["vehicule"]["chauffeur"]
              [currentKeyChauffeur];
          print(mapChauffeurs);
          print("--------------------------");
          consommationJour = mapChauffeurs["details_journalier"][filterDate]
              ["consommation_jour"];
          depenseJour =
              mapChauffeurs["details_journalier"][filterDate]["depense_jour"];
          recetteJour =
              mapChauffeurs["details_journalier"][filterDate]["recette_jour"];
          nombreClient =
              mapChauffeurs["details_journalier"][filterDate]["nombre_client"];
          kmParcouru =
              mapChauffeurs["details_journalier"][filterDate]["km_parcouru"];
          heureTravaille = mapChauffeurs["details_journalier"][filterDate]
              ["heure_travaille"];
          break;
        }
      }
    }
  }
}

class TodoItems {
  final String key;
  Map<String, String> chauffeurs = {};
  Map<String, String> vehicules = {};
  String text = '';
  int actif = 0;
  int nbChauffeur = 0;
  List<int> nbDrivers = [];
  List<Widget> content = new List();
  var childButtons = List<UnicornButton>();
  TodoItems.fromJson(this.key, Map data) {
    Map mapChauffeurs;
    for (int i = 0; i < data.keys.toList().length; i++) {
      vehicules[data.keys.toList()[i].toString()] =
          data.values.toList()[i]["vehicule"]["num_immatriculation"];

      mapChauffeurs = data.values.toList()[i]["vehicule"]["chauffeur"];
      if (mapChauffeurs != null) {
        var iconImage;
        nbChauffeur += mapChauffeurs.keys.toList().length;
        for (int j = 0; j < mapChauffeurs.keys.toList().length; j++) {
          chauffeurs[mapChauffeurs.keys.toList()[j].toString()] =
              mapChauffeurs.values.toList()[j]["nom_chauffeur"];
          actif += mapChauffeurs.values.toList()[j]["statut_chauffeur"];
          if (mapChauffeurs.values.toList()[j]["photo_chauffeur"] == null ||
              mapChauffeurs.values
                  .toList()[j]["photo_chauffeur"]
                  .toString()
                  .isEmpty)
            iconImage = new Icon(Icons.person_pin);
          else
            iconImage = new Image.asset(
                mapChauffeurs.values.toList()[j]["photo_chauffeur"]);
          if (mapChauffeurs.values.toList()[j]["statut_chauffeur"] == 1)
            childButtons.add(UnicornButton(
                hasLabel: true,
                labelText: mapChauffeurs.values.toList()[j]["nom_chauffeur"],
                currentButton: FloatingActionButton(
                  heroTag: "1",
                  backgroundColor: Colors.grey,
                  mini: true,
                  child: Badge(
                      badgeColor: Colors.greenAccent,
                      badgeContent: Text(' '),
                      child: iconImage),
                  onPressed: () {},
                )));
          else
            childButtons.add(UnicornButton(
                hasLabel: true,
                labelText: mapChauffeurs.values.toList()[j]["nom_chauffeur"],
                currentButton: FloatingActionButton(
                  heroTag: "0",
                  backgroundColor: Colors.redAccent,
                  mini: true,
                  child: Badge(
                      badgeColor: Colors.redAccent,
                      badgeContent: Text(' '),
                      child: iconImage),
                  onPressed: () {},
                )));
        }
      }
    }
    nbDrivers.add(nbChauffeur);
    nbDrivers.add(actif);
  }
}

class FirebaseTodos {
  static Future<StreamSubscription<Event>> getItems(
      void onData(TodoItems todo)) async {
    String accountKey = await Preferences.getAccountKey();
    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child("proprietaire")
        .child(accountKey)
        .child("agreement")
        .orderByKey()
        .onValue
        .listen((Event event) {
      var todo =
          new TodoItems.fromJson(event.snapshot.key, event.snapshot.value);
      onData(todo);
    });

    return subscription;
  }

  static Future<StreamSubscription<Event>> getDetailsJournalier(
      String currentKeyChauffeur,
      DateTime filterDate,
      void onData(DetailsJournalier todo)) async {
    String accountKey = await Preferences.getAccountKey();
    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child("proprietaire")
        .child(accountKey)
        .child("agreement")
        .onValue
        .listen((Event event) {
      var todo = new DetailsJournalier.fromJson(
          event.snapshot.key,
          event.snapshot.value,
          currentKeyChauffeur,
          _HomeOwner().formatDate('dd_MM_yyyy', filterDate));

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
      accountKey = await getCurrentUid();
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
