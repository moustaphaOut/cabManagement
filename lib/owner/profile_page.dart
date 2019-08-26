import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './home_page.dart';
import '../widgets/info_card.dart';
import '../model/proprietaire.dart';
import './traffic_page.dart';

const photo = 'assets/alucard.jpg';
const full_name = 'Abdelilah Kahlaoui';
const rating = 3;
const job = 'Owner';
const cin = 'SA64521';
const email = 'sudo@gmail.com';
const phone = '+212 697 19 58 69';
const city = 'Nador, Morocco';
const username = 'moustapha_out';
const birthday = '18/05/1998';

class ProfileOwner extends StatefulWidget {
  static String tag = 'profile-page';
  @override
  State<StatefulWidget> createState() {
    return _ProfileOwner();
  }
}

class _ProfileOwner extends State<ProfileOwner> {
  static String tag = 'profile-owner';

  final databaseReference = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
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
                          full_name,
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
                          text: cin,
                          icon: Icons.web,
                          colorText: Colors.teal,
                          onPressed: () {},
                        ),
                        InfoCard(
                          text: phone,
                          icon: Icons.phone,
                          colorText: Colors.teal,
                          onPressed: () {},
                        ),
                        InfoCard(
                          text: email,
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
                          text: birthday,
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
                          text: "Num agreement",
                          icon: Icons.web,
                          colorText: Colors.teal,
                          onPressed: () {},
                        ),
                        InfoCard(
                          text: "date de l'agreement",
                          icon: Icons.phone,
                          colorText: Colors.teal,
                          onPressed: () {},
                        ),
                        InfoCard(
                          text: "dureé agreement",
                          icon: Icons.email,
                          colorText: Colors.teal,
                          onPressed: () {},
                        ),
                        InfoCard(
                          text: "copier d'agreement",
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
                          text: "num_immatriculation",
                          icon: Icons.web,
                          colorText: Colors.teal,
                          onPressed: () {},
                        ),
                        InfoCard(
                          text: "prix_achat_vehicule",
                          icon: Icons.phone,
                          colorText: Colors.teal,
                          onPressed: () {},
                        ),
                        InfoCard(
                          text: "marque_vehicule",
                          icon: Icons.email,
                          colorText: Colors.teal,
                          onPressed: () {},
                        ),
                        InfoCard(
                          text: "annee modele",
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

  show_owner() {
    Proprietaire user;
    databaseReference.once().then((DataSnapshot snapshot) {
      return user = Proprietaire.fromSnapshot(
          snapshot); // print('Data : ${snapshot.value}');
    });
    //return user;
  }
}
