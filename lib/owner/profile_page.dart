import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gestion_taxi/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './home_page.dart';
import '../widgets/info_card.dart';
import './traffic_owner.dart';

const photo = 'assets/alucard.jpg';
const rating = 3;
const job = 'Owner';
const city = 'Nador, Morocco';
const username = 'moustapha_out';

class ProfileOwner extends StatefulWidget {
  static String tag = 'profile-page';
  @override
  State<StatefulWidget> createState() {
    return _ProfileOwner();
  }
}

class _ProfileOwner extends State<ProfileOwner> {
  static String tag = 'profile-owner';
  Map<String, String> _agreements = {"hola": "test"};
  Map<String, String> _vehicules = {"0": "0"};
  Map<String, String> _chauffeurs = {"0": "0"};
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  List<DropdownMenuItem<String>> _dropDownMenuItemsVehicule;
  List<DropdownMenuItem<String>> _dropDownMenuItemsChauffeur;
  String _currentAgreement, _currentKeyAgreement;
  String _currentVehicule, _currentKeyVehicule;
  String _currentChauffeur, _currentKeyChauffeur;
  StreamSubscription _subscriptionTodo;
  String _cinChauffeur = "",
      _emailChauffeur = "",
      _nomChauffeur = "",
      _prenomChauffeur = "",
      _telephoneChauffeur = "",
      _dateNaissanceChauffeur = "";
  String _cinProprietaire = "",
      _emailProprietaire = "",
      _nomProprietaire = "",
      _prenomProprietaire = "";
  String _numAgreement = "",
      _dureeAgreement = "",
      _dateAgreement = "",
      _copieAgreement = "";
  String _numImmatriculation = "",
      _marqueVehicule = "",
      _modeleVehicule = "",
      _anneeModeleVehicule = "",
      _telephoneProprietaire = "",
      _dateNaissanceProprietaire = "";
  @override
  void initState() {
    FirebaseTodos.getItems(_agreements, _updateItems)
        .then((StreamSubscription s) => _subscriptionTodo = s);

    FirebaseTodos.getProprietaire(_updateProprietaire)
        .then((StreamSubscription s) => _subscriptionTodo = s);

    super.initState();
  }

