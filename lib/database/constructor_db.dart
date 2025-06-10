import 'package:drift/drift.dart';

import 'db_web.dart' if (dart.library.io) 'db_native.dart';

LazyDatabase constructDb() => createDatabase();
