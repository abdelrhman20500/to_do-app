import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/app_user.dart';
import '../../model/todo_dm.dart';

class ListProvider extends ChangeNotifier{
  List<TodoDM> todos = [];
  DateTime selectedDate= DateTime.now();

  reFreshTdoFireStore()async {
    todos = []; // this line to make list is empty
    CollectionReference todosCollection =
    ///علشان كل مستخدم يجيب الداتا في collection لوحده
    AppUser.collection().doc(AppUser.currentUser!.id).collection(TodoDM.collectionName);
    /// orderBy  علشان list تيجي مترتبه
    QuerySnapshot todoSnapshot= await todosCollection.orderBy("date").get();
    List<QueryDocumentSnapshot> docs= todoSnapshot.docs;
    for(int i =0; i<docs.length; i++){
      var singleDoc = docs[i];
      Map json = singleDoc.data() as Map;
      TodoDM todo = TodoDM.fromJson(json);
      todos.add(todo);
    }
    todos= todos.where((todo) {
      if(todo.date.day != selectedDate.day ||
          todo.date.month != selectedDate.month ||
          todo.date.year != selectedDate.year){
        return false;
      }else {
        return true;
      }
    }).toList();
    notifyListeners();
  }
 Future<void> clickOnIsDone(TodoDM todoDM)async {
    await AppUser.collection().doc(AppUser.currentUser!.id).collection(TodoDM.collectionName)
    .doc(todoDM.id)
    .set(todoDM.toJson());
    reFreshTdoFireStore();
  }

  clickOnDelete(String taskId)async {
    await AppUser.collection()
        .doc(AppUser.currentUser!.id)
        .collection(TodoDM.collectionName)
        .doc(taskId).delete();
    reFreshTdoFireStore();
  }
  clickOnSaveChanged(TodoDM todoDM){
    AppUser.collection()
        .doc(AppUser.currentUser!.id)
        .collection(TodoDM.collectionName)
        .doc(todoDM.id)
        .set(todoDM.toJson());
    reFreshTdoFireStore();
  }
}