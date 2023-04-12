import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sport_house/data/dto/article_dto.dart';
import 'package:sport_house/data/exceptions.dart';
import 'package:sport_house/data/repository/news_repository.dart';
import 'package:sport_house/ui/screens/home/provider/news_state.dart';

final newsProvider = StateNotifierProvider.autoDispose<NewsNotifier, NewsState>(
    (ref) => NewsNotifier(ref.read(newsRepositoryProvider)));

class NewsNotifier extends StateNotifier<NewsState> {
  final NewsRepository _newsRepository;

  NewsNotifier(this._newsRepository) : super(NewsState()) {
    fetchTeslaNewsArticles();
  }

  Future<void> fetchTeslaNewsArticles() async {
    try {
      state = state.copyWith(isLoading: true);
      final articles = await _newsRepository.fetchTeslaNewsArticles();
      state = state.copyWith(isLoading: false, articles: articles);
    } on InvalidApiKeyException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
    } catch (exception) {
      debugPrint("exception caught is ${exception.toString()}");
      state = state.copyWith(isLoading: false, errorMessage: exception.toString());
    }
  }

  Future<void> performSearch(String searchQuery) async {
    if (state.articles.isEmpty) return;

    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(milliseconds: 500));
    final List<ArticleDto> results;
    if (searchQuery.isEmpty) {
      results = [];
    } else {
      results = state.articles.where((article) {
        return article.title != null &&
            article.title!.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    state = state.copyWith(isLoading: false, searchResults: results);
  }
}
