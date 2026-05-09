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
        "description": "When it smashes its opponents with its tail...",
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
    {
      "heroTag": "charmander",
      "color": Colors.redAccent,
      "pokemonDetail": {
        "name": "Charmander",
        "num": "004",
        "type": ["Fire"],
        "img": "assets/images/charmander.png",
        "description": "The flame that burns at the tip of its tail...",
        "height": "0.6 m",
        "weight": "8.5 kg",
        "species": "Lizard Pokemon",
        "ability": "Blaze",
        "stats": {
          "HP": 39,
          "Attack": 52,
          "Defense": 43,
          "Sp. Atk": 60,
          "Sp. Def": 50,
          "Speed": 65,
        },
      }
    },
    {
      "heroTag": "squirtle",
      "color": Colors.blueAccent,
      "pokemonDetail": {
        "name": "Squirtle",
        "num": "007",
        "type": ["Water"],
        "img": "assets/images/squirtle.png",
        "description": "When it retracts its long neck into its shell...",
        "height": "0.5 m",
        "weight": "9.0 kg",
        "species": "Tiny Turtle Pokemon",
        "ability": "Torrent",
        "stats": {
          "HP": 44,
          "Attack": 48,
          "Defense": 65,
          "Sp. Atk": 50,
          "Sp. Def": 64,
          "Speed": 43,
        },
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    // We use GridView.builder instead of ListView.separated
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      // This is the logic that puts the next item "down" when there's no space
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,          // 2 items per row
        crossAxisSpacing: 16,       // Space between left and right
        mainAxisSpacing: 16,        // Space between top and bottom
        childAspectRatio: 0.8,      // Adjust this to fit your content height
      ),
      itemCount: pokemonList.length,
      itemBuilder: (context, index) {
        final pokemon = pokemonList[index];
        final detail = pokemon["pokemonDetail"];

        final itemModel = Item(
          name: detail["name"],
          img: detail["img"],
          num: detail["num"],
          type: List<String>.from(detail["type"]),
          height: detail["height"],
          weight: detail["weight"],
          description: detail["description"],
          species: detail["species"],
          ability: detail["ability"],
          colorValue: (pokemon["color"] as Color).value,
          stats: Map<String, dynamic>.from(detail["stats"]),
        );

        return InkWell(
          borderRadius: BorderRadius.circular(15.0),
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.details, arguments: pokemon);
          },
          child: Container(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 120, // Slightly taller for the grid
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: (pokemon["color"] as Color).withOpacity(0.15),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                      ),
                      child: Center(
                        child: Hero(
                          tag: pokemon["heroTag"],
                          child: Image.asset(detail["img"], height: 80, fit: BoxFit.contain),
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
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        detail["name"],
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "#${detail["num"]}",
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                      ),
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