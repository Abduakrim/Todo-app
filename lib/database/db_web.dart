import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

LazyDatabase createDatabase() {
  return LazyDatabase(() async {
    final db = await WasmDatabase.open(
      databaseName: 'app.db',
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.js'),
    );
    return db.resolvedExecutor;
  });
}
