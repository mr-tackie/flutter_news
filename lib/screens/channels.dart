import 'package:flutter/material.dart';
import 'package:news_me/components/channel-card.dart';
import 'package:news_me/components/header-item.dart';
import 'package:news_me/models/channel.dart';
import 'package:news_me/utils/news-api.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChannelScreen extends StatefulWidget {
  const ChannelScreen({Key key}) : super(key: key);

  @override
  _ChannelScreenState createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  List<String> dropDownValues = [
    'all',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology',
    'general'
  ];
  String selectedItem = 'all';
  bool isSearching = false;
  List<Channel> channels = [];
  NewsAPI newsApi = NewsAPI();

  initState(){
    super.initState();
    changeChannelCategory(dropDownValues[0]);
  }
  changeChannelCategory(String item) async {
    setState(() {
      selectedItem = item;
      isSearching = true;
    });

    List<Channel> results = await newsApi.getChannels(item);

    setState(() {
      isSearching = false;
      channels = results;
    });

    print(channels);
  }

  List<DropdownMenuItem<String>> showDropDownItems() {
    List<DropdownMenuItem<String>> items = [];

    for (String value in dropDownValues) {
      items.add(DropdownMenuItem<String>(
        child: Text(value),
        value: value,
      ));
    }

    return items;
  }

  List<Widget> _buildChannelCards() {
    List<Widget> widgets = [];

    for (Channel channel in channels) {
      widgets.add(
        ChannelCard(
          channel: channel,
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HeaderItem(
              title: 'Channels',
              subtitle: 'Find news sources to read from',
            ),
            Align(
              alignment: Alignment.topRight,
              child: DropdownButton<String>(
                value: selectedItem,
                style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Libre',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300),
                underline: Container(height: 2.0, color: Colors.grey),
                items: showDropDownItems(),
                onChanged: isSearching
                    ? (String item) {}
                    : (String item) {
                        changeChannelCategory(item);
                      },
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            isSearching
                ? Center(child: SpinKitPulse(color: Colors.grey))
                : Expanded(
                    child: ListView(
                    children: <Widget>[
                      GridView.count(
                        crossAxisCount: 2,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        shrinkWrap: true,
                        children: _buildChannelCards(),
                      )
                    ],
                  ))
          ],
        ),
      ),
    );
  }
}
