import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:sport_house/data/dto/article_dto.dart';
import 'package:sport_house/data/exceptions.dart';

final newsApiServiceProvider = Provider((_) => NewsApiService());

const String apiKey = String.fromEnvironment("API_KEY", defaultValue: "");

class NewsApiService {
  final String _baseUrl = "newsapi.org";

  Future<List<ArticleDto>> fetchTeslaArticles() async {
    if (apiKey.isEmpty) throw InvalidApiKeyException("Please provide a valid api key");
    final Uri uri = Uri.https(_baseUrl, 'v2/everything', {
      "q": "tesla",
      "from": "2023-04-09",
      "sortBy": "publishedAt",
      "apiKey": apiKey,
    });
    final response = await http.get(uri);
    final data = jsonDecode(response.body);
    return List.from(data["articles"]).map((json) => ArticleDto.fromJson(json)).toList();
  }
}
