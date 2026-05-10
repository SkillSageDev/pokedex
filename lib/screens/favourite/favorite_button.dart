import 'package:flutter/material.dart';
import 'package:pokedex/services/realtime_database.dart';
import '../../services/database_service.dart';
import '../../model/item.dart';

class FavoriteButton extends StatefulWidget {
  final Item item;
  final VoidCallback? onToggle;

  const FavoriteButton({super.key, required this.item, this.onToggle});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkDatabase();
  }

  Future<void> _checkDatabase() async {
    final favorites = await DatabaseService.instance.getFavorites();
    final rtIsFavorites = await RealtimeDatabase.isFav(widget.item.id);
    final exists = favorites.any((e) => e.name == widget.item.name);

    // if (mounted) setState(() => isFavorite = exists);
    if (mounted) setState(() => isFavorite = rtIsFavorites);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.grey,
      ),
      onPressed: () async {
        if (isFavorite) {
          // await DatabaseService.instance.removeFavoriteByName(widget.item.name);
          await RealtimeDatabase.removeFavoriteByName(widget.item.id);
        } else {
          // await DatabaseService.instance.addFavorite(widget.item);
          await RealtimeDatabase.addFavorite(widget.item);
        }
        setState(() => isFavorite = !isFavorite);
        if (widget.onToggle != null) widget.onToggle!();
      },
    );
  }
}

