class Category {
  final int? id;
  final String categoryName;

  Category({this.id, required this.categoryName});

  Map<String, dynamic> toMap() {
    return {'CategoryName': categoryName};
  }

  factory Category.fromMap(Map<String, dynamic> data) {
    return Category(id: data['id'], categoryName: data['CategoryName']);
  }
}
