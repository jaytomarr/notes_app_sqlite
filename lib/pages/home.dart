import 'package:flutter/material.dart';
import 'package:notes_app_sqlite/data/local/db.dart';
import 'package:notes_app_sqlite/pages/add_note_page.dart';
import 'package:notes_app_sqlite/providers/db_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // List<Map<String, dynamic>> allNotes = [];
  // DB? dbRef;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<DBProvider>().getInitialNotes();
    // dbRef = DB.getInstance;
    // getNotes();
  }

  // getNotes() async {
  //   allNotes = await dbRef!.getAllNotes();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Notes'), centerTitle: true),
      body: Consumer<DBProvider>(
        builder: (_, provider, __) {
          List<Map<String, dynamic>> allNotes = provider.getNotes();
          return Container(
            child: allNotes.isNotEmpty
                ? ListView.builder(
                    itemCount: allNotes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Text('${index + 1}'),
                        title: Text(allNotes[index][DB.COLUMN_NOTE_TITLE]),
                        subtitle: Text(allNotes[index][DB.COLUMN_NOTE_DESC]),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddNotePage(
                                      isUpdate: true,
                                      sno: allNotes[index][DB.COLUMN_NOTE_SNO],
                                      title:
                                          allNotes[index][DB.COLUMN_NOTE_TITLE],
                                      desc:
                                          allNotes[index][DB.COLUMN_NOTE_DESC],
                                    ),
                                  ),
                                );
                                // ///add notes func
                                // showModalBottomSheet(
                                //   context: context,
                                //   builder: (context) {
                                //     titleController.text =
                                //         allNotes[index][DB.COLUMN_NOTE_TITLE];
                                //     descController.text =
                                //         allNotes[index][DB.COLUMN_NOTE_DESC];
                                //     return bottomSheet(
                                //       isUpdate: true,
                                //       sno: allNotes[index][DB.COLUMN_NOTE_SNO],
                                //     );
                                //   },
                                // );
                              },
                              child: Icon(Icons.edit),
                            ),
                            SizedBox(width: 10),
                            InkWell(
                              onTap: () async {
                                context.read<DBProvider>().deleteNote(
                                  allNotes[index][DB.COLUMN_NOTE_SNO],
                                );
                                // bool check = await dbRef!.deleteNote(
                                //   sno: allNotes[index][DB.COLUMN_NOTE_SNO],
                                // );
                                // if (check) {
                                //   getNotes();
                                // }
                              },
                              child: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Center(child: Text('No Notes Yet!!')),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNotePage()),
          );
          // ///add notes func
          // showModalBottomSheet(
          //   context: context,
          //   builder: (context) {
          //     return bottomSheet();
          //   },
          // );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  //

  //   Widget bottomSheet({bool isUpdate = false, int sno = 0}) {
  //     return Container(
  //       width: double.infinity,
  //       padding: EdgeInsets.all(16),
  //       child: Column(
  //         children: [
  //           Text(
  //             isUpdate ? 'Edit Note' : 'Add Note',
  //             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //           ),
  //           SizedBox(height: 32),
  //           TextField(
  //             controller: titleController,
  //             decoration: InputDecoration(
  //               hintText: 'Enter note title',
  //               label: Text('Title'),
  //               focusedBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //               enabledBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: 14),
  //           TextField(
  //             controller: descController,
  //             maxLines: 4,
  //             decoration: InputDecoration(
  //               hintText: 'Enter note description',
  //               alignLabelWithHint: true,
  //               label: Text('Description'),
  //               focusedBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //               enabledBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: 20),
  //           Row(
  //             children: [
  //               Expanded(
  //                 child: ElevatedButton(
  //                   style: ButtonStyle(
  //                     shape: WidgetStateProperty.all(
  //                       RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                     ),
  //                   ),
  //                   onPressed: () async {
  //                     var title = titleController.text;
  //                     var desc = descController.text;
  //                     if (title.isNotEmpty && desc.isNotEmpty) {
  //                       bool check = isUpdate
  //                           ? await dbRef!.updateNote(
  //                               title: title,
  //                               desc: desc,
  //                               sno: sno,
  //                             )
  //                           : await dbRef!.addNote(
  //                               noteTitle: title,
  //                               noteDesc: desc,
  //                             );
  //                       if (check) {
  //                         getNotes();
  //                       }
  //                     } else {
  //                       ScaffoldMessenger.of(context).showSnackBar(
  //                         SnackBar(
  //                           content: Text(
  //                             'Please fill all the required blanks!!',
  //                           ),
  //                         ),
  //                       );
  //                     }
  //                     titleController.clear();
  //                     descController.clear();
  //                     Navigator.pop(context);
  //                   },
  //                   child: Text(isUpdate ? 'Update Note' : 'Add Note'),
  //                 ),
  //               ),
  //               SizedBox(width: 10),
  //               Expanded(
  //                 child: ElevatedButton(
  //                   style: ButtonStyle(
  //                     shape: WidgetStateProperty.all(
  //                       RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                     ),
  //                   ),
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                   },
  //                   child: Text('Cancel'),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     );
  //   }
}
