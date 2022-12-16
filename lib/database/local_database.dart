import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'local_database.g.dart';

class SafeTable extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();

  TextColumn get name => text()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    File path = File(join(documentsDirectory.path, "safe.sqlite"));

    return NativeDatabase(path);
  });
}

@DriftDatabase(tables: [SafeTable])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Stream<List<SafeTableData>> getData() => select(safeTable).watch();

  Future insertData(SafeTableData data) => into(safeTable).insert(data);

  Future updateData(SafeTableData data) => update(safeTable).replace(data);

  Future deleteData(SafeTableData data) => delete(safeTable).delete(data);
}
