import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../controller/saved_article_controller.dart';
import '../../../model/article/article_model.dart';

class ArticleBottomActionsCard extends StatelessWidget {
  const ArticleBottomActionsCard({
    super.key,
    required this.article,
  });

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Share.share(article.url);
              },
              child: SizedBox(
                height: kToolbarHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.share),
                    const SizedBox(width: 10),
                    Text(
                      'Share Article',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                context
                    .read<SavedArticleController>()
                    .toggleSaveArticle(article);
              },
              child: SizedBox(
                height: kToolbarHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<SavedArticleController>(
                      builder: (context, value, child) => Icon(
                        value.isArticleSaved(article) == null
                            ? Icons.bookmark_border
                            : Icons.bookmark,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Save Article',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
