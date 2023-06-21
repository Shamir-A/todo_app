import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/Storage/Hive/Database.dart';
import 'package:todo_app/utils/Colors.dart';
import 'package:todo_app/utils/DialogBox.dart';
import 'package:todo_app/utils/TDTile.dart';

void main() async {
  // Init the Hive
  await Hive.initFlutter();

  // Open a box
  var box = await Hive.openBox("MyBox");
  runApp(MaterialApp(
        useInheritedMediaQuery: true,
        home: ToDoHome(),
        debugShowCheckedModeBanner: false,
      ));
}

class ToDoHome extends StatefulWidget {
  //const ToDoHome({Key? key}) : super(key: key);

  @override
  State<ToDoHome> createState() => _ToDoHomeState();
}

class _ToDoHomeState extends State<ToDoHome> {
  @override

  /// Reference the Hive box
  final _myBox = Hive.box('MyBox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // if this is the first time ever opening the app, then create default data
    if(_myBox.get("TODOLIST") == null ) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }
    super.initState();
  }

  /// Text controller
  final txtController = TextEditingController();
  final editTxtController = TextEditingController();

  /// List of ToDo Tasks
  // List toDoList = [
  //   ["Do the Coding", false],
  //   ["Do Exercise", false],
  // ];

  // checkBox was Tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }
  // functioning the save button
  void saveNewTask() {
    setState(() {
      db.toDoList.add([txtController.text, false]);
      txtController.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // functioning the edit in save button
  // void saveEditedTask() {
  //   db.updateDatabase();
  //   setState(() {
  //     db.toDoList.add([editTxtController.text, false]);
  //     txtController.clear();
  //   });
  //   Navigator.of(context).pop();
  //   db.updateDatabase();
  //
  // }

  // To delete a task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }
  
  // To edit a existing task
  // void editTask(int index) {
  //  showDialog(
  //      context: context,
  //      builder: (context) {
  //        return DialogBox(
  //            tsController: editTxtController,
  //            onSaved: saveEditedTask,
  //            onCancel: () => Navigator.of(context).pop(),
  //        );
  //      });
  // }

  // Create a new Task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            tsController: txtController,
            onSaved: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgcolor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: MyColors.abColor,
        title: const Text("TO DO", style: TextStyle(color: MyColors.ticColor, fontWeight: FontWeight.bold)),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.ftactColor,
        onPressed: createNewTask,
        child: const Icon(Icons.add, color: MyColors.ticColor),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
            //editFunction: (context) => editTask(index),
          );
        },
      ),
    );
  }
}
