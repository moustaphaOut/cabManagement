import 'package:firebase_database/firebase_database.dart';

class Chauffeur {
  String _idChauffeur;
  String _cinChauffeur;
  String _nomChauffeur;
  String _prenomChauffeur;
  String _dateNaissanceChauffeur;
  String _permisChauffeur;
  String _permisConfianceChauffeur;
  String _horaireTravail;
  String _photoChauffeur;
  String _telephoneChauffeur;
  String _nomUtilisateurChauffeur;
  String _emailChauffeur;
  String _passwordChauffeur;
  String _dateRecrutement;
  //String _ratingChauffeur;

  Chauffeur([this._idChauffeur, this._cinChauffeur, this._nomChauffeur, this._prenomChauffeur, this._dateNaissanceChauffeur,
      this._permisChauffeur, this._permisConfianceChauffeur,this._horaireTravail, this._photoChauffeur, this._telephoneChauffeur, this._nomUtilisateurChauffeur, this._emailChauffeur, this._passwordChauffeur,
      this._dateRecrutement]);

  /*Chauffeur.map(dynamic obj) {
    this._cinChauffeur = obj['cinChauffeur'];
    this._nomChauffeur = obj['nomChauffeur'];
    this._prenomChauffeur = obj['prenomChauffeur'];
    this._dateNaissanceChauffeur = obj['dateNaissanceChauffeur'];
    this._description = obj['description'];
    this._permisConfianceChauffeur = obj['permisConfianceChauffeur'];
  }*/

  String get idChauffeur => _idChauffeur;
  String get cinChauffeur => _cinChauffeur;
  String get nomChauffeur => _nomChauffeur;
  String get prenomChauffeur => _prenomChauffeur;
  String get dateNaissanceChauffeur => _dateNaissanceChauffeur;
  String get permisChauffeur => _permisChauffeur;
  String get permisConfianceChauffeur => _permisConfianceChauffeur;
  String get horaireTravail => _horaireTravail;
  String get photoChauffeur => _photoChauffeur;
  String get telephoneChauffeur => _telephoneChauffeur;
  String get emailChauffeur => _emailChauffeur;
  String get nomUtilisateurChauffeur => _nomUtilisateurChauffeur;
  String get passwordChauffeur => _passwordChauffeur;
  String get dateRecrutement => _dateRecrutement;
  //String get ratingChauffeur => _ratingChauffeur;

  Chauffeur.fromSnapshot(DataSnapshot snapshot) {
    _idChauffeur = snapshot.key;
    _cinChauffeur = snapshot.value['cinChauffeur'];
    _nomChauffeur = snapshot.value['nomChauffeur'];
    _prenomChauffeur = snapshot.value['prenomChauffeur'];
    _dateNaissanceChauffeur = snapshot.value['dateNaissanceChauffeur'];
    _permisChauffeur = snapshot.value['permisChauffeur'];
    _permisConfianceChauffeur = snapshot.value['permisConfianceChauffeur'];
    _horaireTravail = snapshot.value['horaireTravail'];
    _photoChauffeur = snapshot.value['photoChauffeur'];
    _telephoneChauffeur = snapshot.value['telephoneChauffeur'];
    _nomUtilisateurChauffeur = snapshot.value['nomUtilisateurChauffeur'];
    _emailChauffeur = snapshot.value['emailChauffeur'];
    _passwordChauffeur = snapshot.value['passwordChauffeur'];
    _dateRecrutement = snapshot.value['dateRecrutement'];
    //_ratingChauffeur = snapshot.value['ratingChauffeur'];
  }
}
