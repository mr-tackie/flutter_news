import 'package:flutter/material.dart';
import 'package:news_me/utils/konstants.dart';

class MessageBanner extends StatelessWidget {
  MessageBanner({@required this.title, this.subtitle, this.actionText, this.action});
  
  final String title;
  final String subtitle;
  final String actionText;
  final Function action;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.blue[900],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 2.0, // soften the shadow
            spreadRadius: 1.0,
            offset: Offset(
              4,
              4,
            ),
          )
        ],
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: -50.0,
            right: -50.0,
            child: Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.circle
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50, 
            child: Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.3),
                shape: BoxShape.circle
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  this.title,
                  style: kMessageBannerMain,
                ),
                SizedBox(height: 16.0,),
                Text(
                  this.subtitle != null ? this.subtitle : '',
                  style: kMessageBannerSubtitle,
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  child: Text(
                    this.actionText,
                  ),
                  onPressed: this.action,
                  color: Colors.amber[200],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
