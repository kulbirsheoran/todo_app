import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/screen/splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return  MaterialApp(routes: {

      '/splash': (context) => const SplashPage(),
    },
    home: const SplashPage(),
      debugShowCheckedModeBanner: false,

    );

  }
}
