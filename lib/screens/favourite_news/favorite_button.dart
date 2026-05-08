import 'package:flutter/material.dart';
import '../../services/database_service.dart';
import '../../model/item.dart';
class FavoriteButton extends StatefulWidget {
  final Item item;
  final bool initialIsFavorite;


  const FavoriteButton({super.key, required this.item, this.initialIsFavorite = false,});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  //bool isFavorite = false;
  late bool isFavorite;

  @override
  void initState()
  {
    super.initState();
    isFavorite = widget.initialIsFavorite;
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    final favorites = await DatabaseService.instance.getFavorites();
    final exists = favorites.any((element) => element.title == widget.item.title);

    if (mounted) {
      setState(() {
        isFavorite = exists;
      });
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
        setState(() {
          isFavorite = !isFavorite;
        });

        if (isFavorite) {

          await DatabaseService.instance.addFavorite(widget.item);
        } else {
          if (widget.item.id != null) {
            await DatabaseService.instance.removeFavorite(widget.item.id!);
          }
          else {
            if (widget.item.id != null) {
              await DatabaseService.instance.removeFavorite(widget.item.id!);
            } else { //backup
              await DatabaseService.instance.removeFavoriteByTitle(widget.item.title);
            }
          }
        }
      },
    );
  }
}