import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:news_me/components/topstory.dart';
import 'package:news_me/models/newsitem.dart';
import 'package:news_me/utils/konstants.dart';
import 'package:news_me/utils/news-api.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchTerm = '';
  bool hasSearched = false;
  bool isSearching = false;
  NewsAPI _newsAPI = NewsAPI();
  List<NewsItem> _newsItems = [];

  _doSearch() async {
    setState(() {
      isSearching = true;
    });

    List<NewsItem> items = await _newsAPI.search(searchTerm);

    setState(() {
      _newsItems = items;
      isSearching = false;
      hasSearched = true;
    });

    print(items);
  }

  List<Widget> showSearchResults() {
    List<Widget> widgets = [];

    if (hasSearched) {
      widgets.add(Text(
        'Results',
        style: kHeadingLead,
      ));

      if (_newsItems.length > 0) {
        widgets.add(
          Text(
            'Showing ${_newsItems.length} search results for \'$searchTerm\'',
            style: kMutedTextStyle,
          ),
        );
        widgets.add(SizedBox(
          height: 24.0,
        ));

        for (NewsItem newsItem in _newsItems) {
          widgets.add(
            TopStory(
              newsItem: newsItem,
            ),
          );
        }
      }
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchTerm = value;
                    });
                  },
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 20.0,
                    fontFamily: 'Rubik',
                  ),
                  decoration: InputDecoration(
                    suffixIcon: !isSearching
                        ? IconButton(
                            icon: Icon(LineIcons.search, color: Colors.grey),
                            onPressed: () {
                              _doSearch();
                            },
                          )
                        : Icon(
                            LineIcons.hourglass_3,
                            color: Colors.grey,
                          ),
                    focusColor: Colors.grey,
                    border: InputBorder.none,
                    hintText: 'Search',
                    hintStyle: TextStyle(fontFamily: 'Rubik'),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Expanded(
              child: ListView(
                children: showSearchResults(),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
    );
  }
}
