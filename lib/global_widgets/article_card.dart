import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/news_api_response_model.dart';
import '../view/article_screen/article_screen.dart';
import 'article_author_date_view.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    super.key,
    required this.article,
  });

  final Article? article;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleScreen(article: article!),
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 236, 236, 236),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: article?.urlToImage ?? '',
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/no_image.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Text(
                    article?.title ?? '',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(article?.description ?? ''),
                  ArticleAuthorDateView(article: article!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
