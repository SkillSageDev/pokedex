import 'package:flutter/material.dart';
import '../../navigation/AppRoutes.dart';
import '../../model/item.dart';
import '../../services/database_service.dart';
import 'favorite_button.dart';

class FavouriteItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Item>>(
      future: DatabaseService.instance.getFavorites(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No favorites found"));
        }

        final items = snapshot.data!;

        return ListView.separated(
          padding: const EdgeInsets.all(8.0),
          itemCount: items.length,
          separatorBuilder: (context, index) => const SizedBox(height: 24),
          itemBuilder: (context, index) {
            return InkWell(
              borderRadius: BorderRadius.circular(8.0),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.details, arguments: items[index]);
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  items[index].title,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              FavoriteButton(item: items[index])
                            ],
                          )
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