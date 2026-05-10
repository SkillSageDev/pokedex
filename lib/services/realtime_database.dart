import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:logger/logger.dart';
import 'package:pokedex/model/item.dart';

Logger logger = Logger();

class RealtimeDatabase {
  static final FirebaseDatabase _db = FirebaseDatabase.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static String? get _uid => _auth.currentUser?.uid;
  static DatabaseReference get _favRef => _db.ref("/user/$_uid/fav");

  static Future<void> addFavorite(Item item) async {
    await _favRef.child("${item.id}").set({
      "name": item.name,
      "img": item.img,
      "num": item.num,
      "type": item.type,
      "height": item.height,
      "weight": item.weight,
      "description": item.description,
      "species": item.species,
      "ability": item.ability,
      "colorValue": item.colorValue,
      "stats": item.stats,
    });
  }

  static Future<void> removeFavoriteByName(int id) async {
    await _favRef.child("$id").remove();
  }

  static Future<bool> isFav(int id) async {
    final DataSnapshot snapshot = await _favRef.child("$id").get();
    return snapshot.exists;
  }

  static Future<List<Item>> getFavorites() async {
    final snapshot = await _favRef.get();

    if (!snapshot.exists || snapshot.value == null) return [];

    final data = Map<String, dynamic>.from(snapshot.value as Map);

    return data.entries.map((e) {
      final value = Map<String, dynamic>.from(e.value as Map);

      return Item.fromMap(value);
    }).toList();
  }
}
