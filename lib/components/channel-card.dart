import 'dart:math';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:news_me/models/channel.dart';
import 'package:news_me/utils/konstants.dart';

class ChannelCard extends StatelessWidget {
  ChannelCard({@required this.channel});
  final Channel channel;

  final List<MaterialColor> colors = [
    Colors.red,
    Colors.blue,
    Colors.pink,
    Colors.amber,
    Colors.green,
    Colors.blueGrey,
    Colors.brown,
    Colors.cyan,
    Colors.purple,
    Colors.teal,
    Colors.orange,
    Colors.lime,
    Colors.indigo
  ];

  final Map<String, IconData> iconset = {
    'business': LineIcons.dollar,
    'entertainment': LineIcons.music,
    'general': LineIcons.globe,
    'health': LineIcons.heartbeat,
    'science': LineIcons.tachometer,
    'sports': LineIcons.trophy,
    'technology': LineIcons.laptop
  };

  @override
  Widget build(BuildContext context) {
    Random random = new Random();
    MaterialColor randomColor = colors[random.nextInt(colors.length)];
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, bottom: 8.0),
      child: Container(
        width: 170.0,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(4.0)
                ),
                child: Icon(iconset[channel.category], color: randomColor.withOpacity(0.6),),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    channel.name,
                    style: kHeading18White,
                  ),
                  Text(
                    channel.category,
                    style: TextStyle(color: Color(0xBBF6F6F6), fontFamily: 'Rubik',), 
                  ),
                ],
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: randomColor.withOpacity(0.6),
            boxShadow: [
              BoxShadow(
                  blurRadius: 2.0,
                  spreadRadius: 2.0,
                  color: Colors.black.withOpacity(0.05),
                  offset: Offset(2, 2))
            ]),
      ),
    );
  }
}
