import 'package:news_app/core/network/network_connection.dart';
import 'package:news_app/features/news/data/datasource/news_datasource.dart';
import 'package:news_app/features/news/data/model/news_local_model.dart';
import 'package:news_app/features/news/domain/entities/news_entity.dart';
import 'package:news_app/features/news/domain/repository/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsDataSource newsDataSource;
  final NetworkInfo networkInfo;

  NewsRepositoryImpl({required this.newsDataSource, required this.networkInfo});
  @override
  Future<List<NewsEntity>> fetchNewsArticles() async {
    if (await networkInfo.isConnected) {
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
    } else {
      return getSavedNews();
    }
  }

  @override
  Future<int> addNewsArticle(NewsEntity news) async {
    final localModel = NewsLocalModel(
      title: news.title,
      author: news.author,
      description: news.description,
      url: news.url,
      publishedAt: news.publishedAt,
      content: news.content,
    );

    return await newsDataSource.addNewsArticle(localModel);
  }

  @override
  Future<List<NewsEntity>> getSavedNews() async {
    final result = await newsDataSource.getSavedNews();

    return result
        .map(
          (model) => NewsEntity(
            id: model.id,
            author: model.author,
            title: model.title,
            description: model.description,
            url: model.url,
            publishedAt: model.publishedAt,
            content: model.content,
          ),
        )
        .toList();
  }
}
