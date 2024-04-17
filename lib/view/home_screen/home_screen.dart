import 'package:flutter/material.dart';
import 'package:flutter_news_app/controller/search_screen_controller.dart';
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
          bottom: TabBar(
            padding: EdgeInsets.zero,
            tabAlignment: TabAlignment.start,
            onTap: (value) {
              context.read<HomeScreenController>().onCategoryChanged(value);
            },
            isScrollable: true,
            tabs: context
                .read<HomeScreenController>()
                .categories
                .map((e) => Tab(
                      text: e.toUpperCase(),
                    ))
                .toList(),
          ),
        ),
        body: Consumer<HomeScreenController>(builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              Article? article = value.newsApiResponseModel?.articles[index];
              return ArticleCard(article: article);
            },
            itemCount: value.newsApiResponseModel?.articles.length ?? 0,
          );
        }),
      ),
    );
  }
}
