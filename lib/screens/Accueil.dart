import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mytodolist/constants.dart';
import 'package:mytodolist/screens/authenticate/connection.dart';

import '../models/TodoFunct.dart';
import 'todoItem.dart';

class Home extends StatefulWidget {
  static const String id = 'accueil';
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final maList = ToDo.todolist();
  List<ToDo> search = [];
  final monController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? take;


  @override
  void initState() {
    search = maList;
    super.initState();
    UserGet();
  }

  void UserGet() async{
    User? _Myuser = _auth.currentUser;
    var userCollect = await FirebaseFirestore.instance.collection('users').get();
   
   _Myuser!.email;
   userCollect.docs.forEach((doc) {
    print('Nom: ${doc.data()['name']}');

    for (var chic in userCollect.docs) {
      if (_Myuser.email == doc.data()["email"]) {
      setState(() {
        take = doc.data()["name"];
      });
      }
    }
    });

  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: back,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                          ),
                          child: const Text(
                            "Toutes ma liste",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                      ),
                      for(ToDo todo in search)
                      ToDoItem(
                        todo: todo,
                        TodoChanged: changeList,
                        SupprimerItem: _deleteItem,
                        ),
                    
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child:  Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                     color: Colors.white,
                     boxShadow: const [BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 0),
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                     )],
                     borderRadius: BorderRadius.circular(10),
                     ),
                     child: TextField(
                      controller: monController,
                      decoration: const InputDecoration(
                        hintText: 'Ajouter une nouvelle tâche',
                        border: InputBorder.none
                      ),

                     ),
                     

                  )
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom : 20,
                    right: 20,
                    ),
                    child: ElevatedButton(
                      child: Text("+", style:TextStyle(fontSize: 40,),),
                      onPressed: (){
                        _addItem(monController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        minimumSize: Size(60, 60),
                        elevation: 10,
                      ),

                      ),

                  
                  ),
               
              ],
            ),

          )
        ],
      ),
    );
  }

  void changeList(ToDo todo){
    setState(() {
      todo.isDone = !todo.isDone;
      
    });
  }

 void _deleteItem(String id){
      setState(() {
        maList.removeWhere((item)  => item.id == id );
        
      });
    }

  void _addItem(String todo){
    setState(() {
      maList.add(ToDo(
      id: DateTime.now().millisecondsSinceEpoch.toString(), 
    Text: todo));
    });
    monController.clear();
  }

  void _research(String enteredKeyword){
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty){ // si le mot clé entré est vide,
      results = maList;  //  les résultats seront pris dans la liste des taches
    } else {
      results = maList
      .where((item) => item.Text!
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
      .toList();
    }
    setState(() {
       search = results;
    });

  }

  Widget searchBox(){
    return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child:  TextField(
                onChanged: (value) =>  _research(value),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.blue,
                    size: 20,
                    ),
                    prefixIconConstraints: BoxConstraints(
                      maxHeight: 20,
                      minWidth: 25,
                    ),
                    border: InputBorder.none,
                    hintText: 'search',
                    hintStyle: TextStyle(color: Colors.grey),

                ),
              ),
            );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.amber,
      elevation: 0,
      title: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Bienvenue $take"),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: IconButton(
                icon:Icon(Icons.logout, size: 20 ), 
                onPressed: () {  
                  _auth.signOut();
                  Navigator.pushNamed(context, ConnectionPage.id);
                }, 
                )
            ),
          )
        ],
      ),);
  }
}