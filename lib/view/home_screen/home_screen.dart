import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_news_app/controller/search_screen_controller.dart';
import 'package:flutter_news_app/core/constants/image_constants.dart';
import 'package:provider/provider.dart';

import '../../controller/home_screen_controller.dart';
import '../../global_widgets/article_card.dart';
import '../../model/news_api_response_model.dart';
import '../search_screen/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<HomeScreenController>().getDataByCategory();
    });

    return DefaultTabController(
      length: context.read<HomeScreenController>().categories.length,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
          title: const Text('Daily News'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChangeNotifierProvider<SearchScreenController>(
                        create: (BuildContext context) =>
                            SearchScreenController(),
                        child: const SearchScreen(),
                      ),
                    ));
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_outlined),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Consumer<HomeScreenController>(
              builder: (context, value, child) => SizedBox(
                height: 60,
                child: ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      category: value.categories[index],
                      isSelected: value.selectedCategoryIndex == index,
                      onTap: () {
                        value.onCategoryChanged(index);
                      },
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  itemCount: value.categories.length,
                ),
              ),
            ),
          ),
        ),
        body: Consumer<HomeScreenController>(builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  Article? article =
                      value.newsApiResponseModel?.articles[index];
                  return ArticleCard(article: article);
                },
                itemCount: value.newsApiResponseModel?.articles.length ?? 0,
              ),
            );
          }
        }),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    required this.isSelected,
    this.onTap,
  });
  final String category;
  final bool isSelected;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: isSelected
              ? Border.all(
                  color: Colors.white.withOpacity(0.7),
                  width: 3,
                  strokeAlign: BorderSide.strokeAlignInside,
                )
              : null,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              '${ImageConstants.categoryImagesBasePath}$category.jpg',
            ),
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.multiply,
            ),
          ),
        ),
        child: Center(
            child: Text(
          category[0].toUpperCase() + category.substring(1),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        )),
      ),
    );
  }
}
