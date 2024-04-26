import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/controller/saved_article_controller.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../global_widgets/article_author_date_view.dart';
import '../../model/article/article_model.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key, required this.article});
  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Happy Reading'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Share.share(article.url);
              },
              icon: const Icon(Icons.share)),
          Consumer<SavedArticleController>(
            builder: (context, value, child) => IconButton(
              onPressed: () {
                value.toggleSaveArticle(article);
              },
              icon: Icon(
                value.isArticleSaved(article) == null
                    ? Icons.bookmark_border
                    : Icons.bookmark,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(3),
              child: Hero(
                tag: article,
                child: ClipRRect(
                  // borderRadius: BorderRadius.circular(10),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: article.urlToImage ?? '',
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/images/no_image.jpg'),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Text(
                    article.title,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  ArticleAuthorDateView(article: article),
                  const SizedBox(height: 30),
                  Text(
                    article.content ?? '',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 20,
                        ),
                  ),
                  GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse(article.url));
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'See full article',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const Icon(Icons.arrow_right),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
