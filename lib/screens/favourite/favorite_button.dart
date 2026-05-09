import 'package:flutter/material.dart';
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
    final exists = favorites.any((e) => e.name == widget.item.name);
    if (mounted) setState(() => isFavorite = exists);
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
          await DatabaseService.instance.removeFavoriteByName(widget.item.name);
        } else {
          await DatabaseService.instance.addFavorite(widget.item);
        }
        setState(() => isFavorite = !isFavorite);
        if (widget.onToggle != null) widget.onToggle!();
      },
    );
  }
}