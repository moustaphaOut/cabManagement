import 'package:firebase_database/firebase_database.dart';

class Proprietaire {
  String _idProprietaire;
  String _cinProprietaire;
  String _nomProprietaire;
  String _prenomProprietaire;
  String _dateNaissanceProprietaire;
  String _telephoneProprietaire;
  String _photoProprietaire;
  String _nomUtilisateurProprietaire;
  String _emailProprietaire;
  String _passwordProprietaire;
  String _dateCreationCompte;

  Proprietaire(this._idProprietaire, this._cinProprietaire, this._nomProprietaire, this._prenomProprietaire, this._dateNaissanceProprietaire,
      this._telephoneProprietaire, this._photoProprietaire,  this._nomUtilisateurProprietaire, this._emailProprietaire,
      this._passwordProprietaire, this._dateCreationCompte);

  /*Chauffeur.map(dynamic obj) {
    this._name = obj['name'];
    this._dateNaissance = obj['dateNaissance'];
    this._cin = obj['cin'];
    this._email = obj['email'];
    this._description = obj['description'];
    this._password = obj['password'];
  }*/

  String get idProprietaire => _idProprietaire;
  String get cinProprietaire => _cinProprietaire;
  String get nomProprietaire => _nomProprietaire;
  String get prenomProprietaire => _prenomProprietaire;
  String get dateNaissanceProprietaire => _dateNaissanceProprietaire;
  String get telephoneProprietaire => _telephoneProprietaire;
  String get photoProprietaire => _photoProprietaire;
  String get nomUtilisateurProprietaire => _nomUtilisateurProprietaire;
  String get emailProprietaire => _emailProprietaire;
  String get passwordProprietaire => _passwordProprietaire;
  String get dateCreationCompte => _dateCreationCompte;

  Proprietaire.fromSnapshot(DataSnapshot snapshot) {
    _idProprietaire = snapshot.key;
    _cinProprietaire = snapshot.value['cinProprietaire'];
    _nomProprietaire = snapshot.value['nomProprietaire '];
    _prenomProprietaire = snapshot.value['prenomProprietaire'];
    _dateNaissanceProprietaire = snapshot.value['dateNaissanceProprietaire'];
    _telephoneProprietaire = snapshot.value['telephoneProprietaire'];
    _photoProprietaire = snapshot.value['photoProprietaire'];
    _nomUtilisateurProprietaire = snapshot.value['nomUtilisateurProprietaire'];
    _photoProprietaire = snapshot.value['photoProprietaire'];
    _emailProprietaire = snapshot.value['emailProprietaire'];
    _passwordProprietaire = snapshot.value['passwordProprietaire'];
    _dateCreationCompte = snapshot.value['dateCreationCompte'];
  }
}
