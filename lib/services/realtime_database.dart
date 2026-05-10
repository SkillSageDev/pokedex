import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:logger/logger.dart';
import 'package:pokedex/model/item.dart';

Logger logger = Logger();

class RealtimeDatabase {
  static final FirebaseDatabase _db = FirebaseDatabase.instanceFor(
    app: FirebaseAuth.instance.app,
    databaseURL: 'https://pokedex-8e228-default-rtdb.firebaseio.com',
  );
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static String? get _uid => _auth.currentUser?.uid;

  static const Map<String, String> _keyTokens = {
    '.': '__dot__',
    '#': '__hash__',
    r'$': '__dollar__',
    '/': '__slash__',
    '[': '__lbracket__',
    ']': '__rbracket__',
  };

  static String _sanitizeKey(String key) {
    var result = key;
    _keyTokens.forEach((char, token) {
      result = result.replaceAll(char, token);
    });
    return result;
  }

  static String _restoreKey(String key) {
    var result = key;
    _keyTokens.forEach((char, token) {
      result = result.replaceAll(token, char);
    });
    return result;
  }

  static dynamic _sanitizeValue(dynamic value) {
    if (value is Map) {
      return value.map((k, v) => MapEntry(_sanitizeKey(k.toString()), _sanitizeValue(v)));
    }
    if (value is List) {
      return value.map(_sanitizeValue).toList();
    }
    return value;
  }

  static dynamic _restoreValue(dynamic value) {
    if (value is Map) {
      return value.map((k, v) => MapEntry(_restoreKey(k.toString()), _restoreValue(v)));
    }
    if (value is List) {
      return value.map(_restoreValue).toList();
    }
    return value;
  }
  static DatabaseReference get _favRef {
    final uid = _uid;
    if (uid == null) {
      throw FirebaseAuthException(
        code: 'not-authenticated',
        message: 'User must be logged in before using favorites.',
      );
    }
    return _db.ref('/user/$uid/fav');
  }

  static Future<void> addFavorite(Item item) async {
    await _favRef.child("${item.id}").set({
      "id": item.id,
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
      "stats": _sanitizeValue(item.stats),
    });
  }

  static Future<void> removeFavoriteByName(int id) async {
    await _favRef.child("$id").remove();
  }

  static Future<bool> isFav(int id) async {
    if (_uid == null) return false;
    final DataSnapshot snapshot = await _favRef.child("$id").get();
    return snapshot.exists;
  }

  static Future<List<Item>> getFavorites() async {
    if (_uid == null) return [];
    final snapshot = await _favRef.get();
    return _parseFavorites(snapshot.value);
  }

  static Stream<List<Item>> watchFavorites() {
    return _auth.authStateChanges().asyncExpand((user) {
      if (user == null) {
        return Stream<List<Item>>.value(const <Item>[]);
      }
      return _db
          .ref('/user/${user.uid}/fav')
          .onValue
          .map((event) => _parseFavorites(event.snapshot.value));
    });
  }

  static List<Item> _parseFavorites(dynamic raw) {
    if (raw == null) return [];
    final items = <Item>[];

    void pushItem(dynamic key, dynamic payload) {
      if (payload is! Map) return;
      final value = Map<String, dynamic>.from(payload as Map);

      value['id'] ??= int.tryParse(key?.toString() ?? '');
      if (value['id'] == null) return;

      if (value['stats'] != null) {
        value['stats'] = _restoreValue(value['stats']);
      }
      value['type'] ??= <String>[];
      value['stats'] ??= <String, dynamic>{};

      items.add(Item.fromMap(value));
    }

    if (raw is Map) {
      for (final entry in raw.entries) {
        pushItem(entry.key, entry.value);
      }
      return items;
    }

    if (raw is List) {
      for (var i = 0; i < raw.length; i++) {
        pushItem(i, raw[i]);
      }
      return items;
    }

    return items;
  }
}
