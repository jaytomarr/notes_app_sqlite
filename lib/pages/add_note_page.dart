import 'package:flutter/material.dart';
// import 'package:notes_app_sqlite/data/local/db.dart';
import 'package:notes_app_sqlite/providers/db_provider.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatelessWidget {
  bool isUpdate;
  String title;
  String desc;
  int sno;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  AddNotePage({
    this.isUpdate = false,
    this.sno = 0,
    this.title = '',
    this.desc = '',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (isUpdate) {
      titleController.text = title;
      descController.text = desc;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? 'Edit Note' : 'Add Note'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Text(
            //   isUpdate ? 'Edit Note' : 'Add Note',
            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            // ),
            SizedBox(height: 10),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Enter note title',
                label: Text('Title'),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black45),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black45),
                ),
              ),
            ),
            SizedBox(height: 14),
            TextField(
              controller: descController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Enter note description',
                alignLabelWithHint: true,
                label: Text('Description'),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black45),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black45),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      var title = titleController.text;
                      var desc = descController.text;
                      if (title.isNotEmpty && desc.isNotEmpty) {
                        if (isUpdate) {
                          context.read<DBProvider>().updateNote(
                            title,
                            desc,
                            sno,
                          );
                        } else {
                          context.read<DBProvider>().addNote(title, desc);
                        }
                        Navigator.pop(context);
                        // bool check = isUpdate
                        //     ? await dbRef!.updateNote(
                        //         title: title,
                        //         desc: desc,
                        //         sno: sno,
                        //       )
                        //     : await dbRef!.addNote(
                        //         noteTitle: title,
                        //         noteDesc: desc,
                        //       );
                        // if (check) {
                        //   Navigator.pop(context);
                        // }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please fill all the required blanks!!',
                            ),
                          ),
                        );
                      }
                      titleController.clear();
                      descController.clear();
                    },
                    child: Text(isUpdate ? 'Update Note' : 'Add Note'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
