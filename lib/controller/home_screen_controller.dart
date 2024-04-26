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
    "global": "Global",
    "ae": "United Arab Emirates",
    "ar": "Argentina",
    "at": "Austria",
    "au": "Australia",
    "be": "Belgium",
    "bg": "Bulgaria",
    "br": "Brazil",
    "ca": "Canada",
    "ch": "Switzerland",
    "cn": "China",
    "co": "Colombia",
    "cu": "Cuba",
    "cz": "Czech Republic",
    "de": "Germany",
    "eg": "Egypt",
    "fr": "France",
    "gb": "United Kingdom",
    "gr": "Greece",
    "hk": "Hong Kong",
    "hu": "Hungary",
    "id": "Indonesia",
    "ie": "Ireland",
    "il": "Israel",
    "in": "India",
    "it": "Italy",
    "jp": "Japan",
    "kr": "South Korea",
    "lt": "Lithuania",
    "lv": "Latvia",
    "ma": "Morocco",
    "mx": "Mexico",
    "my": "Malaysia",
    "ng": "Nigeria",
    "nl": "Netherlands",
    "no": "Norway",
    "nz": "New Zealand",
    "ph": "Philippines",
    "pl": "Poland",
    "pt": "Portugal",
    "ro": "Romania",
    "rs": "Serbia",
    "ru": "Russia",
    "sa": "Saudi Arabia",
    "se": "Sweden",
    "sg": "Singapore",
    "sk": "Slovakia",
    "th": "Thailand",
    "tr": "Turkey",
    "tw": "Taiwan",
    "ua": "Ukraine",
    "us": "United States",
    "ve": "Venezuela",
    "za": "South Africa",
  };

  int selectedCategoryIndex = 0;
  int selectedCountryIndex = 0;

  Future<void> getDataByCategory() async {
    isLoading = true;
    notifyListeners();
    Uri uri = Uri(
        scheme: 'https',
        host: 'newsapi.org',
        path: '/v2/top-headlines',
        queryParameters: {
          if (selectedCategoryIndex != 0)
            'category': categories[selectedCategoryIndex],
          'apiKey': newsApiKey,
          // 'language': 'en',
          if (selectedCountryIndex != 0)
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
