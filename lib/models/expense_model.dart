class Expense {
  final int? id;
  final String expenseName;
  final double expenseAmount;
  final String expenseCategory;

  Expense({
    this.id,
    required this.expenseName,
    required this.expenseAmount,
    required this.expenseCategory,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'ExpenseName': expenseName,
      'ExpenseAmount': expenseAmount,
      'ExpenseCategory': expenseCategory,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      expenseName: map['ExpenseName'],
      expenseAmount: map['ExpenseAmount'],
      expenseCategory: map['ExpenseCategory'],
    );
  }
}
