import 'package:flutter/material.dart';
import 'news_post/sort.dart';
import 'news_post/main_news.dart';
import 'favourite_news/favourite_items.dart';

class Favourite extends StatelessWidget {
  const Favourite({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(


        appBar: AppBar(
          title: const Text("The Favourite News", style: TextStyle(fontSize: 24,color: Colors.red,fontWeight: FontWeight.bold),),centerTitle: true,
        ),


        body: Column
          (
          children:
          [
            Expanded(child: FavouriteItems()),
          ],
        )




    );
  }
}