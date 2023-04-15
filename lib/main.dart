import 'package:flutter/material.dart';
import './Screens/home_screen.dart';

void main(){
  //the runApp Method
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // removing debug banner
      debugShowCheckedModeBanner: false,
      // setting a homepage
      home: Homescreen(),
    );
  }
}
