import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import '../database/firebase_database_util.dart';
import '../add_user_dialog.dart';

import '../widgets/info_card.dart';
import '../model/chauffeur.dart';

const photo = 'assets/alucard.jpg';
const job = 'Driver';
const city = 'Rabat, Morocco';

class ProfileDriver extends StatefulWidget {
  static String tag = 'profile-driver';
  @override
  State<StatefulWidget> createState() {
    return _ProfileDriver();
  }
}

class _ProfileDriver extends State<ProfileDriver>  implements AddUserCallback{
  bool _anchorToBottom = false;
  FirebaseDatabaseUtil databaseUtil;

  @override
  void initState() {
    super.initState();
    databaseUtil = new FirebaseDatabaseUtil('chauffeur');
    databaseUtil.initState();
  }

  @override
  void dispose() {
    super.dispose();
    databaseUtil.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildTitle(BuildContext context) {
      return new InkWell(
        child: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                'Profile',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }

    /*List<Widget> _buildActions() {
      return <Widget>[
        new IconButton(
          icon: const Icon(
            Icons.group_add,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ];
    }*/

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(255, 0, 0, 0.7),
        title: _buildTitle(context),
        //actions: _buildActions(),
      ),
      body: new FirebaseAnimatedList(
        key: new ValueKey<bool>(_anchorToBottom),
        query: databaseUtil.getUser(),
        reverse: _anchorToBottom,
        sort: _anchorToBottom
            ? (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key)
            : null,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          return new SizeTransition(
            sizeFactor: animation,
            child: showUser(snapshot),
          );
        },
      ),
    );
  }

  @override
  void update(Chauffeur user) {
    setState(() {
      databaseUtil.updateUser(user);
    });
  }

  Widget showUser(DataSnapshot res) {
    Chauffeur user = Chauffeur.fromSnapshot(res);

    var item = new Container(
      child: new Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(user.photoChauffeur),
          ),
          Text(
            user.nomChauffeur + " " + user.prenomChauffeur,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontFamily: 'Pacifico',
            ),
          ),
          Text(
            job,
            style: TextStyle(
              fontFamily: 'Source Sans Pro',
              fontSize: 15.0,
              color: Colors.red,
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
            text: user.telephoneChauffeur,
            icon: Icons.phone,
            colorText: Colors.teal,
            onPressed: () => showEditWidget(user, true, user.telephoneChauffeur, "telephoneChauffeur"),
          ),
          InfoCard(
            text: user.emailChauffeur,
            icon: Icons.email,
            colorText: Colors.teal,
            onPressed: () => showEditWidget(user, true, user.emailChauffeur, "emailChauffeur"),
          ),
          InfoCard(
            text: user.horaireTravail,
            icon: Icons.web,
            colorText: Colors.teal,
            onPressed: () {},
          ),
          InfoCard(
            text: city,
            colorText: Colors.teal,
            icon: Icons.location_city,
          ),
          InfoCard(
            text: user.nomUtilisateurChauffeur,
            colorText: Colors.teal,
            icon: Icons.alternate_email,
          ),
          InfoCard(
            text: user.dateNaissanceChauffeur,
            colorText: Colors.teal,
            icon: Icons.calendar_today,
            onPressed: () => showEditWidget(user, true, user.dateNaissanceChauffeur, "dateNaissanceChauffeur"),
          ),
        ],
      ),
    );

    return item;
  }

 /* String getShortName(Chauffeur user) {
    String shortName = "";
    if (user.nomChauffeur.isNotEmpty) {
      shortName = user.nomChauffeur.substring(0, 1);
    }
    return shortName;
}*/

  showEditWidget(Chauffeur user, bool isEdit,String data, String nameDB) {
     showDialog(
      context: context,
      builder: (BuildContext context) =>
          new AddUserDialog(data).buildAboutDialog(context, this, user, nameDB),
    );
  }

  deleteUser(Chauffeur user) {
    setState(() {
      databaseUtil.deleteUser(user);
    });
  }

  @override
  void addUser(Chauffeur user) {
    // TODO: implement addUser
  }
}
