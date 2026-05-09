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
    _checkDatabase(); // This is the fix! It runs when you return to Home.
  }

  // This ensures the heart stays red even if you scroll the list
  @override
  void didUpdateWidget(covariant FavoriteButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item.title != widget.item.title) {
      _checkDatabase();
    }
  }

  Future<void> _checkDatabase() async {
    final favorites = await DatabaseService.instance.getFavorites();
    final exists = favorites.any((e) => e.title == widget.item.title);
    if (mounted) {
      setState(() {
        isFavorite = exists;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.grey,
      ),
      onPressed: () async {
        setState(() { isFavorite = !isFavorite; });

        if (isFavorite) {
          await DatabaseService.instance.addFavorite(widget.item);
        } else {
          await DatabaseService.instance.removeFavoriteByTitle(widget.item.title);
        }

        if (widget.onToggle != null) widget.onToggle!();
      },
    );
  }
}