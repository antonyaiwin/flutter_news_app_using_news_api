import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/article/article_model.dart';

class ArticleAuthorDateView extends StatelessWidget {
  const ArticleAuthorDateView({
    super.key,
    required this.article,
  });

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.live_tv_rounded),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            article.source.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ),
        ),
        const SizedBox(width: 5),
        const Text('•'),
        const SizedBox(width: 5),
        Text(
          DateFormat('EEEE, d MMMM yyyy').format(article.publishedAt),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
        ),
      ],
    );
  }
}
