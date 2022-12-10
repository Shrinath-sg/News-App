class NewsArticlesSource {
  String? id;
  String? name;

  NewsArticlesSource({
    this.id,
    this.name,
  });
  NewsArticlesSource.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class NewsArticles {
  NewsArticlesSource? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  NewsArticles({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });
  NewsArticles.fromJson(Map<String, dynamic> json) {
    source = (json['source'] != null)
        ? NewsArticlesSource.fromJson(json['source'])
        : null;
    author = json['author']?.toString();
    title = json['title']?.toString();
    description = json['description']?.toString();
    url = json['url']?.toString();
    urlToImage = json['urlToImage']?.toString();
    publishedAt = json['publishedAt']?.toString();
    content = json['content']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (source != null) {
      data['source'] = source!.toJson();
    }
    data['author'] = author;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    data['urlToImage'] = urlToImage;
    data['publishedAt'] = publishedAt;
    data['content'] = content;
    return data;
  }
}

class News {
  String? status;
  int? totalResults;
  List<NewsArticles?>? articles;

  News({
    this.status,
    this.totalResults,
    this.articles,
  });
  News.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    totalResults = json['totalResults']?.toInt();
    if (json['articles'] != null) {
      final v = json['articles'];
      final arr0 = <NewsArticles>[];
      v.forEach((v) {
        arr0.add(NewsArticles.fromJson(v));
      });
      articles = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['totalResults'] = totalResults;
    if (articles != null) {
      final v = articles;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['articles'] = arr0;
    }
    return data;
  }
}
