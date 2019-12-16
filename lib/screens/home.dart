import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_me/components/header-item.dart';
import 'package:news_me/components/topstory.dart';
import 'package:news_me/models/newsitem.dart';
import 'package:news_me/utils/news-api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 1;
  List<NewsItem> _newsItems = [];
  NewsAPI _newsAPI = NewsAPI();

  @override
  void initState() {
    super.initState();
    fetchTopNews();
  }

  fetchTopNews() async {
    var headlineResult = await _newsAPI.getTopStories(_page);
    List<NewsItem> newsItems = [];
    _page++;
    if (headlineResult.statusCode == 200) {
      var result = jsonDecode(headlineResult.body);
      var articles = result['articles'];

      for (var article in articles) {
        NewsItem item = NewsItem.fromJson(article);
        newsItems.add(item);
      }

      setState(() {
        _newsItems = newsItems;
      });
    }
  }

  List<Widget> _buildNewsItems() {
    List<Widget> articles = [SizedBox(height: 16.0,)];

    for (NewsItem item in _newsItems) {
      TopStory topStory = TopStory(
        newsItem: item,
      );
      articles.add(topStory);
    }

    return articles;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            HeaderItem(title: 'Headlines', subtitle: 'Latest news from around the world',),
            SizedBox(
              height: 15.0,
            ),
            Expanded(
                child: ListView(
                  children: _buildNewsItems(),
            ))
          ],
        ),
      ),
    );
  }
}
