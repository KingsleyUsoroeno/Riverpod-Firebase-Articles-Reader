class ArticleDto {
  final String? title;
  final String? author;
  final String? description;
  final String url;
  final String urlToImage;
  final String? publishedAt;
  final String? content;

  ArticleDto({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.author,
  });

  factory ArticleDto.fromJson(Map<String, dynamic> map) {
    return ArticleDto(
      title: map['title'],
      author: map['author'],
      description: map['description'],
      url: map['url'],
      urlToImage: map['urlToImage'] ?? 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
      publishedAt: map['publishedAt'],
      content: map['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "author": author,
      "description": description,
      "url": url,
      "urlToImage": urlToImage,
      "content": content,
      "publishedAt": publishedAt,
    };
  }

  @override
  String toString() {
    return 'ArticleDto{title: $title, author: $author, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, content: $content}';
  }
}