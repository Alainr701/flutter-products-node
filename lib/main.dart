import 'package:flutter/material.dart';
import 'package:products_app/screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (context) =>  const LoginScreen(),
        'home': (context) =>  const HomeScreen()
      },
    );
  }
}
