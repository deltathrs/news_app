class NewsEntity {
  final int? id;
  final String author;
  final String title;
  final String description;
  final String url;
  final DateTime publishedAt;
  final String content;

  NewsEntity(
      {this.id,
      required this.author,
      required this.title,
      required this.description,
      required this.publishedAt,
      required this.url,
      required this.content});
}
