import 'package:flutter/material.dart';
import 'pages/homepage.dart';
import 'pages/new_endpoint.dart';


void main(){
  runApp(myApp());
}

class myApp extends StatelessWidget{
  @override

  Widget build(BuildContext context){
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => EndpointsScreen(),
        '/new_endpoint': (context) => EndpointFormScreen(),
      }
       
    );
  }
}


