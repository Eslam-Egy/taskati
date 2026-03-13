import 'package:hive_ce/hive_ce.dart';
import 'package:taskati/core/models/task_model.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<TaskModel>(),
])
class HiveAdapters {}