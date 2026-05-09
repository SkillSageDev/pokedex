import 'package:flutter/material.dart';
import 'home/sort.dart';
import 'home/cards.dart';
import 'favourite/favourite_items.dart';
import 'home/sort.dart';

class Favourite extends StatelessWidget {
  const Favourite({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          automaticallyImplyLeading: false,
          title: const Text(
            "Favorites",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Column(
          children: [
            const SizedBox(height: 24),
            const Sort(activeTab: "Favorites"),
             Expanded(
              child: FavouriteItems(),
            ),
          ],
        )
    );
  }
}