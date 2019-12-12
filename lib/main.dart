import 'package:flutter/material.dart';
import 'package:news_me/app.dart';
import 'package:news_me/screens/favorites.dart';
import 'package:news_me/screens/mainpage.dart';
import 'package:news_me/utils/garage.dart';
import 'package:news_me/utils/konstants.dart';

void main() async{
  Garage garage = Garage();
  Widget defaultHome;

  bool isGarageLoaded = await garage.init();
  if(isGarageLoaded){
    var isFirstUse = garage.getItem(kFIRST_USE);
    if(isFirstUse == null){
      defaultHome = FavoritesPage();
    }else{
      defaultHome = MainPage();
    }
    runApp(App(homePage: defaultHome));
  }
}
