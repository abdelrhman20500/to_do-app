import 'package:flutter/material.dart';
import 'package:to_do_app/ui/screen/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
 static String routeName = "SplashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2),(){
      Navigator.pushNamed(context, HomeScreen.routeName);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset("assets/images/splash.png",
        fit: BoxFit.fill,),
      ),
    );
  }
}
