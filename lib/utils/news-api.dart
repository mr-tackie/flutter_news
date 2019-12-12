import 'dart:io';

import 'package:http/http.dart' as http;

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
}
