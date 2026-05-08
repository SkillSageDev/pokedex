import 'package:flutter/material.dart';
import '../../navigation/AppRoutes.dart';
import '../../model/item.dart';
import '../favourite_news/favorite_button.dart';

class SubNews extends StatefulWidget {
  const SubNews({super.key});

  @override
  State<SubNews> createState() => _SubNewsState();
}

// Part 2: The State class
class _SubNewsState extends State<SubNews> {
  final List<Item> items = const [
    Item(imagePath: "assets/Image1.png", title: 'Elon Musk Found \$700 On The Floor And Said "it\'s mine"'),
    Item(imagePath: "assets/Image2.png", title: 'A Very Rare Species Bird Found In The Amazon Forest'),
    Item(imagePath: "assets/Image3.png", title: 'Scientist Found That Humans Brains is More Advanced Than We Thought'),
    Item(imagePath: "assets/Image1.png", title: 'Elon Musk Found \$700 On The Floor And Said "it\'s mine"'),
    Item(imagePath: "assets/Image2.png", title: 'A Very Rare Species Bird Found In The Amazon Forest'),
    Item(imagePath: "assets/Image3.png", title: 'Scientist Found That Humans Brains is More Advanced Than We Thought'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: items.length,
      separatorBuilder: (context, index) => const SizedBox(height: 24),
      itemBuilder: (context, index) {
        return InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.details,
              arguments: items[index],
            ).then((_) {
              setState(() {});
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Image.asset(
                      items[index].imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        items[index].title,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      FavoriteButton(key: UniqueKey(), item: items[index],),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}