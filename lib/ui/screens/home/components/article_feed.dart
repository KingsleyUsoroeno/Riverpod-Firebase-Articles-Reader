import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sport_house/data/dto/article_dto.dart';

class ArticleFeed extends StatelessWidget {
  final List<ArticleDto> articles;

  const ArticleFeed({Key? key, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 30),
      itemCount: articles.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (_, index) {
        final newsArticle = articles[index];
        return Container(
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300, //New
                  blurRadius: 10.0,
                  offset: const Offset(10, 5))
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(newsArticle.urlToImage),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              if (newsArticle.title != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    newsArticle.title!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 15),
                    maxLines: 3,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
