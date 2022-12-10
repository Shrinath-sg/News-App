import 'dart:convert';
import 'dart:io';
import 'package:news_app/utils/constants.dart' as constants;
import 'package:http/http.dart' as http;
import 'package:news_app/models/news_model.dart';

class NewsService {
  static Future<List<NewsArticles?>?> getAllBreakingNews() async {
    try {
      const url =
          '${constants.baseUrl}top-headlines?country=us&apiKey=${constants.apiKey}';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> json =
            jsonDecode(response.body) as Map<String, dynamic>;
        final newsData = News.fromJson(json);

        return newsData.articles;
      }
      return [];
    } on SocketException {
      throw Exception('No Internet');
    } catch (error) {
      throw Exception(error);
    }
  }

  static Future<List<NewsArticles?>?> searchNews(
      {required String? searchTerm}) async {
    try {
      final url =
          '${constants.baseUrl}everything?q=$searchTerm&sortBy=popularity&apiKey=${constants.apiKey}';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> json =
            jsonDecode(response.body) as Map<String, dynamic>;
        final newsData = News.fromJson(json);

        return newsData.articles;
      }
      return [];
    } on SocketException {
      throw Exception('No Internet');
    } catch (error) {
      throw Exception(error);
    }
  }
}
