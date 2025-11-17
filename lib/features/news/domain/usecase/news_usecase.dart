import 'package:news_app/features/news/domain/entities/news_entity.dart';
import 'package:news_app/features/news/domain/repository/news_repository.dart';

class NewsUsecase {
  final NewsRepository newsRepository;

  NewsUsecase({required this.newsRepository});

  Future<List<NewsEntity>> fetchNewsArticles() async {
    return await newsRepository.fetchNewsArticles();
  }

  Future<int> addNewsArticle(NewsEntity news) async {
    return await newsRepository.addNewsArticle(news);
  }

  Future<List<NewsEntity>> getSavednews() async {
    return await newsRepository.getSavedNews();
  }

  // Future<List<NewsEntity>> getOfflineNewsArticles() async {
  //   return await newsRepository.getOfflineNewsArticles();
  // }
}
