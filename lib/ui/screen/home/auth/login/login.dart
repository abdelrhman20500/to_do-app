import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/model/app_user.dart';

import '../../../../utils/dialog_utils.dart';
import '../../home_screen.dart';
import '../register/register.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "LoginScreen";

   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email ="";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Login"),
        toolbarHeight: MediaQuery.of(context).size.height * .1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .25,),
              const Text("Welcome back !",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                onChanged: (text){
                  email= text;
                },
                decoration: const InputDecoration(
                  label: Text("Email"),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                onChanged: (text){
                  password=text;
                },
                decoration: const InputDecoration(
                  label: Text("password"),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                color: Colors.blue,
                child: MaterialButton
                  (onPressed: ()
                {
                    login();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  child: Row(
                    children: [
                      Text("Login", style: TextStyle(fontSize: 18),),
                      Spacer(),
                      Icon(Icons.arrow_forward)
                    ],
                  ),
                ),
                ),
              ),
              const SizedBox(height: 18,),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, RegisterScreen.routeName);
                },
                child: const Text(
                  "Create account",
                  style: TextStyle(fontSize: 18, color: Colors.black45),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    try{
      // todo loading
      showLoading(context);
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email,password: password);
     AppUser currentUser =await getUserFromFireStore(userCredential.user!.uid);
     AppUser.currentUser=currentUser;
      // todo : hide loading
      hideLoading(context);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch(error){
      // todo : show error dialog
      showErrorDialog(context, error.message?? "something went error please try again later!");
    }
  }

  Future<AppUser> getUserFromFireStore(String id)async {
    CollectionReference<AppUser> userCollection = AppUser.collection();
    DocumentSnapshot<AppUser> documentSnapshot =await userCollection.doc(id).get();
    return documentSnapshot.data()!;
  }
}