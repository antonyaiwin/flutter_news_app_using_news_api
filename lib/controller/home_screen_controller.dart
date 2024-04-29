import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../auth/secrets.dart';
import '../model/news_api_response_model.dart';

class HomeScreenController extends ChangeNotifier {
  NewsApiResponseModel? newsApiResponseModel;
  NewsApiResponseModel? topHeadlinesResponseModel;
  bool isLoading = false;
  bool isTopHeadlinesLoading = false;

  List<String> categories = [
    'all',
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology',
  ];

  Map<String, String> countryNames = {
    "ar": "Argentina",
    "au": "Australia",
    "at": "Austria",
    "be": "Belgium",
    "br": "Brazil",
    "bg": "Bulgaria",
    "ca": "Canada",
    "cn": "China",
    "co": "Colombia",
    "cu": "Cuba",
    "cz": "Czech Republic",
    "eg": "Egypt",
    "fr": "France",
    "de": "Germany",
    "gr": "Greece",
    "hk": "Hong Kong",
    "hu": "Hungary",
    "in": "India",
    "id": "Indonesia",
    "ie": "Ireland",
    "il": "Israel",
    "it": "Italy",
    "jp": "Japan",
    "lv": "Latvia",
    "lt": "Lithuania",
    "my": "Malaysia",
    "mx": "Mexico",
    "ma": "Morocco",
    "nl": "Netherlands",
    "nz": "New Zealand",
    "ng": "Nigeria",
    "no": "Norway",
    "ph": "Philippines",
    "pl": "Poland",
    "pt": "Portugal",
    "ro": "Romania",
    "ru": "Russia",
    "sa": "Saudi Arabia",
    "rs": "Serbia",
    "sg": "Singapore",
    "sk": "Slovakia",
    "za": "South Africa",
    "kr": "South Korea",
    "se": "Sweden",
    "ch": "Switzerland",
    "tw": "Taiwan",
    "th": "Thailand",
    "tr": "Turkey",
    "ua": "Ukraine",
    "ae": "United Arab Emirates",
    "gb": "United Kingdom",
    "us": "United States",
    "ve": "Venezuela"
  };

  int selectedCategoryIndex = 0;
  int selectedCountryIndex = 17;
  void requestData() {
    getTopHeadlines();
    getDataByCategory();
  }

  Future<void> getTopHeadlines() async {
    isTopHeadlinesLoading = true;
    notifyListeners();
    Uri uri = Uri(
        scheme: 'https',
        host: 'newsapi.org',
        path: '/v2/top-headlines',
        queryParameters: {
          'apiKey': newsApiKey,
          'language': 'en',
          'pageSize': '5',
        });

    log("URL: ${uri.toString()}\n\n");

    var response = await http.get(uri);
    log(response.body);
    if (response.statusCode == 200) {
      topHeadlinesResponseModel =
          NewsApiResponseModel.fromJson(jsonDecode(response.body));
    } else {
      log('failed');
    }
    isTopHeadlinesLoading = false;
    notifyListeners();
  }

  Future<void> getDataByCategory() async {
    isLoading = true;
    notifyListeners();
    Uri uri = Uri(
        scheme: 'https',
        host: 'newsapi.org',
        path: '/v2/top-headlines',
        queryParameters: {
          'apiKey': newsApiKey,
          if (selectedCategoryIndex != 0)
            'category': categories[selectedCategoryIndex],
          // 'language': 'en',
          'country': countryNames.keys.elementAt(selectedCountryIndex),
        });

    log("URL: ${uri.toString()}\n\n");

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

  onCountryChanged(int index) {
    selectedCountryIndex = index;
    getDataByCategory();
  }
}
