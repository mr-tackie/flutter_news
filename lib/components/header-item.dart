import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:news_me/screens/search.dart';
import 'package:news_me/utils/konstants.dart';

class HeaderItem extends StatelessWidget {
  HeaderItem({@required this.title, this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              this.title,
              style: kHeadingLead,
            ),
            Text(
              this.subtitle != null ? this.subtitle : '',
              style: kMutedTextStyle,
            )
          ],
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).push(
              new MaterialPageRoute<Null>(
                builder: (BuildContext context){
                  return new SearchPage();
                },
                fullscreenDialog: true,
              )
            );
          },
          child: Icon(LineIcons.search),
        )
      ],
    );
  }
}
