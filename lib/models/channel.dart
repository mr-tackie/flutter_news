class Channel{
  String id;
  String name;
  String url;
  String description;
  String category;

  Channel.fromJson(Map<String, dynamic> parsedJSON) 
    : id = parsedJSON['id'],
      name = parsedJSON['name'],
      url = parsedJSON['url'],
      description = parsedJSON['description'],
      category = parsedJSON['category'];
}