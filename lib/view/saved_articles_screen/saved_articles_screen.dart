import 'package:flutter/material.dart';
import 'package:flutter_news_app/controller/saved_article_controller.dart';
import 'package:flutter_news_app/global_widgets/article_card.dart';
import 'package:flutter_news_app/model/article/article_model.dart';
import 'package:provider/provider.dart';

class SavedArticlesScreen extends StatelessWidget {
  const SavedArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Articles'),
      ),
      body: Consumer<SavedArticleController>(
        builder: (context, value, child) {
          if (value.articleKeyList.isEmpty) {
            return const Center(
              child: Text('You haven\'t saved any articles yet!'),
            );
          }
          return ListView.separated(
            itemBuilder: (context, index) {
              ArticleModel? article =
                  value.getArticle(value.articleKeyList[index]);
              if (article == null) {
                return const SizedBox();
              }
              return ArticleCard(
                article: article,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: value.articleKeyList.length,
          );
        },
      ),
    );
  }
}
