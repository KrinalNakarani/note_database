import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Gcantroller extends GetxController {

  void AddData({ String? task, String? key,bool? isclick}) {
    var firebaseDatabase = FirebaseDatabase.instance;
    var FDBref = firebaseDatabase.ref();

    if (key == null) {
      FDBref.child("Task").push().set({ "task": task,"isclick":isclick});
    } else {
      FDBref.child("Task").child(key).set({ "task": task,"isclick":isclick});
    }
  }

  void status({bool? isclick, String? key,String? task}){
    var firebaseDatabase = FirebaseDatabase.instance;
    var FDBref = firebaseDatabase.ref();

        FDBref.child("Task").child(key!).set({"task": task,"isclick":isclick});


  }

  Stream<DatabaseEvent> readData() {
    var firebaseDatabase = FirebaseDatabase.instance;
    var FDBref = firebaseDatabase.ref();
    return FDBref.child("Task").onValue;
  }

  void Delete(String key) {
    var firebaseDatabase = FirebaseDatabase.instance;
    var FDBref = firebaseDatabase.ref();
    FDBref.child("Task").child(key).remove();
  }
}

class ModalNote {
  String? task,key;
  bool? isclick;

  ModalNote({this.task,this.isclick,this.key});
}
