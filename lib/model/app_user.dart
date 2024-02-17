import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/model/todo_dm.dart';

class AppUser{
  static const String collectionName ="user";
  static AppUser? currentUser;
  late String id;
  late String email;
  late String userName;
  AppUser({required this.id, required this.email, required this.userName});

  AppUser.fromJson(Map json){
    id = json["id"] ?? "";
    email = json["email"]?? "";
    userName = json["username"]?? "";
  }
  Map<String, dynamic> toJson(){
  return {
    "id":id,
    "email":email,
    "userName":userName,
  };
 }
  static CollectionReference <AppUser> collection(){
    return FirebaseFirestore.instance.collection(AppUser.collectionName).
    withConverter<AppUser>(
        fromFirestore: (snapshot, _){
          return AppUser.fromJson(snapshot.data()!);
        },
        toFirestore: (user ,_){
          return user.toJson();
        });
  }
  static CollectionReference getCurrentUserTodosCollection(){
    return AppUser.collection().doc(AppUser.currentUser!.id)
        .collection(TodoDM.collectionName);
  }
}
