import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/constant/routes_const.dart';
import 'package:todo_app/screen/home_page.dart';
import 'package:todo_app/screen/login_screen.dart';
import 'package:todo_app/screen/signup_screen.dart';
import 'package:todo_app/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(home: const SplashPage(),
      routes: {
        Routes.signUp:(context)=>const SignUp(),
        Routes.homePage:(context)=>const HomePage(),
        Routes.loginScreen:(context)=>const LoginScreen(),

       // Routes.idCreate:(context)=>const LoginScreen(),
      },
     // home: const SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// In your SplashPage or any other widget
//Navigator.pushNamed(context, '/splash');
