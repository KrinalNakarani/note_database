import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Gcantroller extends GetxController {
  void AddData({String? id, String? task}) {
    var firebaseDatabase = FirebaseDatabase.instance;
    var FDBref = firebaseDatabase.ref();

    if (key == null) {
      FDBref.child("Task").push().set({"id": id, "task": task});
    } else {
      FDBref.child("Task").child(key).set({"id": id, "task": task});
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
}

class ModalNote {
  String? id,task,key;

  ModalNote({this.id, this.task,this.key});
}
