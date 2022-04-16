import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Calc {
  final String expression;
  final String result;

  const Calc({required this.expression, required this.result});

  Map<String, Object?> toMap() {
    return {'expression': expression, 'result': result};
  }

  Calc.fromMap(Map<String, dynamic> res)
      : expression = res["expression"],
        result = res["result"];
}

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'calc.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE calc(id INTEGER PRIMARY KEY AUTOINCREMENT, expression TEXT NOT NULL,result TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertCalc(List<Calc> users) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var user in users) {
      result = await db.insert('calc', user.toMap());
    }
    return result;
  }

  Future<List<Calc>> retrieveCalc() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('calc');
    return queryResult.map((e) => Calc.fromMap(e)).toList();
  }
}
