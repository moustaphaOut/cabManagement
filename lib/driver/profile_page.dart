import 'package:flutter/material.dart';

import './home_page.dart';
import '../widgets/info_card.dart';
import './traffic_page.dart';

const photo = 'assets/alucard.jpg';
const full_name = 'Moustapha El Outmani';
const rating = 3;
const job = 'Driver';
const email = 'Moustapha.out@gmail.com';
const phone = '+212 697 19 58 69';
const city = 'Rabat, Morocco';
const work_time = 'From 8 AM To 5 PM';
const username = 'moustapha_out';
const birthday = '18/05/1998';

class ProfileDriver extends StatefulWidget {
  static String tag = 'profile-driver';
  @override
  State<StatefulWidget> createState() {
    return _ProfileDriver();
  }
}

class _ProfileDriver extends State<ProfileDriver> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepPurple),
      home: Scaffold(
        body: SafeArea(
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
              IconTheme(
                data: IconThemeData(
                  color: Colors.amber,
                  size: 25,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(5, (index) {
                    return Icon(
                      index < rating ? Icons.star : Icons.star_border,
                    );
                  }),
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
                text: work_time,
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
                text: username,
                colorText: Colors.teal,
                icon: Icons.alternate_email,
              ),
              InfoCard(
                text: birthday,
                colorText: Colors.teal,
                icon: Icons.calendar_today,
              ),
              RaisedButton(
                padding: const EdgeInsets.all(5.0),
                child: const Text('Save'),
                color: Theme.of(context).accentColor,
                elevation: 4.0,
                splashColor: Colors.blueGrey,
                onPressed: () {
                  // Perform some action
                },
              )
            ],
          ),
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
              Navigator.of(context).pushNamed(HomeDriver.tag);
            else if(currentIndex == 1)
              Navigator.of(context).pushNamed(TrafficDriver.tag);
            //Navigator.of(context).pushNamed(Profile.tag);
          },
          selectedItemColor: Colors.amber[800],
        ),
        backgroundColor: Colors.teal[200],
      ),
    );
  }
}
