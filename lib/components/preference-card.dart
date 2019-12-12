import 'package:flutter/material.dart';
import 'package:news_me/utils/helpers.dart';
import 'package:news_me/utils/konstants.dart';

class PreferenceCard extends StatelessWidget {
  PreferenceCard(
      {@required this.title,
      @required this.color,
      @required this.isActive,
      this.onPressed});

  final String title;
  final MaterialColor color;
  final Function onPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPressed,
      child: AnimatedContainer(
        padding: EdgeInsets.only(bottom: 10.0, left: 10.0, top: 5.0, right: 5.0),
        duration: Duration(milliseconds: 200),
        height: 280.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: this.isActive ? this.color : this.color.withOpacity(0.6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.check_circle,
                color: this.isActive
                    ? Colors.white
                    : Colors.white.withOpacity(0.5),
              ),
            ),
            Text(
              capitalize(this.title),
              style: kHeading18White,
            )
          ],
        ),
      ),
    );
  }
}
