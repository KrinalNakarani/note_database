import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/homecontroller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Gcantroller GLR = Get.put(Gcantroller());

  TextEditingController task = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Note Keeper"),
          backgroundColor: Colors.green,
        ),
        body: StreamBuilder(
          stream: GLR.readData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              print("====================${snapshot.data.snapshot}");

              List<ModalNote> l1 = [];
              DataSnapshot data = snapshot.data.snapshot;

              for (var x in data.children) {
                ModalNote N1 = ModalNote(
                  task: x.child("task").value.toString(),
                  key: x.key,
                  isclick: x.child("isclick").value.toString() == "true"
                      ? true
                      : false,
                );
                l1.add(N1);
              }
              return ListView.builder(
                  itemCount: l1.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Checkbox(
                        value: l1[index].isclick,
                        onChanged: (value) {
                          GLR.status(
                              isclick: value,
                              key: l1[index].key,
                              task: l1[index].task);
                        },
                      ),
                      title: Text("${l1[index].task}"),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                task =
                                    TextEditingController(text: l1[index].task);

                                DialogBox(l1[index].key.toString());
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.green,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                GLR.Delete(l1[index].key!);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            task = TextEditingController();
            DialogBox(null);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void DialogBox(String? key) {
    Get.defaultDialog(
      content: Container(
        child: Column(
          children: [
            TextField(
              controller: task,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "task",
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                GLR.AddData(task: task.text, key: key, isclick: false);
              },
              child: Text("Create"),
            ),
          ],
        ),
      ),
    );
  }
}
