class NewsItem{
  dynamic source;
  String title;
  String url;
  String urlToImage;
  String content;
  String publishedAt;
  String author;
  String description;


  NewsItem.fromJson(Map<String, dynamic> parsedJSON)
    : source = parsedJSON['source'],
      title = parsedJSON['title'],
      url = parsedJSON['url'],
      urlToImage = parsedJSON['urlToImage'],
      content = parsedJSON['content'],
      publishedAt = parsedJSON['publishedAt'].substring(0, 10)+" "+parsedJSON["publishedAt"].substring(11, 19),
      description = parsedJSON['description'],
      author = parsedJSON['author'];
}