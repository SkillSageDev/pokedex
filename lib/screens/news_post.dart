import 'package:flutter/material.dart';
import 'news_post/sort.dart';
import 'news_post/main_news.dart';
import 'news_post/sub_news.dart';
import '../navigation/AppRoutes.dart';
import '../utiles/shared_pref.dart';

class NewsPost extends StatefulWidget {
  const NewsPost({super.key});

  @override
  State<NewsPost> createState() => _NewsPostState();
}

class _NewsPostState extends State<NewsPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.favourite).then((_) {
                  if (mounted) {
                    setState(() {});
                  }
                });
              },
              icon: const Icon(Icons.favorite, color: Colors.red),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.signup);
              },
              icon: const Icon(Icons.home, color: Colors.red),
            ),
          ],
        ),
        title: const Text(
          "The News Post",
          style: TextStyle(
            fontSize: 20,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children:  [
          Sort(),
          MainNews(),
          Expanded(child: SubNews()),
        ],
      ),
    );
  }
}