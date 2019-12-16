import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:news_me/models/newsitem.dart';
import 'package:news_me/utils/konstants.dart';
import 'package:time_formatter/time_formatter.dart';

class BrowseNewsItem extends StatelessWidget {
  BrowseNewsItem({this.newsItem});

  final NewsItem newsItem;

  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.parse(newsItem.publishedAt).millisecondsSinceEpoch;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: <Widget>[
            newsItem.urlToImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: FadeInImage.assetNetwork(
                      image: newsItem.urlToImage,
                      placeholder: 'assets/images/loading.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 180,
                    ),
                  )
                : Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
            Container(
              height: 180,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                        0.3,
                        0.5,
                        0.7,
                        1
                      ],
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.15),
                        Colors.black.withOpacity(0.35),
                        Colors.black.withOpacity(0.55),
                      ])),
            ),
            Positioned(
              bottom: 10.0,
              left: 10.0,
              child: Container(
                width: 300.0,
                child: Text(
                  newsItem.title,
                  style: kHeading18White,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              newsItem.source['name'],
              style: kTopStorySourceStyle,
            ),
            SizedBox(
              width: 25.0,
            ),
            Expanded(
              child: Text(
                newsItem.author != null ? newsItem.author : '',
                style: kTextMutedSmall,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
              ),
            )
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
        newsItem.content != null ? Text(
          newsItem.content != null ? newsItem.content : '',
          maxLines: 2,
          style: kMutedTextStyle,
          overflow: TextOverflow.ellipsis,
        ) : SizedBox(),
        SizedBox(
          height: newsItem.content != null ? 8.0 : 0.0,
        ),
        Row(
          children: <Widget>[
            Icon(
              LineIcons.clock_o,
              size: 18.0,
              color: Color(0xFF999999),
            ),
            SizedBox(
              width: 6.0,
            ),
            Text(
              newsItem.publishedAt != null ? formatTime(dateTime) : '',
              maxLines: 2,
              style: kTextMutedSmall,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
        SizedBox(
          height: 24.0,
        )
      ],
    );
  }
}
