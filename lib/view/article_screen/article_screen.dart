import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/controller/saved_article_controller.dart';
import 'package:flutter_news_app/core/constants/image_constants.dart';
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
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: article,
              child: ClipRRect(
                child: CachedNetworkImage(
                  fit: BoxFit.contain,
                  imageUrl: article.urlToImage ?? '',
                  placeholder: (context, url) => const Padding(
                      padding: EdgeInsets.all(100),
                      child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      Image.asset(ImageConstants.noImagePlaceholder),
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
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          Icon(
                            Icons.arrow_right,
                            color: Theme.of(context).colorScheme.primary,
                          ),
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
      bottomNavigationBar: PreferredSize(
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
      ),
    );
  }
}
