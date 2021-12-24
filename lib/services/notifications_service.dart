import 'package:flutter/material.dart';


class NotificationsServices   {
  
  static GlobalKey<ScaffoldMessengerState> messengerKey  =  GlobalKey<ScaffoldMessengerState>();
  static showSnackbar (String message){

    final snackBar = SnackBar(
      content: Text(message,style: TextStyle(color: Colors.red,fontSize: 20)),
      duration: Duration(seconds: 3),
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }
}