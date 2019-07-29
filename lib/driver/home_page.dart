import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

import '../widgets/info_card.dart';
import './profile_page.dart';
import './traffic_page.dart';

class HomeDriver extends StatelessWidget {
  static String tag = 'home-driver';
  var now = formatDate(DateTime(2019, 07, 25), [dd, '-', mm, '-', yyyy]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 0, 0, 0.7),
        leading: IconButton(
          icon: Icon(
            Icons.bluetooth,
          ),
          onPressed: () {},
        ),
        title: Text('Connected'),
        actions: <Widget>[
          Center(child: new Text("Riding"),),
          new IconButton(
            icon: new Icon(Icons.check),
            onPressed: () => {},
          ),
          
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 7.0),
        child: ListView(
          children: [
            Text(
              "Message",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.all(5.0),
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(),
              ),
              child: Column(
                children: [
                  Text("Everything is going fine",
                      style: TextStyle(fontSize: 18, color: Colors.green)),
                  Text("Enable your bluetooth",
                      style: TextStyle(fontSize: 18, color: Colors.red)),
                ],
              ),
            ),
            Divider(),
            Container(
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.all(0.0),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(),
              child: Column(children: [
                new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new Text(
                        "Today",
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w800),
                      ),
                      new Text(
                        '$now',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ]),
                InfoCard(
                  vertical: 0.0,
                  text: '300 DH',
                  icon: Icons.attach_money,
                  colorText: Colors.teal,
                ),
                InfoCard(
                  vertical: 0.0,
                  text: '10 km',
                  icon: Icons.directions_car,
                  colorText: Colors.teal,
                ),
                InfoCard(
                  vertical: 0.0,
                  text: '12',
                  icon: Icons.people,
                  colorText: Colors.teal,
                ),
                InfoCard(
                  vertical: 0.0,
                  text: '8 H',
                  icon: Icons.timelapse,
                  colorText: Colors.teal,
                ),
              ]),
            ),
            //Divider(),
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
          if (currentIndex == 2)
            Navigator.of(context).pushNamed(ProfileDriver.tag);
          else if (currentIndex == 1)
            Navigator.of(context).pushNamed(TrafficDriver.tag);
          //Navigator.of(context).pushNamed(Profile.tag);
        },
        selectedItemColor: Colors.amber[800],
      ),
    );
  }
}
/*final alucard = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircleAvatar(
          radius: 72.0,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/alucard.jpg'),
        ),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Welcome Alucard',
        style: TextStyle(fontSize: 28.0, color: Colors.white),
      ),
    );

    final lorem = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec hendrerit condimentum mauris id tempor. Praesent eu commodo lacus. Praesent eget mi sed libero eleifend tempor. Sed at fringilla ipsum. Duis malesuada feugiat urna vitae convallis. Aliquam eu libero arcu.',
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
    );

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.blue,
          Colors.lightBlueAccent,
        ]),
      ),
      child: Column(
        children: <Widget>[alucard, welcome, lorem],
      ),
    );*/
