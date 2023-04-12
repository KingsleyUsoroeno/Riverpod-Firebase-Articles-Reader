import 'package:sport_house/data/dto/article_dto.dart';

class NewsState {
  final List<ArticleDto> articles;
  final List<ArticleDto> searchResults;
  final bool isLoading;
  final String? errorMessage;

  NewsState({
    this.articles = const [],
    this.searchResults = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  List<ArticleDto> get newsArticleFeed => searchResults.isEmpty ? articles : searchResults;

  NewsState copyWith({
    List<ArticleDto>? articles,
    List<ArticleDto>? searchResults,
    bool? isLoading,
    String? errorMessage,
  }) {
    return NewsState(
      articles: articles ?? this.articles,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      searchResults: searchResults ?? this.searchResults,
    );
  }
}
