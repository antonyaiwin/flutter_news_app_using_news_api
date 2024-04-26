// To parse this JSON data, do
//
//     final newsApiResponseModel = newsApiResponseModelFromJson(jsonString);

import 'dart:convert';

import 'article/article_model.dart';

NewsApiResponseModel newsApiResponseModelFromJson(String str) =>
    NewsApiResponseModel.fromJson(json.decode(str));

String newsApiResponseModelToJson(NewsApiResponseModel data) =>
    json.encode(data.toJson());

class NewsApiResponseModel {
  String status;
  int totalResults;
  List<ArticleModel> articles;

  NewsApiResponseModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsApiResponseModel.fromJson(Map<String, dynamic> json) =>
      NewsApiResponseModel(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<ArticleModel>.from(
            json["articles"].map((x) => ArticleModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}
