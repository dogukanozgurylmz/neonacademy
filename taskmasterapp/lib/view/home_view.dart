import 'package:flutter/material.dart';
import 'package:taskmasterapp/datasource/local/task_local_datasource.dart';
import 'package:taskmasterapp/model/task_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TaskLocalDatasource _localDatasource = TaskLocalDatasource();
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _searchTaskController = TextEditingController();
  final List<TaskModel> tasks = [];
  final List<TaskModel> searchTasks = [];
  bool isLoading = false;
  double longPressHeight = 50;
  int currentLongPressIndex = 50;

  Future<void> getAllTasks() async {
    tasks.clear();
    changeLoading();
    var list = await _localDatasource.getAll();
    setState(() {
      tasks.addAll(list);
    });
    changeLoading();
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> getAllTasksByStatusTrue() async {
    tasks.clear();
    var list = await _localDatasource.getAllByStatus(true);
    setState(() {
      tasks.addAll(list);
    });
  }

  Future<void> getAllTasksByStatusFalse() async {
    tasks.clear();
    var list = await _localDatasource.getAllByStatus(false);
    setState(() {
      tasks.addAll(list);
    });
  }

  Future<void> createTask() async {
    TaskModel model =
        TaskModel(task: _taskController.text.trim(), status: false);
    await _localDatasource.create(model);
  }

  Future<void> deleteTask(int index) async {
    await _localDatasource.delete(index);
  }

  Future<void> deleteAllTasks() async {
    await _localDatasource.deleteAll();
  }

  Future<void> updateTask(int index) async {
    TaskModel model =
        TaskModel(task: tasks[index].task, status: !tasks[index].status!);
    await _localDatasource.update(model, index);
  }

  void search() {
    searchTasks.clear();
    for (var task in tasks) {
      if (task.task!.contains(_searchTaskController.text)) {
        setState(() {
          searchTasks.add(task);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TaskMaster"),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _searchTaskController,
              onChanged: (value) {
                search();
              },
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () async {
                    await deleteAllTasks();
                    await getAllTasks();
                  },
                  child: const Text("Delete All"),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () async {
                    await getAllTasks();
                  },
                  child: const Text("All"),
                ),
                TextButton(
                  onPressed: () async {
                    await getAllTasksByStatusTrue();
                  },
                  child: const Text("Complete"),
                ),
                TextButton(
                  onPressed: () async {
                    await getAllTasksByStatusFalse();
                  },
                  child: const Text("Uncomplete"),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount:
                    searchTasks.isEmpty ? tasks.length : searchTasks.length,
                itemBuilder: (context, index) {
                  var task =
                      searchTasks.isEmpty ? tasks[index] : searchTasks[index];
                  return Dismissible(
                    key: Key(task.task!),
                    onDismissed: (direction) async {
                      await deleteTask(index);
                      setState(() {
                        tasks.removeAt(index);
                      });
                    },
                    child: GestureDetector(
                      onLongPressEnd: (details) {
                        setState(() {
                          longPressHeight = 50;
                          currentLongPressIndex = -1;
                        });
                      },
                      onLongPressStart: (details) {
                        setState(() {
                          currentLongPressIndex = index;
                          longPressHeight = 60;
                        });
                      },
                      onLongPress: () async {
                        await updateTask(index);
                        await getAllTasks();
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 100),
                        curve: Curves.bounceInOut,
                        height: index == currentLongPressIndex
                            ? longPressHeight
                            : 50,
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.amber.shade100,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.change_circle),
                            const SizedBox(width: 8),
                            Text(task.task!),
                            const Spacer(),
                            !task.status!
                                ? const SizedBox.shrink()
                                : Container(
                                    height: 8,
                                    width: 8,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.green,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _taskController,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await createTask();
                    setState(() {
                      getAllTasks();
                      _taskController.clear();
                    });
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
