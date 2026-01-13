import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

import 'user_record.dart';

class LocalUserRepository {
  static const _databaseName = 'usuario.db';
  static const _tableName = 'usuario';

  Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final fullPath = path.join(databasePath, _databaseName);

    return openDatabase(
      fullPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE $_tableName('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'usuarionombre TEXT,'
          'usuarioemail TEXT'
          ')',
        );
      },
    );
  }

  Future<List<UserRecord>> getUsuario() async {
    final db = await _openDatabase();
    final rows = await db.query(_tableName, limit: 1);
    return rows.map(UserRecord.fromMap).toList();
  }

  Future<void> borrarUsuario() async {
    final db = await _openDatabase();
    await db.delete(_tableName);
  }
}
