import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/home_screen_controller.dart';
import '../../global_widgets/article_card.dart';
import '../../model/article/article_model.dart';
import 'widgets/home_screen_drawer.dart';
import 'widgets/my_sliver_app_bar.dart';
import 'widgets/my_sliver_categories.dart';
import 'widgets/top_headlines_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      context.read<HomeScreenController>().requestData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const MySliverAppBar(),
          const SliverToBoxAdapter(
            child: TopHeadlinesWidget(),
          ),
          const MySliverNewsCategories()
        ],
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
                ArticleModel article =
                    value.newsApiResponseModel!.articles[index];
                return ArticleCard(article: article);
              },
              itemCount: value.newsApiResponseModel?.articles.length ?? 0,
            );
          }
        }),
      ),
      drawer: const HomeScreenDrawer(),
    );
  }
}
