import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class UpdateFieldDialog {
  final databaseReference = FirebaseDatabase.instance.reference();
  final newData = TextEditingController();

  Widget buildAboutDialog(
      BuildContext context, String attributeName, String currentData) {
    newData.text = currentData;
    return new AlertDialog(
      title: new Text('Edit'),
      content: new SingleChildScrollView(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: newData,
              decoration: new InputDecoration(
                hintText: " ",
              ),
            ),
            RaisedButton(
              color: Colors.green,
              child: Text("Update"),
              onPressed: () {
                updateFieldDatabase(attributeName,"chauffeur");
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
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
