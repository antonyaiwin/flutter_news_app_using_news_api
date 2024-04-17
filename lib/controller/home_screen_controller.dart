import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../auth/secrets.dart';
import '../model/news_api_response_model.dart';

class HomeScreenController extends ChangeNotifier {
  NewsApiResponseModel? newsApiResponseModel;
  bool isLoading = false;
  List<String> categories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology',
  ];
  int selectedCategoryIndex = 0;

  Future<void> getDataByCategory() async {
    isLoading = true;
    notifyListeners();
    Uri uri = Uri(
        scheme: 'https',
        host: 'newsapi.org',
        path: '/v2/top-headlines',
        queryParameters: {
          'category': categories[selectedCategoryIndex],
          'apiKey': newsApiKey,
          'language': 'en',
          'country': 'in',
        });

    var response = await http.get(uri);
    log(response.body);
    if (response.statusCode == 200) {
      newsApiResponseModel =
          NewsApiResponseModel.fromJson(jsonDecode(response.body));
    } else {
      log('failed');
    }
    isLoading = false;
    notifyListeners();
  }

  onCategoryChanged(int index) {
    selectedCategoryIndex = index;
    getDataByCategory();
  }
}
