import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];

  // Reference the box
  final _myBox = Hive.box('MyBox');

  // Run this method if this is the first time ever opening this app
  void createInitialData() {
    toDoList = [
      ["Do the Coding", false],
      ["Do Exercise", false],
    ];
  }

  // Load the data from the database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  // Update the database
  void updateDatabase() {
    _myBox.put("TODOLIST", toDoList);
  }
}