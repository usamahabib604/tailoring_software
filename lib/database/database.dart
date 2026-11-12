import 'package:drift/drift.dart';

part 'database.g.dart';

class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get tokenNumber => text().unique()();

  TextColumn get name => text()();

  TextColumn get mobile => text().nullable()();

  TextColumn get address => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();
}

@DriftDatabase(tables: [Customers])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;
}