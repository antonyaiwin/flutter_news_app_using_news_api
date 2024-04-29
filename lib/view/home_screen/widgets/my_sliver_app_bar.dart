import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/home_screen_controller.dart';
import '../../../controller/search_screen_controller.dart';
import '../../search_screen/search_screen.dart';

class MySliverAppBar extends StatelessWidget {
  const MySliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
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
                    create: (BuildContext context) => SearchScreenController(),
                    child: const SearchScreen(),
                  ),
                ));
          },
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }
}
