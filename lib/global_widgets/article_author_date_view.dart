import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/news_api_response_model.dart';

class ArticleAuthorDateView extends StatelessWidget {
  const ArticleAuthorDateView({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.person),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            article.author ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 5),
        const Text('•'),
        const SizedBox(width: 5),
        Text(DateFormat('EEEE, d MMMM yyyy').format(article.publishedAt)),
      ],
    );
  }
}
