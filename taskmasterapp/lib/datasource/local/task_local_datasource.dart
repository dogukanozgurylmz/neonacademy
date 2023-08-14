import 'package:hive_flutter/hive_flutter.dart';

import '../../model/task_model.dart';

class TaskLocalDatasource {
  Future<List<TaskModel>> getAll() async {
    var box = await Hive.openBox<TaskModel>('tasks');
    return box.values.toList();
  }

  Future<List<TaskModel>> getAllByStatus(bool status) async {
    var box = await Hive.openBox<TaskModel>('tasks');
    return box.values.where((task) => task.status == status).toList();
  }

  Future<void> create(TaskModel model) async {
    var box = await Hive.openBox<TaskModel>('tasks');
    await box.add(model);
  }

  Future<void> update(TaskModel model, int index) async {
    var box = await Hive.openBox<TaskModel>('tasks');
    await box.putAt(index, model);
  }

  Future<void> delete(int index) async {
    var box = await Hive.openBox<TaskModel>('tasks');
    await box.deleteAt(index);
  }

  Future<void> deleteAll() async {
    var box = await Hive.openBox<TaskModel>('tasks');
    await box.clear();
  }
}
