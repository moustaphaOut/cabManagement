import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

import './home_page.dart';
import './profile_page.dart';
import '../widgets/info_card.dart';

const photo = 'assets/alucard.jpg';
const full_name = 'Single rider';
const rating = 3;
const job = 'Owner';
const email = 'Moustapha.out@gmail.com';
const phone = '+212 697 19 58 69';
const city = 'Rabat, Morocco';
const work_time = 'From 8 AM To 5 PM';
const username = 'moustapha_out';
const birthday = '18/05/1998';

class TrafficOwner extends StatefulWidget {
  static String tag = 'traffic-owner';
  @override
  State<StatefulWidget> createState() {
    return _TrafficOwner();
  }
}

class _TrafficOwner extends State<TrafficOwner> {
  static String tag = 'traffic-page';
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
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepPurple),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.track_changes,
              semanticLabel: 'menu',
            ),
            onPressed: () {
              print('Menu button');
            },
          ),
          title: Text('My traffic'),
        ),
        body: Container(
          child: ListView(
            children: [
              Container(
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    //Text("${selectedDate.toLocal()}"),
                    SizedBox(
                      height: 20.0,
                    ),
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
                        "${selectedDate.toLocal()}",
                        style: TextStyle(fontSize: 15.0),
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
                    text: '100 km',
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
              Divider(),

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
              Navigator.of(context).pushNamed(HomeOwner.tag);
            else if (currentIndex == 2)
              Navigator.of(context).pushNamed(ProfileOwner.tag);
            //Navigator.of(context).pushNamed(Profile.tag);
          },
          selectedItemColor: Colors.amber[300],
        ),
      ),
    );
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      _currentCity = selectedCity;
    });
  }
}
