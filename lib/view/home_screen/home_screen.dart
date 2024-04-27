import 'package:flutter/material.dart';
import 'package:flutter_news_app/controller/search_screen_controller.dart';
import 'package:provider/provider.dart';

import '../../controller/home_screen_controller.dart';
import '../../global_widgets/article_card.dart';
import '../../model/article/article_model.dart';
import '../saved_articles_screen/saved_articles_screen.dart';
import '../search_screen/search_screen.dart';
import 'widgets/category_card.dart';

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
          title: const Text('Daily News'),
          actions: [
            Consumer<HomeScreenController>(
              builder: (context, value, child) => DropdownButton(
                alignment: Alignment.centerRight,
                value: value.selectedCountryIndex,
                icon: const Icon(Icons.location_on_rounded),
                items: List.generate(value.countryNames.length, (index) {
                  var map = value.countryNames;
                  return DropdownMenuItem(
                    value: index,
                    child: Text(map[map.keys.elementAt(index)]!),
                  );
                }),
                underline: const SizedBox(),
                onChanged: (index) {
                  value.onCountryChanged(index ?? 0);
                },
              ),
            ),
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
          } else if (value.newsApiResponseModel?.articles.isEmpty ?? true) {
            return const Center(
              child: Text('No articles found!'),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                ArticleModel? article =
                    value.newsApiResponseModel?.articles[index];
                return ArticleCard(article: article);
              },
              itemCount: value.newsApiResponseModel?.articles.length ?? 0,
            );
          }
        }),
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  'Antony Aiwin',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                accountEmail: const Text('antonyaiwin@mail.com'),
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://images.pexels.com/photos/4052800/pexels-photo-4052800.jpeg?auto=compress&cs=tinysrgb&w=600'),
                ),
                decoration:
                    BoxDecoration(color: const Color.fromARGB(255, 126, 9, 1)),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SavedArticlesScreen(),
                      ));
                },
                leading: const Icon(Icons.bookmark),
                title: const Text('Saved Articles'),
                trailing: const Icon(Icons.arrow_right),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
