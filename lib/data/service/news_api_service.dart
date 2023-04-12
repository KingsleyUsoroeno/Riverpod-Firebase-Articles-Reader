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
      "from": "2023-03-11",
      "sortBy": "publishedAt",
      "apiKey": apiKey,
    });

    final response = jsonDecode((await http.get(uri)).body);
    return List.from(response["articles"]).map((json) => ArticleDto.fromJson(json)).toList();
  }
}
