import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/model/news_api_response_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../global_widgets/article_author_date_view.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Happy Reading'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(3),
            child: Hero(
              tag: article,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
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
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ArticleAuthorDateView(article: article),
                const SizedBox(height: 10),
                Text(article.content ?? ''),
                ElevatedButton(
                  onPressed: () {
                    launchUrl(Uri.parse(article.url));
                  },
                  child: const Text('Read more'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
