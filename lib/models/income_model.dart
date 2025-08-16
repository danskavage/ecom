class Income {
  final int? id;
  final double incomeAmount;

  Income({this.id, required this.incomeAmount});

  Map<String, dynamic> toMap() {
    return {'Income': incomeAmount};
  }

  factory Income.fromMap(Map<String, dynamic> data) {
    return Income(id: data['id'], incomeAmount: data['Income']);
  }
}
