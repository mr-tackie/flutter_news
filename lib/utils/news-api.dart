import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:news_me/models/channel.dart';
import 'package:news_me/models/newsitem.dart';

class NewsAPI {
  String url;
  final String key = '0301ca2c06894c74b4939cb6a40a6a99';

  NewsAPI() {
    this.url = "https://newsapi.org/v2";
  }

  Future<dynamic> getTopStories(int page) async {
    var response = await http.get(
        '${this.url}/top-headlines?language=en&page=$page',
        headers: {HttpHeaders.authorizationHeader: "Bearer $key"});

    return response;
  }

  Future<List<Channel>> getRandomChannels() async {
    var response = await http.get(
        '${this.url}/sources?language=en',
        headers: {HttpHeaders.authorizationHeader: "Bearer $key"});
    
    if(response.statusCode == 200){
      List<Channel> channels = [];
      var body = jsonDecode(response.body);
      var sources = body['sources'];

      for(var source in sources){
        channels.add(Channel.fromJson(source));
      }

      channels.shuffle();
      return channels;
    }else{
      throw(Exception('Invalid HTTP request'));
    }
  }

  Future<List<NewsItem>> getNewsByCategory(String category) async{
    var response = await http.get(
        '${this.url}/top-headlines?country=us&category=$category&pageSize=25',
        headers: {HttpHeaders.authorizationHeader: "Bearer $key"});
    
    if(response.statusCode == 200){
      List<NewsItem> newsItems = [];
      var body = jsonDecode(response.body);
      var items = body['articles'];

      for(var item in items){
        newsItems.add(NewsItem.fromJson(item));
      }

      return newsItems;
    }else{
      throw(Exception('Invalid HTTP request ==> ${response.statusCode} : ${response.body}'));
    }

  }
}
