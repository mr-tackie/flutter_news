import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:news_me/models/newsitem.dart';
import 'package:news_me/utils/konstants.dart';
import 'package:time_formatter/time_formatter.dart';

class TopStory extends StatelessWidget {
  TopStory({@required this.newsItem});

  final NewsItem newsItem;

  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.parse(newsItem.publishedAt).millisecondsSinceEpoch;
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 2.0, // soften the shadow
                    spreadRadius: 1.0,
                    offset: Offset(
                      5,
                      5,
                    ),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: newsItem.urlToImage != null
                    ? FadeInImage.assetNetwork(
                        image: newsItem.urlToImage,
                        placeholder: 'assets/images/loading.png',
                        fit: BoxFit.cover,
                        width: 70,
                        height: 70,
                      )
                    : Image.asset(
                        'assets/images/placeholder.png',
                        fit: BoxFit.cover,
                        width: 70,
                        height: 70,
                      ),
              ),
            ),
            SizedBox(
              width: 25.0,
            ),
            Expanded(
              child: Column(
                children: <Widget>[
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
                  SizedBox(height: 4.0,),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                      newsItem.title,
                      maxLines: 2,
                      style: kHeadlineSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                      newsItem.content != null ? newsItem.content : '',
                      maxLines: 2,
                      style: kMutedTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 8.0,),
                  Row(
                    children: <Widget>[
                      Icon(LineIcons.clock_o, size: 18.0, color: Color(0xFF999999),),
                      SizedBox(width: 6.0,),
                      Text(
                      newsItem.publishedAt != null ? formatTime(dateTime) : '',
                      maxLines: 2,
                      style: kTextMutedSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                    ],
                  ),
                ],
              ),
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
