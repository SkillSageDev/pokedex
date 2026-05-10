import 'package:flutter/material.dart';
import 'package:pokedex/services/realtime_database.dart';
import '../../navigation/app_routes.dart';
import '../../model/item.dart';
import 'favorite_button.dart';

class FavouriteItems extends StatefulWidget {
  const FavouriteItems({super.key});

  @override
  State<FavouriteItems> createState() => _FavouriteItemsState();
}

class _FavouriteItemsState extends State<FavouriteItems> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Item>>(
      stream: RealtimeDatabase.watchFavorites(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Couldn't load favorites: ${snapshot.error}",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              "No favorites found",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          );
        }

        final items = snapshot.data!;

        // Changed from ListView to GridView so items wrap to the next line
        return GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            crossAxisSpacing: 16, // Space between cards (left/right)
            mainAxisSpacing: 16, // Space between cards (up/down)
            childAspectRatio: 0.8, // Controls the height of the cards
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            final Map<String, dynamic> pokemonData = {
              "heroTag": "fav_${item.name}",
              "color": Color(item.colorValue),
              "pokemonDetail": {
                "name": item.name,
                "num": item.num,
                "type": item.type,
                "img": item.img,
                "description": item.description,
                "height": item.height,
                "weight": item.weight,
                "species": item.species,
                "ability": item.ability,
                "stats": item.stats,
              },
            };

            return InkWell(
              borderRadius: BorderRadius.circular(15.0),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.details,
                  arguments: pokemonData,
                );
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
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 120, // Increased slightly for the grid look
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(item.colorValue).withOpacity(0.15),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15),
                            ),
                          ),
                          child: Center(
                            child: Hero(
                              tag: "fav_${item.name}",
                              child: Image.asset(
                                item.img,
                                height: 80,
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => const Icon(
                                  Icons.catching_pokemon,
                                  size: 60,
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: FavoriteButton(
                            item: item,
                            onToggle: () => setState(() {}),
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
                            item.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "#${item.num}",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
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
      },
    );
  }
}
