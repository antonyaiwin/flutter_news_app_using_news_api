import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/saved_article_controller.dart';
import '../../../global_widgets/my_cached_network_image.dart';
import '../../../model/article/article_model.dart';
import '../../../utils/functions.dart';
import '../../article_screen/article_screen.dart';

class CarouselItemCard extends StatelessWidget {
  const CarouselItemCard({
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(
                child:
                    MyCachedNetworkImage(imageUrl: article.urlToImage ?? '')),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Consumer<SavedArticleController>(
                      builder: (context, value, child) => IconButton(
                        onPressed: () {
                          value.toggleSaveArticle(article);
                        },
                        icon: CircleAvatar(
                          child: Icon(value.isArticleSaved(article) != null
                              ? Icons.bookmark
                              : Icons.bookmark_border),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    article.title,
                    maxLines: 4,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 15,
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          article.source.name,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: Colors.white,
                                  ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        getFormattedDate(article.publishedAt),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ],
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
