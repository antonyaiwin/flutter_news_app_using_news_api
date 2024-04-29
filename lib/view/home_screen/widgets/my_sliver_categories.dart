import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/home_screen_controller.dart';
import 'category_card.dart';

class MySliverNewsCategories extends StatelessWidget {
  const MySliverNewsCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      primary: false,
      pinned: true,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Consumer<HomeScreenController>(
          builder: (context, value, child) => SizedBox(
            height: 60,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemCount: value.categories.length,
            ),
          ),
        ),
      ),
    );
  }
}
