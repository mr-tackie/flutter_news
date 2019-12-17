import 'package:flutter_web_browser/flutter_web_browser.dart';

capitalize(String word){
  return word[0].toUpperCase() + word.substring(1);
}

triggerBrowser(url){
 FlutterWebBrowser.openWebPage(
   url: url,
 );
}