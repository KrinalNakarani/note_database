import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Gcantroller extends GetxController {
  void AddData({ String? task, String? key}) {
    var firebaseDatabase = FirebaseDatabase.instance;
    var FDBref = firebaseDatabase.ref();

    if (key == null) {
      FDBref.child("Task").push().set({ "task": task});
    } else {
      FDBref.child("Task").child(key).set({ "task": task});
    }
  }

  Stream<DatabaseEvent> readData() {
    var firebaseDatabase = FirebaseDatabase.instance;
    var FDBref = firebaseDatabase.ref();
    return FDBref.child("Task").onValue;
  }

  void Delete(String? key) {
    var firebaseDatabase = FirebaseDatabase.instance;
    var FDBref = firebaseDatabase.ref();
    FDBref.child("Task").child(key!).remove();
  }

  Future<Icon> tick() async {
    bool isclick = false;
    var abc = isclick ? Icon(Icons.check_circle) : Icon(Icons.check_circle_outline);
    return abc;
  }
}

class ModalNote {
  String? task,key;

  ModalNote({ this.task,this.key});
}
