import 'package:news_app/features/news/data/datasource/news_datasource.dart';
import 'package:news_app/features/news/domain/entities/news_entity.dart';
import 'package:news_app/features/news/domain/repository/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsDataSource newsDataSource;

  NewsRepositoryImpl({required this.newsDataSource});
  @override
  Future<List<NewsEntity>> fetchNewsArticles() async {
    final result = await newsDataSource.fetchNewsArticles();
    return result
        .map((item) => NewsEntity(
            author: item.author ?? 'Unknown',
            title: item.title,
            publishedAt: item.publishedAt,
            description: item.description,
            url: item.urlToImage ?? '',
            content: item.content))
        .toList();
  }
}
