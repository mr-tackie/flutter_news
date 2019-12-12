import 'package:flutter/material.dart';
import 'package:news_me/screens/mainpage.dart';

class App extends StatelessWidget {
  App({@required this.homePage});

  final Widget homePage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'News Me',
        home: homePage,
        routes: <String, WidgetBuilder>{
          '/main' : (BuildContext context) => MainPage(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blue[900],
          accentColor: Colors.green[500],
          backgroundColor: Colors.white
        ));
  }
}
