import 'package:logger/logger.dart';
import 'package:news_app/core/db/database_helper.dart';
import 'package:news_app/core/network/api_services.dart';
import 'package:news_app/features/news/data/model/news_model.dart';

abstract class NewsDataSource {
  Future<List<Article>> fetchNewsArticles();
  // Future<int> addNewsArticle(NewsModel news);
  // Future<List<Article>> getOfflineNewsArticles();
}

class NewsDataSourceImpl implements NewsDataSource {
  final ApiService apiService;

  NewsDataSourceImpl({required this.apiService});

  final Logger _logger = Logger();
  @override
  Future<List<Article>> fetchNewsArticles() async {
    try {
      final response = await apiService.getApiData(
        queryParams: {
          'q': 'in',
          'language': 'id',
        },
      );

      if (response.statusCode == 200) {
        final data = response.data['articles'] as List;

        return data.map((json) => Article.fromJson(json)).toList();
      } else {
        _logger.e(
            'Failed to fetch news articles. Status code: ${response.statusCode}');
        throw Exception('Failed to fetch news articles');
      }
    } catch (e) {
      _logger.e('Error fetching news articles: $e');
      throw Exception('Error fetching news articles: $e');
    }
  }

  // @override
  // Future<int> addNewsArticle(Article news) async {
  //   final db = await DatabaseHelper.database();
  //   return db.insert(DatabaseHelper.DB_NAME, news.toJson());
  // }
}
