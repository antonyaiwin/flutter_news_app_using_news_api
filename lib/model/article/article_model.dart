import 'package:hive/hive.dart';

import 'source_model.dart';

part 'article_model.g.dart';

@HiveType(typeId: 1)
class ArticleModel {
  @HiveField(1)
  Source source;
  @HiveField(2)
  String? author;
  @HiveField(3)
  String title;
  @HiveField(4)
  String? description;
  @HiveField(5)
  String url;
  @HiveField(6)
  String? urlToImage;
  @HiveField(7)
  DateTime publishedAt;
  @HiveField(8)
  String? content;
  @HiveField(9)
  ArticleModel({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        source: Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
      };
}
