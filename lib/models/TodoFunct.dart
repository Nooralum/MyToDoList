class ToDo{
  String? id;
  String? Text;
  String? User;
  bool isDone;

ToDo({
   required this.id,
   required this.Text,
   this.isDone = false,
});

 static List<ToDo> todolist(){
  return [
    ToDo(id: '01', Text: 'Champ de texte', isDone: true ),
    ToDo(id: '02', Text: 'faire une page facebook', isDone: true ),
    ToDo(id: '03', Text: 'faire un formulaire',),
    ToDo(id: '04', Text: 'utiliser listTile',),
    ToDo(id: '05', Text: 'faire une To do List',),
    ToDo(id: '06', Text: 'terminer la section 13',),
  ];

 }
}

