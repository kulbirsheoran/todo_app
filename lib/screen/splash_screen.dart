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
    Timer(const Duration(seconds: 2), () async {
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
            context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.white,
            child: FlutterLogo(size: MediaQuery.of(context).size.height)));
  }
}
