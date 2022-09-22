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
  TextEditingController id = TextEditingController();
  TextEditingController task = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: GLR.readData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              print("====================${snapshot.data.snapshot}");

              List l1 = [];
              DataSnapshot data = snapshot.data.snapshot;

              for (var x in data.children) {
                ModalNote N1 = ModalNote(
                    id: x.child("id").value.toString(),
                    task: x.child("task").value.toString(),
                    key: x.key);
                l1.add(N1);
              }
              return ListView.builder(
                  itemCount: l1.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("${l1[index].task}"),
                      trailing: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              id = TextEditingController(text: l1[index].id);
                              task =
                                  TextEditingController(text: l1[index].task);

                              // DialogBox(l1[index].key.toString());
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              GLR.Delete(l1[index].key);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: FloatingActionButton(

        ),
      ),
    );
  }

  void Tick() {}
}
