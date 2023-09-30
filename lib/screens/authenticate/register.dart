import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mytodolist/screens/Accueil.dart';

import '../../constants.dart';

class RegisterPage extends StatefulWidget {
  static const String id = 'register';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
   FirebaseAuth _auth = FirebaseAuth.instance;
   FirebaseFirestore _firestore = FirebaseFirestore.instance;
  GlobalKey<FormState> _globalKey =  GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  String _name= '';

   Future<void> inscription() async{
    //récupérer l'etat actuel de l'inscription
     final formState = _globalKey.currentState;
     if((formState?.validate()?? false)){
      formState?.save();
      try {
        final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: _email!, password: _password!);
        await _firestore.collection('users').doc(userCredential.user!.uid).set({'name': _name, 'email': _email, 'password':_password});
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
                validator:(value) => value!.isEmpty? 'Entrez un nom svp': null,
                onSaved:(value) => _name = value!,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Nom',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  )
              
                ),
              ),
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
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                ),
                onSaved:(value) => _email = value!,
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
                    inscription();
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
                )
            ],
          ),
        ),
      ),
    );
  }
}