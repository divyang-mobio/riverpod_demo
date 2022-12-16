import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'local_database.g.dart';

class DemoTable extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();

  TextColumn get name => text()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    File path = File(join(documentsDirectory.path, "demo.sqlite"));

    return NativeDatabase(path);
  });
}

@DriftDatabase(tables: [DemoTable])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Stream<List<DemoTableData>> getData() => select(demoTable).watch();

  Future insertData(DemoTableData data) => into(demoTable).insert(data);

  Future updateData(DemoTableData data) => update(demoTable).replace(data);

  Future deleteData(DemoTableData data) => delete(demoTable).delete(data);
}
