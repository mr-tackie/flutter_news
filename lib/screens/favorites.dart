import 'package:flutter/material.dart';
import 'package:news_me/components/preference-card.dart';
import 'package:news_me/utils/konstants.dart';
import 'package:news_me/utils/garage.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<String> _favorites = [];

  List<Widget> _buildCards() {
    List<String> categories = [
      'business',
      'general',
      'entertainment',
      'health',
      'science',
      'sports',
      'technology'
    ];
    List<MaterialColor> colors = [
      Colors.indigo,
      Colors.pink,
      Colors.blueGrey,
      Colors.deepOrange,
      Colors.brown,
      Colors.red,
      Colors.amber
    ];
    List<PreferenceCard> cards = [];

    for (int i = 0; i < categories.length; i++) {
      cards.add(PreferenceCard(
        title: categories[i],
        color: colors[i],
        isActive: _favorites.contains(categories[i]),
        onPressed: (){
          _manageFavoriteEntry(categories[i]);
        }
      ));
    }

    return cards;
  }

  _manageFavoriteEntry(String category){
    if(_favorites.contains(category)){
      setState(() {
        _favorites.remove(category);
      });
    }else{
      setState(() {
        _favorites.add(category);
      });
    }
  }

  _handleContinue() async{
    Garage garage = Garage();
    bool isGarageReady = await garage.init();
    
    if(isGarageReady){
      garage.setItem(kFAVORITE_CATEGORIES, _favorites);
      garage.setItem(kFIRST_USE, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    onPressed: (){
                      _handleContinue();
                      Navigator.pushNamed(context, '/main');
                    },
                    child: Text(
                      _favorites.length == 0 ? 'Skip' : 'Done',
                      style: kClearButtonTextStyle,
                    ),
                  ),
                ],
              ),
              Text(
                'Interests',
                style: kHeadingLead,
              ),
              Text(
                'Customize your news preference',
                style: kMutedTextStyle,
              ),
              SizedBox(
                height: 24.0,
              ),
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                children: _buildCards(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
