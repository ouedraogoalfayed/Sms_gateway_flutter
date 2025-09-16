import 'package:flutter/material.dart';
import 'package:sms_gateway/pages/history.dart';
import 'pages/homepage.dart';
import 'pages/new_endpoint.dart';


void main(){
  runApp(myApp());
}

class myApp extends StatelessWidget{
  const myApp({super.key});

  @override

  Widget build(BuildContext context){
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => EndpointsScreen(),
        '/new_endpoint': (context) => EndpointFormScreen(),
        '/history': (context) => HistoryScreen()
      }
       
    );
  }
}


