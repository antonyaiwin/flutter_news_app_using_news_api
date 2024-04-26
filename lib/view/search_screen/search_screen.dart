import 'package:flutter/material.dart';
import 'package:flutter_news_app/controller/search_screen_controller.dart';
import 'package:provider/provider.dart';

import '../../global_widgets/article_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: context.read<SearchScreenController>().searchController,
          decoration: const InputDecoration(
            hintText: 'Search',
            contentPadding: EdgeInsets.all(10),
            isDense: true,
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              context.read<SearchScreenController>().searchData(value);
            }
          },
        ),
      ),
      body: Consumer<SearchScreenController>(
        builder: (context, value, child) {
          if (value.searchController.text.isEmpty) {
            return const Center(
              child: Text('Please enter query to search'),
            );
          } else {
            if (value.articles.isEmpty) {
              return Center(
                child: Text(
                    'No results found for \'${value.searchController.text}\''),
              );
            } else {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return ArticleCard(article: value.articles[index]);
                },
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemCount: value.articles.length,
              );
            }
          }
        },
      ),
    );
  }
}
