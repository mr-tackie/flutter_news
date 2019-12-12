import 'package:flutter/material.dart';
import 'package:news_me/components/header-item.dart';
import 'package:news_me/utils/garage.dart';
import 'package:news_me/utils/konstants.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({Key key}) : super(key: key);

  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  List<String> _favorites = [];
  
  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  _loadFavorites() async{
    Garage garage = Garage();
    bool hasGarageInit = await garage.init();

    if(hasGarageInit){
      List<String> favorites = garage.getItem(kFAVORITE_CATEGORIES);
      
      if(favorites != null){
        setState(() {
          _favorites = favorites;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            HeaderItem(
              title: 'Browse',
              subtitle: 'Based on your favorites',
            )
          ],
        ),
      ),
    );
  }
}