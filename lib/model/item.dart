class Item {
  final int? id;
  final String title;
  final String imagePath;
  final String description;

  const Item({
    this.id,
    required this.title,
    required this.imagePath,
    this.description = "No description available",
  });

  // Item -> Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imagePath': imagePath,
      'description': description,
    };
  }

  // Map -> Item
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      title: map['title'],
      imagePath: map['imagePath'],
      description: map['description'],
    );
  }
}