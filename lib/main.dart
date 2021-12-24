import 'package:flutter/material.dart';
import 'package:products_app/screens/screens.dart';
import 'package:products_app/services/notifications_service.dart';
import 'package:products_app/services/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppState());
}


class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductServices()),
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: 'checking',
      scaffoldMessengerKey: NotificationsServices.messengerKey,
      routes: {
        'login': (context) =>  const LoginScreen(),
        'register': (context) =>  const RegisterScreen(),
        'home': (context) =>  const HomeScreen(),
        'product': (context) =>  const ProductScreen(),
        'checking': (context) =>  const CheckAuthScreen(),
      },
    );
  }
}
