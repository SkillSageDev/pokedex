import 'dart:convert';

class Item {
  final int id;
  final String name; // Matches "name"
  final String img; // Matches "img"
  final String num;
  final List<String> type;
  final String height;
  final String weight;
  final String description;
  final String species; // New
  final String ability; // New
  final int colorValue; // Stores the color as an integer
  final Map<String, dynamic> stats;

  const Item({
    required this.id,
    required this.name,
    required this.img,
    required this.num,
    required this.type,
    required this.height,
    required this.weight,
    required this.description,
    required this.species,
    required this.ability,
    required this.colorValue,
    required this.stats,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'img': img,
      'num': num,
      'type': jsonEncode(type),
      'height': height,
      'weight': weight,
      'description': description,
      'species': species,
      'ability': ability,
      'colorValue': colorValue,
      'stats': jsonEncode(stats),
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    final dynamic idRaw = map['id'];
    final int parsedId = idRaw is int
        ? idRaw
        : idRaw is double
            ? idRaw.toInt()
            : int.tryParse(idRaw?.toString() ?? '') ?? 0;

    final dynamic typeRaw = map['type'];
    final List<String> parsedType = typeRaw is String
        ? List<String>.from(jsonDecode(typeRaw))
        : (typeRaw is List
            ? typeRaw.map((e) => e.toString()).toList()
            : const <String>[]);

    final dynamic statsRaw = map['stats'];
    final Map<String, dynamic> parsedStats = statsRaw is String
        ? Map<String, dynamic>.from(jsonDecode(statsRaw))
        : Map<String, dynamic>.from(statsRaw ?? const <String, dynamic>{});

    return Item(
      id: parsedId,
      name: map['name']?.toString() ?? '',
      img: map['img']?.toString() ?? '',
      num: map['num']?.toString() ?? '',
      type: parsedType,
      height: map['height']?.toString() ?? '',
      weight: map['weight']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      species: map['species']?.toString() ?? "Seed Pokemon",
      ability: map['ability']?.toString() ?? "Overgrow",
      colorValue: (map['colorValue'] is int)
          ? map['colorValue'] as int
          : (map['colorValue'] is double)
              ? (map['colorValue'] as double).toInt()
          : 0xFF008080, // Default teal
      stats: parsedStats,
    );
  }
}

