import 'package:hive_ce/hive.dart';
import 'package:taskati/core/models/task_model.dart';

class HiveHelper {
  static late Box userBox;
  static late Box<TaskModel> tasksBox;

  static const String userboxName = "user";
  static const String tasksBoxname = "tasks";

  static const String nameKey = "name";
  static const String imageKey = "image";

  static Future<void> init() async {
    userBox = await Hive.openBox(userboxName);
    tasksBox = await Hive.openBox<TaskModel>(tasksBoxname);
  }

  /// USER BOX METHODS

  static Future<void> setUserInfo(String name, String image) async {
    await userBox.put(nameKey, name);
    await userBox.put(imageKey, image);
  }

  static String getName() {
    return userBox.get(nameKey) ?? "";
  }

  static String getImage() {
    return userBox.get(imageKey) ?? "";
  }

  /// TASKS BOX METHODS

  static void cacheTask(String key, TaskModel task) {
    tasksBox.put(key, task);
  }

  static TaskModel? getTask(String key) {
    return tasksBox.get(key);
  }

  static List<TaskModel> getAllTasks() {
    return tasksBox.values.toList();
  }
}
