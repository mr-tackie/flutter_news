import 'package:flutter/material.dart';
import 'package:news_me/utils/konstants.dart';

class BrowseHeader extends StatelessWidget {
  BrowseHeader({this.title, this.isActive});
  
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        this.title,
        style: isActive ? kHeadlineSmall : kHeadlineMuted,
      ),
    );
  }
}