  @override
  void dispose() {
    if (_subscriptionTodo != null) {
      _subscriptionTodo.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //getCurrentEmail();
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xfff00000),
            //backgroundColor: Color(0xff308e1c),
            bottom: TabBar(
              
              indicatorColor: Color(0xffff00000),
              tabs: [
                Tab(icon: new Icon(Icons.account_circle)),
                Tab(icon: new Icon(Icons.local_taxi)),
                Tab(icon: new Icon(Icons.directions_car)),
                Tab(icon: new Icon(Icons.supervised_user_circle)),
              ],
            ),
            title: Text('Information personnel'),
            actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.outlined_flag),
                onPressed: () => _signOut(),
              ),
            ],
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: ListView(
                      padding: const EdgeInsets.all(20.0),
                      children: <Widget>[
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(photo),
                        ),
                        Text(
                          _prenomProprietaire + " " + _nomProprietaire,
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
                          text: _cinProprietaire,
                          icon: Icons.web,
                          colorText: Colors.teal,
                          onPressed: () {},
                        ),
                        InfoCard(
                          text: _telephoneProprietaire,
                          icon: Icons.phone,
                          colorText: Colors.teal,
                          onPressed: () {},
                        ),
                        InfoCard(
                          text: _emailProprietaire,
                          icon: Icons.email,
                          colorText: Colors.teal,
                          onPressed: () {},
                        ),
                        InfoCard(
                          text: city,
                          colorText: Colors.teal,
                          icon: Icons.location_city,
                        ),
                        InfoCard(
                          text: username,
                          colorText: Colors.teal,
                          icon: Icons.alternate_email,
                        ),
                        InfoCard(
                          text: _dateNaissanceProprietaire,
                          colorText: Colors.teal,
                          icon: Icons.calendar_today,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: ListView(
                      padding: const EdgeInsets.all(20.0),
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            Text("Num Immatriculation: ",style: TextStyle(fontSize: 15.0,color: Colors.redAccent),),
                            DropdownButton(
                              iconEnabledColor: Colors.greenAccent,
                              value: _currentAgreement,
                              items: _dropDownMenuItems,
                              onChanged: changedDropDownItem,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                          width: 200,
                          child: Divider(
                            color: Colors.teal.shade700,
                          ),
                        ),
                        InfoCard(
                          text: _numAgreement,
                          icon: Icons.web,
                          colorText: Colors.teal,
                          onPressed: () {},
                        ),
                        InfoCard(
                          text: _dateAgreement,
                          icon: Icons.phone,
                          colorText: Colors.teal,
                          onPressed: () {},
                        ),
                        InfoCard(
                          text: _dureeAgreement,
                          icon: Icons.email,
                          colorText: Colors.teal,
                          onPressed: () {},
                        ),
                        InfoCard(
                          text: "Voir agreement",
                          colorText: Colors.teal,
                          icon: Icons.location_city,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: ListView(
                      padding: const EdgeInsets.all(20.0),
                      children: <Widget>[
                        DropdownButton(
                          value: _currentVehicule,
                          items: _dropDownMenuItemsVehicule,
                          onChanged: changedDropDownItemVehicule,
                        ),
                        SizedBox(
                          height: 20,
                          width: 200,
                          child: Divider(
                            color: Colors.teal.shade700,
                          ),
                        ),
                        InfoCard(
                          text: _numImmatriculation,
                          icon: Icons.web,
                          colorText: Colors.teal,
                          onPressed: () {},
                        ),
                        InfoCard(
                          text: _marqueVehicule,
                          icon: Icons.phone,
                          colorText: Colors.teal,
                          onPressed: () {},
                        ),
                        InfoCard(
                          text: _modeleVehicule,
                          icon: Icons.email,
                          colorText: Colors.teal,
                          onPressed: () {},
                        ),
                        InfoCard(
                          text: _anneeModeleVehicule,
                          colorText: Colors.teal,
                          icon: Icons.location_city,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: ListView(
                      padding: const EdgeInsets.all(20.0),
                      children: <Widget>[
                        DropdownButton(
                          value: _currentChauffeur,
                          items: _dropDownMenuItemsChauffeur,
                          onChanged: changedDropDownItemChauffeur,
                        ),
                        SizedBox(
                          height: 20,
                          width: 200,
                          child: Divider(
                            color: Colors.teal.shade700,
                          ),
                        ),
                        InfoCard(
                          text: _cinChauffeur,
                          icon: Icons.web,
                          colorText: Colors.teal,
                          onPressed: () {},
                        ),
                        InfoCard(
                          text: _prenomChauffeur + ' ' + _nomChauffeur,
                          icon: Icons.phone,
                          colorText: Colors.teal,
                          onPressed: () {},
                        ),
                        InfoCard(
                          text: _telephoneChauffeur,
                          icon: Icons.email,
                          colorText: Colors.teal,
                          onPressed: () {},
                        ),
                        InfoCard(
                          text: _dateNaissanceChauffeur,
                          colorText: Colors.teal,
                          icon: Icons.location_city,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
                Navigator.of(context).pushNamedAndRemoveUntil(
                    HomeOwner.tag, (Route<dynamic> route) => false);
              else if (currentIndex == 1)
                Navigator.of(context).pushNamedAndRemoveUntil(
                    TrafficOwner2.tag, (Route<dynamic> route) => false);
              //Navigator.of(context).pushNamed(Profile.tag);
            },
            selectedItemColor: Colors.amber[800],
          ),
          backgroundColor: Colors.teal[200],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems(ss) {
    List<DropdownMenuItem<String>> items = new List();
    ss.forEach((key, values) {
      items.add(new DropdownMenuItem(
          value: values, child: new Text(values), key: Key(key)));
    });
    return items;
  }

  void changedDropDownItem(String selectedAgreement) {
    setState(() {
      _currentAgreement = selectedAgreement;
      _currentKeyAgreement = _currentKeyAgreement = _agreements.keys.firstWhere(
          (k) => _agreements[k] == _currentAgreement,
          orElse: () => null);
      FirebaseTodos.getAgreement(_currentKeyAgreement, _updateAgreement)
          .then((StreamSubscription s) => _subscriptionTodo = s);
    });
  }

  void changedDropDownItemVehicule(String selectedVehicule) {
    setState(() {
      _currentVehicule = selectedVehicule;
      _currentKeyVehicule = _currentKeyVehicule = _vehicules.keys.firstWhere(
          (k) => _vehicules[k] == _currentVehicule,
          orElse: () => null);
      FirebaseTodos.getVehicule(_currentKeyVehicule, _updateVehicule)
          .then((StreamSubscription s) => _subscriptionTodo = s);
    });
  }

  void changedDropDownItemChauffeur(String selectedChauffeur) {
    setState(() {
      _currentChauffeur = selectedChauffeur;
      _currentKeyChauffeur = _currentKeyChauffeur = _chauffeurs.keys.firstWhere(
          (k) => _chauffeurs[k] == _currentChauffeur,
          orElse: () => null);
      FirebaseTodos.getChauffeur(_currentKeyChauffeur, _updateChauffeur)
          .then((StreamSubscription s) => _subscriptionTodo = s);
    });
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil(
        LoginPage.tag, (Route<dynamic> route) => false);
  }

  _updateProprietaire(TodoProprietaire value) {
    setState(() {
      _cinProprietaire = value.cinProprietaire;
      _emailProprietaire = value.emailProprietaire;
      _nomProprietaire = value.nomProprietaire;
      _prenomProprietaire = value.prenomProprietaire;
      _telephoneProprietaire = value.telephoneProprietaire;
      _dateNaissanceProprietaire = value.dateNaissanceProprietaire;
    });
  }

  _updateAgreement(TodoAgreement value) {
    setState(() {
      _numAgreement = value.numAgreement;
      _dateAgreement = value.dateAgreement;
      _dureeAgreement = value.dureeAgreement;
      _copieAgreement = value.copieAgreement;
    });
  }

  _updateVehicule(TodoVehicule value) {
    setState(() {
      _numImmatriculation = value.numImmatriculation;
      _marqueVehicule = value.marqueVehicule;
      _modeleVehicule = value.modeleVehicule;
      _anneeModeleVehicule = value.anneeModeleVehicule;
    });
  }

  _updateChauffeur(TodoChauffeur value) {
    setState(() {
      _cinChauffeur = value.cinChauffeur;
      _emailChauffeur = value.emailChauffeur;
      _nomChauffeur = value.nomChauffeur;
      _prenomChauffeur = value.prenomChauffeur;
      _telephoneChauffeur = value.telephoneChauffeur;
      _dateNaissanceChauffeur = value.dateNaissanceChauffeur;
    });
  }

  _updateItems(TodoItems value) {
    setState(() {
      _agreements = value.agremments;
      _dropDownMenuItems = getDropDownMenuItems(_agreements);
      _currentAgreement = _dropDownMenuItems[0].value;
      _currentKeyAgreement = _agreements.keys.firstWhere(
          (k) => _agreements[k] == _currentAgreement,
          orElse: () => null);
      FirebaseTodos.getAgreement(_currentKeyAgreement, _updateAgreement)
          .then((StreamSubscription s) => _subscriptionTodo = s);

      _vehicules = value.vehicules;
      _dropDownMenuItemsVehicule = getDropDownMenuItems(_vehicules);
      _currentVehicule = _dropDownMenuItemsVehicule[0].value;
      _currentKeyVehicule = _vehicules.keys.firstWhere(
          (k) => _vehicules[k] == _currentVehicule,
          orElse: () => null);
      FirebaseTodos.getVehicule(_currentKeyVehicule, _updateVehicule)
          .then((StreamSubscription s) => _subscriptionTodo = s);

      _chauffeurs = value.chauffeurs;
      _dropDownMenuItemsChauffeur = getDropDownMenuItems(_chauffeurs);
      _currentChauffeur = _dropDownMenuItemsChauffeur[0].value;
      _currentKeyChauffeur = _chauffeurs.keys.firstWhere(
          (k) => _chauffeurs[k] == _currentChauffeur,
          orElse: () => null);
      FirebaseTodos.getChauffeur(_currentKeyChauffeur, _updateChauffeur)
          .then((StreamSubscription s) => _subscriptionTodo = s);
    });
  }
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

class TodoProprietaire {
  final String key;
  String cinProprietaire,
      emailProprietaire,
      nomProprietaire,
      prenomProprietaire,
      telephoneProprietaire,
      dateNaissanceProprietaire;
  TodoProprietaire.fromJson(this.key, Map data) {
    cinProprietaire =
        (data['cin_proprietaire'] == null ? '' : data['cin_proprietaire']);
    emailProprietaire =
        (data['email_proprietaire'] == null ? '' : data['email_proprietaire']);
    nomProprietaire =
        (data['nom_proprietaire'] == null ? '' : data['nom_proprietaire']);
    prenomProprietaire = (data['prenom_proprietaire'] == null
        ? ''
        : data['prenom_proprietaire']);
    telephoneProprietaire = (data['telephone_proprietaire'] == null
        ? ''
        : data['telephone_proprietaire']);
    dateNaissanceProprietaire = (data['date_naissance_proprietaire'] == null
        ? ''
        : data['date_naissance_proprietaire']);
  }
}

class TodoAgreement {
  final String key;
  String numAgreement, dureeAgreement, dateAgreement, copieAgreement;
  TodoAgreement.fromJson(this.key, Map data) {
    numAgreement = (data['num_agreement'] == null ? '' : data['num_agreement']);
    dateAgreement =
        (data['date_agreement'] == null ? '' : data['date_agreement']);
    dureeAgreement =
        (data['duree_agreement'] == null ? '' : data['duree_agreement']);
    copieAgreement =
        (data['copie_agreement'] == null ? '' : data['copie_agreement']);
  }
}

class TodoVehicule {
  final String key;
  String numImmatriculation,
      anneeModeleVehicule,
      marqueVehicule,
      modeleVehicule;
  TodoVehicule.fromJson(this.key, Map data) {
    numImmatriculation = (data['num_immatriculation'] == null
        ? ''
        : data['num_immatriculation']);
    anneeModeleVehicule = (data['annee_modele_vehicule'] == null
        ? ''
        : data['annee_modele_vehicule']);
    marqueVehicule =
        (data['marque_vehicule'] == null ? '' : data['marque_vehicule']);
    modeleVehicule =
        (data['modele_vehicule'] == null ? '' : data['modele_vehicule']);
  }
}

class TodoChauffeur {
  final String key;
  String cinChauffeur,
      emailChauffeur,
      nomChauffeur,
      prenomChauffeur,
      telephoneChauffeur,
      dateNaissanceChauffeur;
  TodoChauffeur.fromJson(this.key, Map data) {
    cinChauffeur = (data['cin_chauffeur'] == null ? '' : data['cin_chauffeur']);
    emailChauffeur =
        (data['email_chauffeur'] == null ? '' : data['email_chauffeur']);
    nomChauffeur = (data['nom_chauffeur'] == null ? '' : data['nom_chauffeur']);
    prenomChauffeur =
        (data['prenom_chauffeur'] == null ? '' : data['prenom_chauffeur']);
    telephoneChauffeur = (data['telephone_chauffeur'] == null
        ? ''
        : data['telephone_chauffeur']);
    dateNaissanceChauffeur = (data['date_naissance_chauffeur'] == null
        ? ''
        : data['date_naissance_chauffeur']);
  }
}

class TodoItems {
  final String key;
  Map<String, String> agremments = {};
  Map<String, String> vehicules = {};
  Map<String, String> chauffeurs = {};
  TodoItems.fromJson(this.key, Map data) {
    Map mapChauffeurs;
    for (int i = 0; i < data.keys.toList().length; i++) {
      agremments[data.keys.toList()[i].toString()] =
          data.values.toList()[i]["num_agreement"];

      vehicules[data.keys.toList()[i].toString()] =
          data.values.toList()[i]["vehicule"]["num_immatriculation"];

      mapChauffeurs = data.values.toList()[i]["vehicule"]["chauffeur"];
      if (mapChauffeurs != null)
        for (int j = 0; j < mapChauffeurs.keys.toList().length; j++)
          chauffeurs[mapChauffeurs.keys.toList()[j].toString()] =
              mapChauffeurs.values.toList()[j]["nom_chauffeur"];
    }
  }
}

class FirebaseTodos {
  static Future<StreamSubscription<Event>> getItems(
      Map agreements, void onData(TodoItems todo)) async {
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

  static Future<StreamSubscription<Event>> getProprietaire(
      void onData(TodoProprietaire todo)) async {
    String accountKey = await Preferences.getAccountKey();

    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child("proprietaire")
        .child(accountKey)
        .onValue
        .listen((Event event) {
      var todo = new TodoProprietaire.fromJson(
          event.snapshot.key, event.snapshot.value);
      onData(todo);
    });

    return subscription;
  }

  static Future<StreamSubscription<Event>> getAgreement(
      String todoKey, void onData(TodoAgreement todo)) async {
    String accountKey = await Preferences.getAccountKey();
    if (todoKey != null) {
      StreamSubscription<Event> subscription = FirebaseDatabase.instance
          .reference()
          .child("proprietaire")
          .child(accountKey)
          .child("agreement")
          .child(todoKey) //todoKey
          .onValue
          .listen((Event event) {
        var todo = new TodoAgreement.fromJson(
            event.snapshot.key, event.snapshot.value);
        onData(todo);
      });

      return subscription;
    }
  }

  static Future<StreamSubscription<Event>> getVehicule(
      String todoKey, void onData(TodoVehicule todo)) async {
    String accountKey = await Preferences.getAccountKey();
    if (todoKey != null) {
      StreamSubscription<Event> subscription = FirebaseDatabase.instance
          .reference()
          .child("proprietaire")
          .child(accountKey)
          .child("agreement")
          .child(todoKey) //todoKey
          .child("vehicule")
          .onValue
          .listen((Event event) {
        var todo =
            new TodoVehicule.fromJson(event.snapshot.key, event.snapshot.value);
        onData(todo);
      });

      return subscription;
    }
  }

  static Future<StreamSubscription<Event>> getChauffeur(
      String currentKeyChauffer, void onData(TodoChauffeur todo)) async {
    String accountKey = await Preferences.getAccountKey();

    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child("proprietaire")
        .child(accountKey)
        .child("agreement")
        .child("agr1")
        .child("vehicule")
        .child("chauffeur")
        .child(currentKeyChauffer)
        .onValue
        .listen((Event event) {
      var todo =
          new TodoChauffeur.fromJson(event.snapshot.key, event.snapshot.value);
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
