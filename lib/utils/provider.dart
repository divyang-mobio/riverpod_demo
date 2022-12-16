import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/database/local_database.dart';

final dataProvider = StateProvider((ref) => MyDatabase());
