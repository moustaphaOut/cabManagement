import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:gestion_taxi/login_page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../widgets/info_card.dart';
import './profile_page.dart';
import './traffic_owner.dart';

class HomeOwner extends StatefulWidget {
  static String tag = 'home-owner';
  @override
  State<StatefulWidget> createState() {
    return _HomeOwner();
  }
}

class _HomeOwner extends State<HomeOwner> {
  var now = formatDate(DateTime(2019, 07, 25), [dd, '-', mm, '-', yyyy]);

  List _cities = [
    "--Select Taxi--",
    "Dacia 2018",
    "Dacia 2016",
    "Mercedes 2012",
  ];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;
    super.initState();
  }

  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 0, 0, 0.7),
        leading: IconButton(
          icon: Icon(
            Icons.outlined_flag,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(LoginPage.tag);
          },
        ),
        title: Text('Home'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.supervised_user_circle),
            onPressed: () => _onAlertButtonPressed(context),
          ),
          Center(
            child: new Text("1/3"),
          ),
          new IconButton(
            icon: new Icon(Icons.message),
            onPressed: () => {},
          ),
          Center(
            child: new Text("1"),
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
                  Text("sensor_1 of ahmed doesn't work",
                      style: TextStyle(fontSize: 18, color: Colors.red)),
                  Text("Simo didn't ride this day !",
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
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    //Text("${selectedDate.toLocal()}"),
                    DropdownButton(
                      value: _currentCity,
                      items: _dropDownMenuItems,
                      onChanged: changedDropDownItem,
                    ),
                    RaisedButton(
                      onPressed: () => _selectDate(context),
                      child: Text('Select date'),
                    ),
                  ],
                ),
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
            Navigator.of(context).pushNamed(ProfileOwner.tag);
          else if (currentIndex == 1)
            Navigator.of(context).pushNamed(TrafficOwner2.tag);
          //Navigator.of(context).pushNamed(Profile.tag);
        },
        selectedItemColor: Colors.amber[800],
      ),
    );
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      _currentCity = selectedCity;
    });
  }

  // Alert with single button.
  _onAlertButtonPressed(context) {
    Alert(
      context: context,
      title: "Drivers 1/3",
      desc: "simo Riding\n Ahmed free\n Yasine free",
      buttons: [
        DialogButton(
          child: Text(
            "COOL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        ),
      ],
    ).show();
  }
}
