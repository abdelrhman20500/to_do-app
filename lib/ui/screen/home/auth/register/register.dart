import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/model/app_user.dart';
import 'package:to_do_app/ui/screen/home/home_screen.dart';
import 'package:to_do_app/ui/utils/dialog_utils.dart';

class RegisterScreen extends StatefulWidget {
 static String routeName = "RegisterScreen";

   const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email ="";
  String password = "";
  String userName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      elevation: 0,
      title: const Text("Register"),
      toolbarHeight: MediaQuery.of(context).size.height * .1,
     ),
     body:  Padding(
       padding: const EdgeInsets.all(14.0),
       child: SingleChildScrollView(
         child: Column(
          children: [
           SizedBox(height: MediaQuery.of(context).size.height * .22,),
           TextFormField(
            onChanged: (text) {
             userName = text;
            },
            decoration: const InputDecoration(
             label: Text("user name"),
            ),
           ),
           TextFormField(
            onChanged: (text){
             email = text;
            },
            decoration: const InputDecoration(
             label: Text("Email"),
            ),
           ),
           const SizedBox(height: 8),
           TextFormField(
            onChanged: (text) {
             password = text;
            },
            decoration: const InputDecoration(
             label: Text("Password"),
            ),
           ),
           SizedBox(height: MediaQuery.of(context).size.height * .1),
           Container(
            color: Colors.blue,
             child: MaterialButton(
                 onPressed: () {
                  register();
                 },
                 child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  child: Row(
                   children: [
                    Text("Create account",style: TextStyle(fontSize: 18)),
                    Spacer(),
                    Icon(Icons.arrow_forward)
                   ],
                  ),
                 )
             ),
           ),
          ],
         ),
       ),
     ),
    );
  }

  void register() async {
   try{
    // todo loading
    showLoading(context);
   UserCredential userCredential =
   await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email,password: password);
   AppUser newUser = AppUser(
       id: userCredential.user!.uid,
       email: email,
       userName: userName
   );
   await registerUserInFireStore(newUser);
   AppUser.currentUser = newUser;
    // todo : hide loading
     hideLoading(context);
     Navigator.pushReplacementNamed(context, HomeScreen.routeName);
   } on FirebaseAuthException catch(error){
    // todo : show error dialog
     showErrorDialog(context, error.message?? "something went error please try again later!");
   }
  }

  Future<void> registerUserInFireStore(AppUser user)async {
    CollectionReference<AppUser> userCollection= AppUser.collection();
    /// لحد قبل السطر اللي هيتكتب هيعمل id جديد وانا مش عايز كدا الحل $
    await userCollection.doc(user.id).set(user);
    // FirebaseFirestore.instance.collection(AppUser.collectionName).
    // withConverter<AppUser>(
    //     fromFirestore: (snapshot, _){
    //       return AppUser.fromJson(snapshot.data()!);
    //     },
    //     toFirestore: (user ,_){
    //       return user.toJson();
    //     });
    // userCollection.add(user);
  }
}
