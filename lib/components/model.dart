class Model {
  String title;
  String description;
  String url;
  String urlImage;
  DateTime time;
  String content;

  Model({this.title, this.description, this.url, this.urlImage, this.time, this.content});
  Model.json(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlImage = json['urlToImage'];
    time = json['publishedAt'];
    content = json['content'];
  }
}