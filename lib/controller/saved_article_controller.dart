import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/article/article_model.dart';

class SavedArticleController extends ChangeNotifier {
  static String hiveBoxName = 'articles';
  List articleKeyList = [];
  late Box<ArticleModel> articleBox;

  SavedArticleController() {
    articleBox = Hive.box(hiveBoxName);
    getSavedArticles();
  }

  getSavedArticles() {
    articleKeyList = articleBox.keys.toList();
    notifyListeners();
  }

  addArticleToBox(ArticleModel article) async {
    await articleBox.add(article);
    getSavedArticles();
  }

  removeArticleFromBox(var key) async {
    await articleBox.delete(key);
    getSavedArticles();
  }

  ArticleModel? getArticle(var key) {
    return articleBox.get(key);
  }

  toggleSaveArticle(ArticleModel article) async {
    var key = isArticleSaved(article);
    if (key != null) {
      log('remove article');
      await removeArticleFromBox(key);
    } else {
      log('add article');
      await addArticleToBox(article);
    }
  }

  dynamic isArticleSaved(ArticleModel article) {
    try {
      return articleKeyList.firstWhere(
        (key) => getArticle(key)!.url == article.url,
        orElse: () => null,
      );
    } on StateError catch (e) {
      log(e.toString());
      return null;
    }
  }
}
