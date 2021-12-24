import 'package:flutter/material.dart';
import 'package:products_app/screens/home_screen.dart';
import 'package:products_app/screens/login_screen.dart';
import 'package:products_app/services/services.dart';
import 'package:provider/provider.dart'; 

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context,listen: false);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData ) return const Text('Loading...'); 

            if (snapshot.data == null) {
            Future.microtask(() { //nos permite hacer una llamada asincrona y no esperar a que se termine la llamada para continuar
              // Navigator.of(context).pushReplacementNamed('login');
              Navigator.pushReplacement(context, PageRouteBuilder(
                pageBuilder: (_, __,___) =>LoginScreen(),
                transitionDuration: const Duration(seconds: 0),
              ));
            });
            }else{
              Future.microtask(() { //nos permite hacer una llamada asincrona y no esperar a que se termine la llamada para continuar
              // Navigator.of(context).pushReplacementNamed('login');
              Navigator.pushReplacement(context, PageRouteBuilder(
                pageBuilder: (_, __,___) =>HomeScreen(),
                transitionDuration: const Duration(seconds: 0),
              ));
            });
            }
            return Container();
          },
        ),

       ),
    );
  }
}