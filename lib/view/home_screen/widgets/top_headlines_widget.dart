import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/home_screen_controller.dart';
import '../../../model/article/article_model.dart';
import 'carousel_item_card.dart';

class TopHeadlinesWidget extends StatelessWidget {
  const TopHeadlinesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          child: Text(
            'Top Headlines',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Consumer<HomeScreenController>(
          builder: (context, value, child) {
            if (value.isTopHeadlinesLoading ||
                (value.topHeadlinesResponseModel?.articles.length ?? 0) == 0) {
              return const AspectRatio(
                aspectRatio: 16 / 10,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {}
            return CarouselSlider.builder(
              itemCount: value.topHeadlinesResponseModel?.articles.length ?? 0,
              itemBuilder: (context, index, realIndex) {
                ArticleModel article =
                    value.topHeadlinesResponseModel!.articles[index];
                return CarouselItemCard(article: article);
              },
              options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 0.9,
                aspectRatio: 16 / 10,
                enlargeCenterPage: true,
                enlargeFactor: 0.2,
              ),
            );
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
