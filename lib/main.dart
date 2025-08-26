// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:telephony/telephony.dart';
import 'package:http/http.dart';

final Telephony telephony = Telephony.instance;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget{
  const HomeWidget ({super.key});

  @override

  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget>{
  
  void function1() async{
    
      final response =  await http.post(
          Uri.parse("http://192.168.1.66:8000/sms_received"),
          body:{
            "from":"22670114741",
            "text":"reussi ",
          },
        );
        print("Reponse du serveur: ${response.body}"); 
    
        
  }
  
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Test"),),
        body: ElevatedButton(onPressed: () => function1(), child: Text("Press here")),
      ),
    );

  }
}
    
   /*telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) async {*/

     /* },
      listenInBackground: true,
      onBackgroundMessage: backgroundMessageHandler,
    );*/


/*backgroundMessageHandler(SmsMessage message) async {
  print("Background SMS: ${message.body}");
}
/////////
///final response =  await http.post(
          Uri.parse("https://192.168.1.66:8000/sms_received"),
          body:{
            "from":"22670114741",
            "text":"reussi bruh",
          },
        );
        print("Reponse du serveur: ${response.body}"); }, 
          child: Text("Press here")))
    ));
        
///
///
///
///
///
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InboxPage(),
    );
  }
}

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  // Liste pour stocker les messages reçus
  List<SmsMessage> messages = [];

  @override
  void initState() {
    super.initState();
    listenIncomingSms();
  }

  void listenIncomingSms() {
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        setState(() {
          messages.insert(0, message); // ajoute le dernier SMS en haut de la liste
        });
      },
      onBackgroundMessage: backgroundMessageHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SMS Listener")),
      body: messages.isEmpty
          ? Center(child: Text("En attente de SMS..."))
          : ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final sms = messages[index];
                return ListTile(
                  title: Text(sms.body ?? "Message vide"),
                  subtitle: Text("De: ${sms.address ?? 'Inconnu'}"),
                );
              },
            ),
    );
  }
}
*/
