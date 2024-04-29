import 'package:flutter/material.dart';
import 'package:flutter_news_app/controller/saved_article_controller.dart';
import 'package:provider/provider.dart';

import '../model/article/article_model.dart';
import '../view/article_screen/article_screen.dart';
import 'article_author_date_view.dart';
import 'my_cached_network_image.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    super.key,
    required this.article,
  });

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleScreen(article: article),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 41, 41, 41),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Hero(
              tag: article.urlToImage ?? article,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: MyCachedNetworkImage(
                    imageUrl: article.urlToImage ?? '',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          article.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Consumer<SavedArticleController>(
                        builder: (context, value, child) => IconButton(
                          onPressed: () {
                            value.toggleSaveArticle(article);
                          },
                          icon: Icon(value.isArticleSaved(article) != null
                              ? Icons.bookmark
                              : Icons.bookmark_border),
                        ),
                      ),
                    ],
                  ),
                  Text(article.description ?? ''),
                  ArticleAuthorDateView(article: article),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
