import 'package:flutter/material.dart';
import 'package:news_me/components/banner.dart';
import 'package:news_me/components/browse-header.dart';
import 'package:news_me/components/browse-news-item.dart';
import 'package:news_me/components/channel-card.dart';
import 'package:news_me/components/header-item.dart';
import 'package:news_me/models/channel.dart';
import 'package:news_me/models/newsitem.dart';
import 'package:news_me/utils/garage.dart';
import 'package:news_me/utils/konstants.dart';
import 'package:news_me/utils/news-api.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({Key key}) : super(key: key);

  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  List<dynamic> _favorites;

  List<Channel> _channels = [];
  List<NewsItem> _selectedCategoryItems = [];

  NewsAPI newsAPI = NewsAPI();

  int activeIndex = 0;

  final Map<String, MaterialColor> colors = {
    'business': Colors.indigo,
    'general': Colors.pink,
    'entertainment': Colors.blueGrey,
    'health': Colors.deepOrange,
    'science': Colors.brown,
    'sports': Colors.red,
    'technology': Colors.amber
  };

  Map<String, List<NewsItem>> newsItems = {
    'business': [],
    'general': [],
    'entertainment': [],
    'health': [],
    'science': [],
    'sports': [],
    'technology': []
  };

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  _loadFavorites() async {
    Garage garage = Garage();
    bool hasGarageInit = await garage.init();

    if (hasGarageInit) {
      List<dynamic> favorites = garage.getItem(kFAVORITE_CATEGORIES);

      if (favorites != null) {
        setState(() {
          _favorites = favorites;
          _selectedCategoryItems = newsItems[favorites[activeIndex]];
        });

        _fetchNewsAndArticlesByCategory();
      }

      if (favorites == null || favorites.length == 0) {
        List<Channel> channels = await newsAPI.getRandomChannels();

        setState(() {
          _channels = channels;
        });
      }
    }
  }

  Widget _buildBannerInterface() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          MessageBanner(
              title: 'No favorites set',
              subtitle:
                  'Set your favorite topics to enjoy a personalized reading experience',
              actionText: 'Set favorites',
              action: () {}),
          SizedBox(
            height: 20.0,
          ),
          Text(
            ' or maybe you can browse a list of news sources',
            style: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Rubik',
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            height: 230.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _showChannels(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBrowseFavoritesInterface() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 50.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _showFavorites(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:16.0),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: _showBrowseNews(),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _showChannels() {
    List<Widget> widgets = [];

    for (Channel channel in _channels) {
      widgets.add(ChannelCard(
        channel: channel,
      ));
    }

    return widgets;
  }

  List<Widget> _showFavorites() {
    List<Widget> cards = [];

    if (_favorites != null) {
      for (int i = 0; i < _favorites.length; i++) {
        String favorite = _favorites[i];

        cards.add(
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  activeIndex = i;
                  _selectedCategoryItems = newsItems[favorite];
                });
                _fetchNewsAndArticlesByCategory();
              },
              child: BrowseHeader(
                title: favorite,
                isActive: i == activeIndex,
              ),
            ),
          ),
        );
      }
    }

    return cards;
  }

  void _fetchNewsAndArticlesByCategory() async {
    if (_favorites != null && _favorites.length > 0) {
      
      String categoryToBeSearched = _favorites[activeIndex];

      List<NewsItem> items =
          await newsAPI.getNewsByCategory(_favorites[activeIndex]);
      Map<String, List<NewsItem>> tempNewsItems = newsItems;

      tempNewsItems[_favorites[activeIndex]] = items;

      setState(() {
        newsItems = tempNewsItems;
        if(categoryToBeSearched == _favorites[activeIndex]){
          _selectedCategoryItems = newsItems[_favorites[activeIndex]];
        }
      });
    }
  }

  List<Widget> _showBrowseNews() {
    List<Widget> items = [];
    for (NewsItem newsItem in _selectedCategoryItems) {
      items.add(BrowseNewsItem(newsItem: newsItem));
    }

    return items;
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
            ),
            SizedBox(
              height: _favorites == null || _favorites.length > 0 ? 14.0 : 24.0,
            ),
            _favorites == null || _favorites.length > 0
                ? _buildBrowseFavoritesInterface()
                : _buildBannerInterface(),
          ],
        ),
      ),
    );
  }
}
