import 'package:flutter/material.dart';
import 'package:gestion_taxi/owner/home_page.dart';

import 'login_page.dart';
import './driver/home_page.dart';
import './driver/profile_page.dart';
import './driver/traffic_page.dart';
import './owner/home_page.dart';
import './owner/profile_page.dart';
import './owner/traffic_page.dart';
import './owner/traffic_owner.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),

    HomeDriver.tag: (context) => HomeDriver(),
    TrafficDriver.tag: (context) => TrafficDriver(),
    ProfileDriver.tag: (context) => ProfileDriver(),

    HomeOwner.tag: (context) => HomeOwner(),
    ProfileOwner.tag: (context) => ProfileOwner(),
    TrafficOwner.tag: (context) => TrafficOwner(),
    TrafficOwner2.tag: (context) => TrafficOwner2(),

  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taxi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}