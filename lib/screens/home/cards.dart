import 'package:flutter/material.dart';
import '../../navigation/AppRoutes.dart';
import '../../model/item.dart';
import '../favourite/favorite_button.dart';

class Cards extends StatefulWidget {
  const Cards({super.key});

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  final List<Map<String, dynamic>> pokemonList = [
    {
      "heroTag": "bulbasaur",
      "color": Colors.teal,
      "pokemonDetail": {
        "name": "Bulbasaur",
        "num": "001",
        "type": ["Grass", "Poison"],
        "img": "assets/images/bulbasaur.png",
        "description": "Bulbasaur can be seen napping in bright sunlight...",
        "height": "0.7 m",
        "weight": "6.9 kg",
        "species": "Seed Pokemon",
        "ability": "Overgrow",
        "stats": {
          "HP": 45,
          "Attack": 49,
          "Defense": 49,
          "Sp. Atk": 65,
          "Sp. Def": 65,
          "Speed": 45,
        },
      }
    },
    {
      "heroTag": "pikachu",
      "color": Colors.orange,
      "pokemonDetail": {
        "name": "Pikachu",
        "num": "025",
        "type": ["Electric"],
        "img": "assets/images/pikachu.png",
        "description":
        "When it smashes its opponents with its tail, it delivers a surge of electricity equivalent to a lightning bolt.",
        "height": "0.4 m",
        "weight": "6.0 kg",
        "species": "Mouse Pokemon",
        "ability": "Static",
        "stats": {
          "HP": 35,
          "Attack": 55,
          "Defense": 40,
          "Sp. Atk": 50,
          "Sp. Def": 50,
          "Speed": 90,
        },
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      alignment: Alignment.topLeft,
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        scrollDirection: Axis.horizontal,
        itemCount: pokemonList.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final pokemon = pokemonList[index];
          final detail = pokemon["pokemonDetail"];

          // Mapping the new complex Item model
          final itemModel = Item(
            title: detail["name"],
            imagePath: detail["img"],
            num: detail["num"],
            type: List<String>.from(detail["type"]),
            height: detail["height"],
            weight: detail["weight"],
            description: detail["description"],
            stats: Map<String, int>.from(detail["stats"]),
          );

          return Align(
            alignment: Alignment.topCenter,
            child: InkWell(
              borderRadius: BorderRadius.circular(15.0),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.details,
                    arguments: pokemon);
              },
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: (pokemon["color"] as Color).withOpacity(0.15),
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(15)),
                          ),
                          child: Center(
                            child: Hero(
                              tag: pokemon["heroTag"],
                              child: Image.asset(detail["img"],
                                  height: 70, fit: BoxFit.contain),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: FavoriteButton(
                            key: ValueKey(detail["name"]),
                            item: itemModel,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detail["name"],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "#${detail["num"]}",
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}