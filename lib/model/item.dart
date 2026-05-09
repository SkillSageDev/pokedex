import 'dart:convert';

class Item {
  final int? id;
  final String title;        // Maps to "name"
  final String imagePath;    // Maps to "img"
  final String num;          // e.g., "001"
  final List<String> type;   // e.g., ["Grass", "Poison"]
  final String height;
  final String weight;
  final String description;
  final Map<String, int> stats; // e.g., {"HP": 45, "Attack": 49}

  const Item({
    this.id,
    required this.title,
    required this.imagePath,
    required this.num,
    required this.type,
    required this.height,
    required this.weight,
    required this.description,
    required this.stats,
  });

  // --- Convert Item to Map (for Database) ---
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imagePath': imagePath,
      'num': num,
      'type': jsonEncode(type),        // Convert List to String
      'height': height,
      'weight': weight,
      'description': description,
      'stats': jsonEncode(stats),      // Convert Map to String
    };
  }

  // --- Convert Map to Item (from Database) ---
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      title: map['title'],
      imagePath: map['imagePath'],
      num: map['num'],
      // Convert String back to List<String>
      type: List<String>.from(jsonDecode(map['type'])),
      height: map['height'],
      weight: map['weight'],
      description: map['description'],
      // Convert String back to Map<String, int>
      stats: Map<String, int>.from(jsonDecode(map['stats'])),
    );
  }
}