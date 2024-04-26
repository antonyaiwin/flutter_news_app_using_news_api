// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_news_app/model/news_api_response_model.dart';
import 'package:flutter_news_app/utils/debouncer.dart';
import 'package:http/http.dart' as http;

import '../auth/secrets.dart';
import '../model/article/article_model.dart';

class SearchScreenController extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  late Debouncer debouncer;
  NewsApiResponseModel? newsApiResponseModel;
  SearchScreenController() : debouncer = Debouncer(milliSeconds: 1000);
  List<ArticleModel> get articles => newsApiResponseModel?.articles ?? [];
  void searchData(String query) {
    Uri uri = Uri(
        scheme: 'https',
        host: 'newsapi.org',
        path: '/v2/everything',
        queryParameters: {
          'q': query,
          'apiKey': newsApiKey,
          'language': 'en',
        });

    debouncer.run(() async {
      var response = await http.get(uri);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        newsApiResponseModel =
            NewsApiResponseModel.fromJson(jsonDecode(response.body));
        log('query : $query\nresponse: ${response.body}');
      } else {
        log('failed search');
      }
      notifyListeners();
    });
  }
}
