import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pokedex/services/realtime_database.dart';
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
    try {
      final rtIsFavorites = await RealtimeDatabase.isFav(widget.item.id);
      if (mounted) setState(() => isFavorite = rtIsFavorites);
    } on FirebaseAuthException {
      if (mounted) setState(() => isFavorite = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.grey,
      ),
      onPressed: () async {
        try {
          if (isFavorite) {
            await RealtimeDatabase.removeFavoriteByName(widget.item.id);
          } else {
            await RealtimeDatabase.addFavorite(widget.item);
          }
          if (!mounted) return;
          setState(() => isFavorite = !isFavorite);
          if (widget.onToggle != null) widget.onToggle!();
        } on FirebaseAuthException {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please log in to manage favorites.'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        } on FirebaseException catch (e) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message ?? 'Failed to update favorite.'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
    );
  }
}

