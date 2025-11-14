import 'package:logger/logger.dart';
import 'package:news_app/core/network/api_services.dart';
import 'package:news_app/features/news/data/model/news_model.dart';

abstract class NewsDataSource {
  Future<List<Article>> fetchNewsArticles();
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
        final data = response.data['articles'];
        return data;
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
}
