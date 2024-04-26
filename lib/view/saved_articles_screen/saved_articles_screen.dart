import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SavedArticlesScreen extends StatelessWidget {
  const SavedArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Articles'),
      ),
    );
  }
}
