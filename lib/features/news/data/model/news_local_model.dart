class NewsLocalModel {
  final int? id;
  final String title;
  final String description;
  final String url;
  final String author;
  final DateTime publishedAt;
  final String content;

  NewsLocalModel({
    this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.url,
    required this.publishedAt,
    required this.content,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author": author,
        "description": description,
        "url": url,
        "publishedAt": publishedAt.toString(),
        "content": content,
      };

  factory NewsLocalModel.fromJson(Map<String, dynamic> json) => NewsLocalModel(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        description: json["description"],
        url: json["url"],
        publishedAt: json["publishedAt"],
        content: json["content"],
      );
}
