import 'package:sport_house/data/dto/article_dto.dart';

class NewsState {
  final List<ArticleDto> articles;
  final bool isLoading;
  final String? errorMessage;

  NewsState({
    this.articles = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  NewsState copyWith({List<ArticleDto>? articles, bool? isLoading, String? errorMessage}) {
    return NewsState(
      articles: articles ?? this.articles,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
