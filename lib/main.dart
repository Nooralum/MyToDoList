import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mytodolist/firebase_options.dart';
import 'package:mytodolist/screens/Accueil.dart';
import 'package:mytodolist/screens/authenticate/connection.dart';
import 'package:mytodolist/screens/authenticate/register.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
    const MyApp()
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ma todoList',
      initialRoute: ConnectionPage.id,
      routes: {
        ConnectionPage.id:(context) => ConnectionPage(),
        RegisterPage.id:(context) => RegisterPage(),
        Home.id:(context) => Home(),
      },
    );
  }
}