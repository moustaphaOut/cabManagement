import 'package:firebase_database/firebase_database.dart';

class Chauffeur {
  String _numImmatriculation;
  String _prixAchatVehicule;
  String _marqueVehicule;
  String _modeleVehicule;
  String _anneeModeleVehicule;
  String _typeCarburant;
  String _kmVehicule;
  String _kmVidange;
  String _dateAssuranceVehicule;
  String _typeAssuranceVehicule;
  String _montantAssurance;
  String _copieAssurance;
  String _dateVisiteTechniqueVehicule;
  String _montantVisiteTechnique;
  String _copieVisiteTechnique;
  String _numCarteGrise;
  String _dateCarteGrise;
  String _copieCarteGrise;
  //String _idAgreement;
  //String _idEquipement;

  Chauffeur(this._numImmatriculation, this._prixAchatVehicule, this._marqueVehicule, this._modeleVehicule, this._anneeModeleVehicule,
      this._typeCarburant, this._kmVehicule,this._kmVidange, this._dateAssuranceVehicule, this._typeAssuranceVehicule, this._montantAssurance, this._copieAssurance,
      this._dateVisiteTechniqueVehicule, this._montantVisiteTechnique, this._copieVisiteTechnique, this._numCarteGrise, this._dateCarteGrise, this._copieCarteGrise);

  /*Chauffeur.map(dynamic obj) {
    this._prixAchatVehicule = obj['prixAchatVehicule'];
    this._marqueVehicule = obj['marqueVehicule'];
    this._modeleVehicule = obj['modeleVehicule'];
    this._anneeModeleVehicule = obj['anneeModeleVehicule'];
    this._description = obj['description'];
    this._kmVehicule = obj['kmVehicule'];
  }*/

  String get numImmatriculation => _numImmatriculation;
  String get prixAchatVehicule => _prixAchatVehicule;
  String get marqueVehicule => _marqueVehicule;
  String get modeleVehicule => _modeleVehicule;
  String get anneeModeleVehicule => _anneeModeleVehicule;
  String get typeCarburant => _typeCarburant;
  String get kmVehicule => _kmVehicule;
  String get kmVidange => _kmVidange;
  String get dateAssuranceVehicule => _dateAssuranceVehicule;
  String get typeAssuranceVehicule => _typeAssuranceVehicule;
  String get montantAssurance => _montantAssurance;
  String get copieAssurance => _copieAssurance;
  String get dateVisiteTechniqueVehicule => _dateVisiteTechniqueVehicule;
  String get montantVisiteTechnique => _montantVisiteTechnique;
  String get copieVisiteTechnique => _copieVisiteTechnique;
  String get numCarteGrise => _numCarteGrise;
  String get dateCarteGrise => _dateCarteGrise;
  String get copieCarteGrise => _copieCarteGrise;
  //String get dateVisiteTechniqueVehicule2 => _dateVisiteTechniqueVehicule2;
  //String get montantVisiteTechnique2 => _montantVisiteTechnique2;

  Chauffeur.fromSnapshot(DataSnapshot snapshot) {
    _numImmatriculation = snapshot.key;
    _prixAchatVehicule = snapshot.value['prixAchatVehicule'];
    _marqueVehicule = snapshot.value['marqueVehicule'];
    _modeleVehicule = snapshot.value['modeleVehicule'];
    _anneeModeleVehicule = snapshot.value['anneeModeleVehicule'];
    _typeCarburant = snapshot.value['typeCarburant'];
    _kmVehicule = snapshot.value['kmVehicule'];
    _dateAssuranceVehicule = snapshot.value['dateAssuranceVehicule'];
    _typeAssuranceVehicule = snapshot.value['typeAssuranceVehicule'];
    _montantAssurance = snapshot.value['montantAssurance'];
    _copieAssurance = snapshot.value['copieAssurance'];
    _dateVisiteTechniqueVehicule = snapshot.value['dateVisiteTechniqueVehicule'];
    _montantVisiteTechnique = snapshot.value['montantVisiteTechnique'];
    _copieVisiteTechnique = snapshot.value['copieVisiteTechnique'];
    _numCarteGrise = snapshot.value['numCarteGrise'];
    _dateCarteGrise = snapshot.value['dateCarteGrise'];
    _copieCarteGrise = snapshot.value['copieCarteGrise'];
    //_dateVisiteTechniqueVehicule2 = snapshot.value['dateVisiteTechniqueVehicule2'];
    //_montantVisiteTechnique2 = snapshot.value['montantVisiteTechnique2'];
  }
}
