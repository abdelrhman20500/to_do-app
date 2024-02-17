import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/ui/provider/list_provider.dart';
import 'package:to_do_app/ui/screen/home/auth/login/login.dart';
import 'package:to_do_app/ui/screen/home/auth/register/register.dart';
import 'package:to_do_app/ui/screen/home/home_screen.dart';
import 'package:to_do_app/ui/screen/splash/splash_screen.dart';
import 'package:to_do_app/ui/utils/app_theme.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings =
      const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  // await FirebaseFirestore.instance.disableNetwork();
  /// create object from provider.
  runApp(ChangeNotifierProvider(
      create: (_){
        return ListProvider();
      },
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        SplashScreen.routeName :(_)=>SplashScreen(),
        HomeScreen.routeName:(_)=>HomeScreen(),
        LoginScreen.routeName :(_)=>LoginScreen(),
        RegisterScreen.routeName :(_)=>RegisterScreen(),
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}


