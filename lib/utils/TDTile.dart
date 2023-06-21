import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/utils/Colors.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  Function(BuildContext)? editFunction;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    //required this.editFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            // SlidableAction(onPressed: editFunction,
            // icon: Icons.drive_file_rename_outline_outlined,
            //   backgroundColor: MyColors.edtSldColor,
            //   borderRadius: BorderRadius.circular(12),
            // ),
            SlidableAction(onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: MyColors.sldbgColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: MyColors.tileColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: MyColors.ticColor,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .6,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.ltr,
                  maxLines: 5,
                  softWrap: true,
                  taskName,
                  style: TextStyle(
                      decoration: taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
