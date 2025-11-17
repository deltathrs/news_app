import 'package:news_app/features/news/domain/entities/news_entity.dart';

abstract class NewsRepository {
  Future<List<NewsEntity>> fetchNewsArticles();
  Future<int> addNewsArticle(NewsEntity news);
  Future<List<NewsEntity>> getSavedNews();
}
