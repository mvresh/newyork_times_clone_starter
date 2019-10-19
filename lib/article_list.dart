class ArticleList {
  String status;
  int totalResults;
  List<Articles> articles;

  ArticleList({this.status, this.totalResults, this.articles});

  ArticleList.fromJson(Map<String, dynamic> headlinesData) {
    status = headlinesData['status'];
    totalResults = headlinesData['totalResults'];
    if (headlinesData['articles'] != null) {
      articles = new List<Articles>();
      headlinesData['articles'].forEach((v) {
        articles.add(new Articles.fromJson(v));
      });
    }
  }
}

class Articles {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Articles(
      {this.source,
        this.author,
        this.title,
        this.description,
        this.url,
        this.urlToImage,
        this.publishedAt,
        this.content});

  Articles.fromJson(Map<String, dynamic> json) {
    source =
    json['source'] != null ? new Source.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }

}

class Source {
  String id;
  String name;

  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}
