import 'package:drift_flutter/drift_flutter.dart';

import 'database.dart';

export 'database.dart';
export 'package:drift/drift.dart' show Value;

AppDatabase openAppDatabase() {
  return AppDatabase(
    driftDatabase(
      name: 'tailoring_shop',
    ),
  );
}