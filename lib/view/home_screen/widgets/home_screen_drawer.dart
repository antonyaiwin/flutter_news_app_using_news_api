import 'package:flutter/material.dart';

import '../../saved_articles_screen/saved_articles_screen.dart';

class HomeScreenDrawer extends StatelessWidget {
  const HomeScreenDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                const BoxDecoration(color: Color.fromARGB(255, 126, 9, 1)),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SavedArticlesScreen(),
                ),
              );
            },
            leading: const Icon(Icons.bookmark),
            title: const Text('Saved Articles'),
            trailing: const Icon(Icons.arrow_right),
          ),
        ],
      ),
    );
  }
}
