import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import '../model/chauffeur.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDatabaseUtil{
  String _dt;
  DatabaseReference _counterRef;
  DatabaseReference _userRef;
  StreamSubscription<Event> _counterSubscription;
  StreamSubscription<Event> _messagesSubscription;
  FirebaseDatabase database = new FirebaseDatabase();
  int _counter;
  DatabaseError error;
  String get dt => _dt;

  static final FirebaseDatabaseUtil _instance =
      new FirebaseDatabaseUtil.internal();

  FirebaseDatabaseUtil.internal();

  /*factory FirebaseDatabaseUtil() {
    return _instance;
  }*/
   FirebaseDatabaseUtil(String dt) {
    this._dt= dt;
  }

  void initState() {
    // Demonstrates configuring to the database using a file
    _counterRef = FirebaseDatabase.instance.reference().child('counter');
    // Demonstrates configuring the database directly

    _userRef = database.reference().child(dt);//'user'
    database.reference().child('counter').once().then((DataSnapshot snapshot) {
      print('Connected to second database and read ${snapshot.value}');
    });
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    _counterRef.keepSynced(true);

    _counterSubscription = _counterRef.onValue.listen((Event event) {
      error = null;
      _counter = event.snapshot.value ?? 0;
    }, onError: (Object o) {
      error = o;
    });
  }

  DatabaseError getError() {
    return error;
  }

  int getCounter() {
    return _counter;
  }

  DatabaseReference getUser() {
    return _userRef;
  }

  addUser(Chauffeur user) async {
    final TransactionResult transactionResult =
        await _counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;

      return mutableData;
    });

    if (transactionResult.committed) {
      _userRef.push().set(<String, String>{
        "nomChauffeur": "" + user.nomChauffeur,
        "prenomChauffeur": "" + user.prenomChauffeur,
        "nomUtilisateurChauffeur": "" + user.nomUtilisateurChauffeur,
        "dateRecrutement": "" + user.dateRecrutement,
        "dateNaissanceChauffeur": "" + user.dateNaissanceChauffeur,
        "horaireTravail": "" + user.horaireTravail,
        "telephoneChauffeur": "" + user.telephoneChauffeur,
        "cinChauffeur": "" + user.cinChauffeur,
        "permisChauffeur": "" + user.permisChauffeur,
        "permisConfianceChauffeur": "" + user.permisConfianceChauffeur,
        "photoChauffeur": "" + user.photoChauffeur,
        "emailChauffeur": "" + user.emailChauffeur,
        "passwordChauffeur": "" + user.passwordChauffeur,
      }).then((_) {
        print('Transaction  committed.');
      });
    } else {
      print('Transaction not committed.');
      if (transactionResult.error != null) {
        print(transactionResult.error.message);
      }
    }
  }

  void deleteUser(Chauffeur user) async {
    await _userRef.child(user.idChauffeur).remove().then((_) {
      print('Transaction  committed.');
    });
  }

  void updateUser(Chauffeur user) async {
    await _userRef.child(user.idChauffeur).update({
      "nomChauffeur": "" + user.nomChauffeur,
      "prenomChauffeur": "" + user.prenomChauffeur,
      "nomUtilisateurChauffeur": "" + user.nomUtilisateurChauffeur,
      "dateRecrutement": "" + user.dateRecrutement,
      "dateNaissanceChauffeur": "" + user.dateNaissanceChauffeur,
      "horaireTravail": "" + user.horaireTravail,
      "telephoneChauffeur": "" + user.telephoneChauffeur,
      "permisConfianceChauffeur": "" + user.permisConfianceChauffeur,
      "permisChauffeur": "" + user.permisChauffeur,
      "cinChauffeur": "" + user.cinChauffeur,
      "photoChauffeur": "" + user.photoChauffeur,
      "emailChauffeur": "" + user.emailChauffeur,
      "passwordChauffeur": "" + user.passwordChauffeur,
    }).then((_) {
      print('Transaction  committed.');
    });
  }

  void dispose() {
    _messagesSubscription.cancel();
    _counterSubscription.cancel();
  }
}
