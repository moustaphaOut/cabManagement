import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './home_page.dart';
import '../widgets/info_card.dart';
import '../model/proprietaire.dart';
import './traffic_page.dart';

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

  
  //final databaseReference = FirebaseDatabase.instance.reference();
  StreamSubscription _subscriptionTodo;

  String _cin_proprietaire = "", _email_proprietaire ="",_nom_proprietaire = "",_prenom_proprietaire ="";
  String _num_agreement = "", _duree_agreement ="",_date_agreement = "",_copie_agreemen ="";
  String _num_immatriculation = "", _marque_vehicule ="",_modele_vehicule = "",_annee_modele_vehicule ="",_telephone_proprietaire ="",_date_naissance_proprietaire ="";
  @override
  void initState() {
    //FirebaseTodos.getTodo("-KriJ8Sg4lWIoNswKWc4").then(_updateTodo);
    FirebaseTodos.getProprietaire(_updateProprietaire)
        .then((StreamSubscription s) => _subscriptionTodo = s);
    FirebaseTodos.getAgreement("agr1", _updateAgreement)
        .then((StreamSubscription s) => _subscriptionTodo = s);
    FirebaseTodos.getVehicule("agr1", _updateVehicule)
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
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xfff00000),
            //backgroundColor: Color(0xff308e1c),
            bottom: TabBar(
              indicatorColor: Color(0xffff00000),
              tabs: [
                Tab(text: "Profile"),
                Tab(text: "Agreement"),
                Tab(text: "Vehicule"),
              ],
            ),
            title:  Text('Information personnel'),
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
                          _prenom_proprietaire+" "+_nom_proprietaire,
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
                          text: _cin_proprietaire,
                          icon: Icons.web,
                          colorText: Colors.teal,
                          onPressed: () {},
                        ),
                        InfoCard(
                          text: _telephone_proprietaire,
                          icon: Icons.phone,
                          colorText: Colors.teal,
                          onPressed: () {},
                        ),
                        InfoCard(
                          text: _email_proprietaire,
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
                          text: _date_naissance_proprietaire,
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
                        Text(
                          "Agreement",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Pacifico',
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
                          text: _num_agreement,
                          icon: Icons.web,
                          colorText: Colors.teal,
                          onPressed: () {},
                        ),
                        InfoCard(
                          text: _date_agreement,
                          icon: Icons.phone,
                          colorText: Colors.teal,
                          onPressed: () {},
                        ),
                        InfoCard(
                          text: _duree_agreement,
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
                        Text(
                          "Vehicule",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Pacifico',
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
                          text: _num_immatriculation,
                          icon: Icons.web,
                          colorText: Colors.teal,
                          onPressed: () {},
                        ),
                        InfoCard(
                          text: _marque_vehicule,
                          icon: Icons.phone,
                          colorText: Colors.teal,
                          onPressed: () {},
                        ),
                        InfoCard(
                          text: _modele_vehicule,
                          icon: Icons.email,
                          colorText: Colors.teal,
                          onPressed: () {},
                        ),
                        InfoCard(
                          text: _annee_modele_vehicule,
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
            onTap: (currentIndex) {
              if (currentIndex == 0)
                Navigator.of(context).pushNamed(HomeOwner.tag);
              else if (currentIndex == 1)
                Navigator.of(context).pushNamed(TrafficOwner.tag);
              //Navigator.of(context).pushNamed(Profile.tag);
            },
            selectedItemColor: Colors.amber[800],
          ),
          backgroundColor: Colors.teal[200],
        ),
      ),
    );
  }

 _updateProprietaire(TodoProprietaire value) {
    setState((){
      _cin_proprietaire = value.cin_proprietaire;
      _email_proprietaire = value.email_proprietaire;
      _nom_proprietaire = value.nom_proprietaire;
      _prenom_proprietaire = value.prenom_proprietaire;
     _telephone_proprietaire = value.telephone_proprietaire;
     _date_naissance_proprietaire = value.date_naissance_proprietaire;
    });
  }
  _updateAgreement(TodoAgreement value) {
    setState((){
      _num_agreement = value.num_agreement;
      _date_agreement = value.date_agreement;
      _duree_agreement = value.duree_agreement;
      _copie_agreemen = value.copie_agreemen;
    });
  }
    _updateVehicule(TodoVehicule value) {
    setState((){
      _num_immatriculation = value.num_immatriculation;
      _marque_vehicule = value.marque_vehicule;
      _modele_vehicule = value.modele_vehicule;
      _annee_modele_vehicule = value.annee_modele_vehicule;
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
  print("-------------------rrrrr");
  print(uid);
  print("----------------/---------------------");
  return uid;
}
class TodoProprietaire {
  final String key;
  String cin_proprietaire,email_proprietaire,nom_proprietaire,prenom_proprietaire,telephone_proprietaire,date_naissance_proprietaire;
  TodoProprietaire.fromJson(this.key, Map data) {
    cin_proprietaire = (data['CIN_proprietaire']== null? '': data['CIN_proprietaire']);
    email_proprietaire = (data['email_proprietaire']== null? '': data['email_proprietaire']);
    nom_proprietaire = (data['nom_proprietaire']== null? '': data['nom_proprietaire']);
    prenom_proprietaire = (data['prenom_proprietaire']== null? '': data['prenom_proprietaire']);
    telephone_proprietaire = (data['telephone_proprietaire']== null? '': data['telephone_proprietaire']);
    date_naissance_proprietaire = (data['date_naissance_proprietaire']== null? '': data['date_naissance_proprietaire']);
  }
}

class TodoAgreement {
  final String key;
  String num_agreement,duree_agreement,date_agreement,copie_agreemen;
  TodoAgreement.fromJson(this.key, Map data) {
    num_agreement = (data['num_agreement']== null? '': data['num_agreement']);
    date_agreement = (data['date_agreement']== null? '': data['date_agreement']);
    duree_agreement = (data['duree_agreement']== null? '': data['duree_agreement']);
    copie_agreemen = (data['copie_agreement']== null? '': data['copie_agreement']);
  }
}
class TodoVehicule {
  final String key;
  String num_immatriculation,annee_modele_vehicule,marque_vehicule,modele_vehicule;
  TodoVehicule.fromJson(this.key, Map data) {
    num_immatriculation = (data['num_immatriculation']== null? '': data['num_immatriculation']);
    annee_modele_vehicule = (data['annee_modele_vehicule']== null? '': data['annee_modele_vehicule']);
    marque_vehicule = (data['marque_vehicule']== null? '': data['marque_vehicule']);
    modele_vehicule = (data['modele_vehicule']== null? '': data['modele_vehicule']);
  }
}




class FirebaseTodos {
  /// FirebaseTodos.getTodoStream("-KriJ8Sg4lWIoNswKWc4", _updateTodo)
  /// .then((StreamSubscription s) => _subscriptionTodo = s);
  static Future<StreamSubscription<Event>> getProprietaire(
      void onData(TodoProprietaire todo)) async {
    String accountKey = await Preferences.getAccountKey();

    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child("proprietaire")
        .child(accountKey)
        .onValue
        .listen((Event event) {
      var todo = new TodoProprietaire.fromJson(event.snapshot.key, event.snapshot.value);
      onData(todo);
    });

    return subscription;
  }

  static Future<StreamSubscription<Event>> getAgreement(String todoKey,
      void onData(TodoAgreement todo)) async {
    String accountKey = await Preferences.getAccountKey();

    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child("proprietaire")
        .child(accountKey)
        .child("agreement")
        .child(todoKey)
        .onValue
        .listen((Event event) {
      var todo = new TodoAgreement.fromJson(event.snapshot.key, event.snapshot.value);
      onData(todo);
    });

    return subscription;
  }

  static Future<StreamSubscription<Event>> getVehicule(String todoKey,
      void onData(TodoVehicule todo)) async {
    String accountKey = await Preferences.getAccountKey();

    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child("proprietaire")
        .child(accountKey)
        .child("agreement")
        .child(todoKey)
        .child("vehicule")
        .onValue
        .listen((Event event) {
      var todo = new TodoVehicule.fromJson(event.snapshot.key, event.snapshot.value);
      onData(todo);
    });

    return subscription;
  }

  /// FirebaseTodos.getTodo("-KriJ8Sg4lWIoNswKWc4").then(_updateTodo);
  /*static Future<Todo> getTodo(String todoKey) async {
    Completer<Todo> completer = new Completer<Todo>();

    String accountKey = await Preferences.getAccountKey();

    FirebaseDatabase.instance
        .reference()
        .child("proprietaire")
        .child(accountKey)
        .child("agreement")
        .child(todoKey)
        .once()
        .then((DataSnapshot snapshot) {
      var todo = new Todo.fromJson(snapshot.key, snapshot.value);
      completer.complete(todo);
    });

    return completer.future;
  }*/
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
      accountKey = await getCurrentUid();
    }

    return accountKey;
  }
}