class Product {
  final String? id;
  final String name;
  final String description;
  final int stock;
  final String imagePath;
  final DateTime dateAdded;
  final String addedBy;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.stock,
    required this.imagePath,
    DateTime? dateAdded,
    this.addedBy = 'User1',
  }) : dateAdded = dateAdded ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'stock': stock,
      'image_path': imagePath,
      'date_added': dateAdded.toIso8601String(),
      'added_by': addedBy,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      stock: map['stock'],
      imagePath: map['image_path'] ?? '',
      dateAdded: DateTime.parse(map['date_added']),
      addedBy: map['added_by'],
    );
  }

  Product copyWith({
    String? id,
    String? name,
    String? description,
    int? stock,
    String? imagePath,
    DateTime? dateAdded,
    String? addedBy,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      stock: stock ?? this.stock,
      imagePath: imagePath ?? this.imagePath,
      dateAdded: dateAdded ?? this.dateAdded,
      addedBy: addedBy ?? this.addedBy,
    );
  }
}
