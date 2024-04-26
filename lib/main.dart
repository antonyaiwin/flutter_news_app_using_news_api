import 'package:flutter/material.dart';
import 'package:flutter_news_app/controller/home_screen_controller.dart';
import 'package:flutter_news_app/view/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeScreenController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          textTheme: TextTheme(
            bodyMedium: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: const Color.fromARGB(255, 147, 147, 147)),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
