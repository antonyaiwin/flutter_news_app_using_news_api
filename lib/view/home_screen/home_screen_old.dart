import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeScreenOld extends StatelessWidget {
  const HomeScreenOld({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        title: const Text('Daily News'),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_outlined))
        ],
      ),
      body: Column(
        children: [
          CarouselSlider.builder(
            itemCount: 5,
            itemBuilder: (context, index, realIndex) => Container(
              color: Colors.amber,
              height: 100,
              width: 100,
            ),
            options: CarouselOptions(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.watch_later), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}
