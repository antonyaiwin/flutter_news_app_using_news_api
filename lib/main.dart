import 'package:flutter/material.dart';
import 'package:flutter_news_app/controller/home_screen_controller.dart';
import 'package:flutter_news_app/controller/saved_article_controller.dart';
import 'package:flutter_news_app/model/article/article_model.dart';
import 'package:flutter_news_app/model/article/source_model.dart';
import 'package:flutter_news_app/view/home_screen/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleModelAdapter());
  Hive.registerAdapter(SourceAdapter());
  await Hive.openBox<ArticleModel>(SavedArticleController.hiveBoxName);
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
        ChangeNotifierProvider(
          create: (context) => SavedArticleController(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 98, 13, 6),
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
