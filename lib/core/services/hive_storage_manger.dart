import 'package:hive_ce_flutter/adapters.dart';
import 'package:tasky/core/constants/constants.dart';
import 'package:tasky/models/task_model.dart';

class HiveStorageManger {
  static final HiveStorageManger _hive = HiveStorageManger._();

  HiveStorageManger._();

  factory HiveStorageManger() {
    return _hive;
  }

  late Box<TaskModel> _taskBox;

  init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskModelAdapter());
    _taskBox = await Hive.openBox<TaskModel>(Constants.tasksNameCollection);
  }

  Future<void> saveTasks(List<TaskModel> list) async {
    await _taskBox.clear();
    await _taskBox.addAll(list);
  }

  List<TaskModel> loadTasks() {
    return _taskBox.values.toList();
  }

  clear() {
    _taskBox.clear();
  }
}
