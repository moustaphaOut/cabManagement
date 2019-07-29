import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String text;
  final Color colorText;
  final IconData icon;
  final Color colorIcon;
  final double vertical;
  final double horizontal ;
  Function onPressed;

  InfoCard({
    @required this.text,
    this.colorText,
    @required this.icon,
    this.colorIcon,
    this.vertical = 2.0,
    this.horizontal = 7.0,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Colors.white,
        margin:
            EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
        child: ListTile(
          leading: Icon(
            icon,
            color: colorIcon,
          ),
          title: Text(
            text,
            style: TextStyle(
              fontFamily: 'Source Sans Pro',
              fontSize: 15.0,
              color: colorText,
            ),
          ),
        ),
      ),
    );
  }
}
