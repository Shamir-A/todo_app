import 'package:flutter/material.dart';
import 'package:todo_app/utils/Colors.dart';
import 'package:todo_app/utils/MyButtons.dart';

class DialogBox extends StatelessWidget {

  final tsController;
  VoidCallback onSaved;
  VoidCallback onCancel;
  DialogBox({
    super.key,
    required this.tsController,
    required this.onSaved,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: MyColors.alrtColor,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // To get user inputs
            TextFormField(
              controller: tsController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Add a new Task"),
            ),

            // Button => save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Save Button
                MyButton(text: "Save", onPressed: onSaved),
                const SizedBox(width: 5,),
                MyButton(text: "Cancel", onPressed: onCancel),
                // Cancel Button
              ],
            )
          ],
        ),
      ),
    );
  }
}
