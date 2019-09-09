import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'model/Colors.dart';

class UpdateFieldDialog {
  final databaseReference = FirebaseDatabase.instance.reference();
  final newData = TextEditingController();

  Widget buildAboutDialog(
      BuildContext context, String attributeName, String currentData) {
    newData.text = currentData;
    return new AlertDialog(
      
      contentPadding: EdgeInsets.only(top: 20, left: 15.0, right: 15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      title: new Text(
        'Edit',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30),
      ),
      content: TextFormField(
        
        controller: newData,
        decoration: new InputDecoration(
          contentPadding:
              new EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(new Radius.circular(30.0))),
          hintText: " ",
        ),
      ),
      
      actions: <Widget>[
        
         RaisedButton(
          textColor: Colors.green,
          color: Colors.white,
          child: Text("Cancel"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        RaisedButton(
          textColor: Colors.white,
          color: Colors.green,
          child: Text("Update"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          onPressed: () {
            updateFieldDatabase(attributeName, "chauffeur");
            Navigator.of(context).pop();
          },
        ),
       
      ],
    );
  }

  void updateFieldDatabase(String attributeName, String typeTable) {
    if (typeTable == 'chauffeur') {
      databaseReference
          .child("proprietaire")
          .child("21YOLwa4ITRAdUNy824AfkHBRZ23")
          .child("agreement")
          .child("agr1")
          .child("vehicule")
          .child("chauffeur")
          .child("cha1")
          .update({attributeName: newData.text});
    }
  }
}
