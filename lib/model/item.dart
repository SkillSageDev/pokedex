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
    return Item(
      id: map['id'],
      name: map['name'],
      img: map['img'],
      num: map['num'],
      type: List<String>.from(jsonDecode(map['type'])),
      height: map['height'],
      weight: map['weight'],
      description: map['description'],
      species: map['species'] ?? "Seed Pokemon",
      ability: map['ability'] ?? "Overgrow",
      colorValue: map['colorValue'] ?? 0xFF008080, // Default teal
      stats: Map<String, dynamic>.from(jsonDecode(map['stats'])),
    );
  }
}

