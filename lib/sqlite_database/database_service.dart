import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._constructor();
  static Database? _db;
  DatabaseService._constructor();
  final String expenseId = 'id';
  final String expenseTableName = 'ExpenseTable';
  final String expenseColumnName = 'ExpenseName';
  final String expenseColumnAmount = 'ExpenseAmount';
  final String expenseColumnCategory = 'ExpenseCategory';
  final String categoryId = 'id';
  final String categoryTableName = 'CategoryTable';
  final String categoryColumnName = 'CategoryName';
  final String incomeTableName = 'IncomeTable';
  final String incomeColumnId = 'id';
  final String incomeColumnAmount = 'Income';

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirectory = await getDatabasesPath();
    final databasePath = join(databaseDirectory, 'MasterApp.db');
    print(databasePath);
    final database = await openDatabase(
      version: 1,
      databasePath,
      onCreate: (db, version) {
        db.execute('''
            CREATE TABLE $expenseTableName(
            $expenseId INTEGER PRIMARY KEY AUTOINCREMENT,
            $expenseColumnName TEXT NOT NULL,
            $expenseColumnAmount REAL NOT NULL,
            $expenseColumnCategory TEXT NOT NULL
        )
        ''');
        db.execute('''
            CREATE TABLE $categoryTableName(
            $categoryId INTEGER PRIMARY KEY AUTOINCREMENT,
            $categoryColumnName TEXT NOT NULL)''');

        db.execute('''
          CREATE TABLE $incomeTableName(
          $incomeColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $incomeColumnAmount REAL NOT NULL )
  ''');
      },
    );
    return database;
  }

  ///Below method fetches data from the expense table.
  Future<List<Map<String, dynamic>>> fetchExpenses() async {
    final db = await database;
    return await db.query(expenseTableName);
  }

  //Below methos is responsible for entering data into the expense table

  Future<int> insertExpense(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(expenseTableName, data);
  }

  //below method will get the sum of expenses from the expenseAmount column in the expense table
  Future<double> getTotalExpenses() async {
    final db = await database;
    final result = await db.rawQuery(
      "SELECT SUM($expenseColumnAmount) as total FROM $expenseTableName",
    );
    print(result);
    return result.first["total"] == null
        ? 0.0
        : result.first["total"] as double;
  }

  //Below method will be responsible for deleting records from the expense table by id
  Future<int> deleteExpense(int id) async {
    final db = await database;
    return await db.delete(expenseTableName, where: 'id=?', whereArgs: [id]);
  }

  // below method is for fetching categories from the category table
  Future<List<Map<String, dynamic>>> fetchCategories() async {
    final db = await database;
    return await db.query(categoryTableName);
  }

  //this method will be for inserting category into the category table
  Future<int> insertCategory(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(categoryTableName, data);
  }

  //Below method will be deleting category from the category table based on the id from
  Future<int> deleteCategory(int id) async {
    final db = await database;
    return await db.delete(categoryTableName, where: 'id=?', whereArgs: [id]);
  }

  Future<int> deleteCategoryRelatedExpenses(String category) async {
    final db = await database;
    return await db.delete(
      expenseTableName,
      where: 'ExpenseCategory=?',
      whereArgs: [category],
    );
  }

  //BELOW method for fetch income from the database income table
  Future<List<Map<String, dynamic>>> fetchIncomes() async {
    final db = await database;
    return await db.query(incomeTableName);
  }

  //below method is for inserting into the database Income Tables
  Future<int> insertIncome(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(incomeTableName, data);
  }

  //below method is for getting total income from the incoms table
  Future<double> getTotalIncome() async {
    final db = await database;
    final result = await db.rawQuery(
      "SELECT SUM($incomeColumnAmount) as total FROM $incomeTableName",
    );

    return result.first["total"] == null
        ? 0.0
        : result.first["total"] as double;
  }

  //below method if responsible for deleting records from the expense table
  Future<void> deleteExpenseRecords() async {
    final db = await database;
    //below line deletes all the records/rows from the specified table
    await db.delete(expenseTableName);

    //below line will delete all the ids used in the table reseting them to start at one
    await db.execute(
      "DELETE FROM sqlite_sequence WHERE name ='$expenseTableName'",
    );
    await db.execute("VACUUM");
  }

  //below method if responsible for deleting records from the income table
  Future<void> deleteIncomeRecords() async {
    final db = await database;
    //below line deletes all the rows in the specified table
    await db.delete(incomeTableName);
    //below line deletes all the id from the specified table.
    await db.execute(
      "DELETE FROM sqlite_sequence WHERE name ='$incomeTableName'",
    );
    await db.execute("VACUUM");
  }

  Future<void> deleteCategoryRecords() async {
    final db = await database;
    //below line deletes all the rows in the specified table
    await db.delete(categoryTableName);
    //below line deletes all the id from the specified table.
    await db.execute(
      "DELETE FROM sqlite_sequence WHERE name ='$categoryTableName'",
    );
    await db.execute("VACUUM");
  }

  Future<double> getRemainingAmount() async {
    final db = await database;

    final totalIncomeResults = await db.rawQuery(
      "SELECT SUM($incomeColumnAmount) as total FROM $incomeTableName",
    );
    final totalExpenseResults = await db.rawQuery(
      "SELECT SUM($expenseColumnAmount) as total FROM $expenseTableName",
    );

    final totalIncome = totalIncomeResults.first["total"] as double? ?? 0.0;
    final totalExpense = totalExpenseResults.first["total"] as double? ?? 0.0;
    //var remAmount=0.0.obs;

    return totalIncome - totalExpense;
  }

  //below method is for calculating each category's totals
  Future<Map<String, double>> getCategoryTotals() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.rawQuery(
      "SELECT $expenseColumnCategory, SUM($expenseColumnAmount) as total FROM $expenseTableName GROUP BY $expenseColumnCategory",
    );

    Map<String, double> totals = {};
    for (var row in results) {
      String category = row[expenseColumnCategory];
      double total =
          row['total'] is int ? (row['total'] as int).toDouble() : row['total'];
      totals[category] = total;
    }
    return totals;
  }
}
