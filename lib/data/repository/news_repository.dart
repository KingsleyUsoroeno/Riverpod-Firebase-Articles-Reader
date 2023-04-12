import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sport_house/data/dto/article_dto.dart';
import 'package:sport_house/data/service/news_api_service.dart';

final newsRepositoryProvider =
    Provider((ref) => NewsRepository(FirebaseFirestore.instance, ref.read(newsApiServiceProvider)));

class NewsRepository {
  final NewsApiService _newsApiService;
  final FirebaseFirestore _firebaseFirestore;

  NewsRepository(this._firebaseFirestore, this._newsApiService);

  CollectionReference<ArticleDto> get _newsArticlesRef =>
      _firebaseFirestore.collection('news-articles').withConverter<ArticleDto>(
          fromFirestore: (snapshots, _) => ArticleDto.fromJson(snapshots.data()!),
          toFirestore: (article, _) => article.toJson());

  Future<List<ArticleDto>> fetchTeslaNewsArticles() async {
    final List<QueryDocumentSnapshot<ArticleDto>> articleSnapshot = await _newsArticlesRef
        .get()
        .then((snapshot) => snapshot.docs)
        .onError((error, stackTrace) => []);

    if (articleSnapshot.isNotEmpty) {
      return articleSnapshot.map((documentSnapshot) => documentSnapshot.data()).toList();
    }

    final articles = await _newsApiService.fetchTeslaArticles();

    try {
      for (var article in articles) {
        await _newsArticlesRef.add(article);
      }
      return articleSnapshot.map((e) => e.data()).toList();
    } catch (exception) {
      debugPrint('exception is $exception');
      return articles;
    }
  }

  Future<List<ArticleDto>> performSearch(String searchQuery) async {
    return List.empty();
  }
}
