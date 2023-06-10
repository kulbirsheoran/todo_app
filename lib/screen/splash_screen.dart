import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/screen/home_page.dart';
import 'package:todo_app/sharedPreference//local_data_saver.dart';
import 'login_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // const HomePage();
    navigateToNextPage();
  }

  void navigateToNextPage() {
    Timer(const Duration(microseconds: 200), () async {
      String? name = await LocalDataSaver.getSaveName();
      String? password = await LocalDataSaver.getSavePassword();
      if (name != null && password != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        //  LoginScreen();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.greenAccent,
            child: const Center(child: Text('Loading...',style: TextStyle(
              fontWeight: FontWeight.w400,color: Colors.white
            ),),)));
  }
}
