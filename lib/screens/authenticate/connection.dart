import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mytodolist/constants.dart';
import 'package:mytodolist/screens/Accueil.dart';
import 'package:mytodolist/screens/authenticate/register.dart';

class ConnectionPage extends StatefulWidget {
  static const String id = 'connection';
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}



class _ConnectionPageState extends State<ConnectionPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  GlobalKey<FormState> _globalKey =  GlobalKey<FormState>();

  String _email = '';
  String _password = '';

  Future<void> enregistrement() async{
    final formState = _globalKey.currentState;
    if ((formState!.validate()?? false)) {
      formState.save();
      try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: _email!, password: _password!);
      Navigator.pushNamed(context, Home.id);
      } catch (e) {
        print(e.toString());
      }
    }
  }


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: back,
      body: SafeArea(
        child: Form(
          key: _globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.login_outlined, size: 50,),
              TextFormField(
                 validator: (value) {
                    if (value!.isEmpty)  {
                      return 'Entrer un email Svp';
                    } else if(!(value.contains('@'))) {
                      return 'email incorrect';
                    } else{
                      return null;
                    }
                  },
                  onSaved: (value) => _email=value!,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  )
              
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                obscureText: true,
                keyboardType: TextInputType.number,
                 validator: (value){
                    if (value!.isEmpty) {
                      return 'Entrer un mot de passe';
                    } else if(value.length < 6){
                      return 'Doit dépasser 6 caractère';
                    } else{
                      return null;
                    }
                  },
                   onSaved:(value) => _password = value!,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                ),
              ),
              SizedBox(height: 30,),
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    enregistrement();
                  });
                }, 
                child: Text(
                  'Valider',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black
                  )
                ),
                style: ElevatedButton.styleFrom(
                 minimumSize: Size(200, 50),
                ),
                ),
              SizedBox(height: 30,),
               ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, RegisterPage.id);
                }, 
                child: Text(
                  'Inscription',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black
                  )
                ),
                style: ElevatedButton.styleFrom(
                 minimumSize: Size(200, 50),
                ),
                )
            ],
          ),
        ),
      ),
    );
  }
}