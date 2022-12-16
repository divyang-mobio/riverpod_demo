import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/local_database.dart';

final dataProvider = StateProvider((ref) => MyDatabase());
