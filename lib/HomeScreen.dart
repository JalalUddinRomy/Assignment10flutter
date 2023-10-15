import 'package:assingnment_10_flutter/Edit_Todo_Screen.dart';
import 'package:flutter/material.dart';

import 'Todo.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _HomeState();
  }
  
}
class _HomeState extends State<HomeScreen>{
  List<Todo> TodoList=[];
  final TextEditingController titleTEcontroller=TextEditingController();
  final TextEditingController descriptionTEcontroller=TextEditingController();
  GlobalKey<FormState> _form1key=GlobalKey();
  GlobalKey<FormState> _form2key=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        actions: [
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Icon(Icons.search_outlined,color: Colors.deepOrange,),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          children: [
           Column(
             children: [
               Form(
                 key: _form1key,
                 child: TextFormField(
                   textInputAction: TextInputAction.next,
                   controller: titleTEcontroller,
                   decoration: InputDecoration(
                       hintText: 'Add Title',
                       enabledBorder:OutlineInputBorder(),
                       focusedBorder: OutlineInputBorder(
                           borderSide:BorderSide(color: Colors.deepOrange)
                       )
                   ),
                   validator: (String? value){
                     if(value?.isEmpty ??true){
                       return 'Enter a value';
                     }
                     return null;
                   },
                 ),
               ),
               SizedBox(
                 height: 14,
               ),
               Form(
                 key: _form2key,
                 child: TextFormField(
                   textInputAction: TextInputAction.done,
                   controller: descriptionTEcontroller,
                   decoration: InputDecoration(
                       hintText: 'Add Description',
                       enabledBorder:OutlineInputBorder(),
                       focusedBorder: OutlineInputBorder(
                           borderSide:BorderSide(color: Colors.deepOrange)
                       )
                   ),
                   validator: (String? value){
                     if(value?.isEmpty ??true){
                       return 'Enter a value';
                     }
                     return null;
                   },
                 ),
               ),
             ],
           ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                onPressed: (){
                if(_form1key.currentState!.validate()&&_form2key.currentState!.validate()){
                 Todo todo=Todo(SubTitle: descriptionTEcontroller.text.trim(),
                     Title:titleTEcontroller.text.trim());
                 addToDo(todo);
                 FocusScope.of(context).unfocus();
                }


                }, child: Text("ADD")),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView.separated(
                  itemCount: TodoList.length,
                  itemBuilder: (context, index){
                   final Todo todo=TodoList[index];
                    return ListTile(
                      tileColor: Colors.black12,
                      onLongPress: (){
                        showDialog(context: context, builder: (context){
                          return AlertDialog(
                            content: Text("ALART!"),
                            actions: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(onPressed: (){
                                    Navigator.pop(context);
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                        context: context,
                                        builder: (context){
                                      return Padding(
                                        padding:EdgeInsets.only(
                                            bottom: MediaQuery.of(context).viewInsets.bottom),
                                        child: editToDoScreen(todo: todo, onEditTodo: (String editTitle, String editDescription){
                                         editTodo(index, editTitle, editDescription) ;
                                        }),
                                      );

                                    });


                                  }, child: Text("Edit")),
                                  SizedBox(width: 10,),
                                  TextButton(onPressed: (){
                                    deleteToDo(index);
                                    Navigator.pop(context);
                                  }, child: Text("Delete")),
                                ],
                              )
                            ],
                          );
                        });
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: Text('${index+1}'),
                      ),
                      title: Text(todo.Title),
                      subtitle: Text(todo.SubTitle),
                      trailing:Icon(Icons.arrow_right_alt_outlined),
                    );
                  }, separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      height: 5,
                    );
              },),
            )
          ],
        ),
      ),
    );
  }
  void addToDo(Todo task){
    TodoList.add(task);
    setState(() {
      titleTEcontroller.clear();
      descriptionTEcontroller.clear();

    });
  }
  void deleteToDo(int index){
    TodoList.removeAt(index);
    setState(() {
    });
  }
  void editTodo(int index,String editTitle,String editDescription){
    TodoList[index].Title=editTitle;
    TodoList[index].SubTitle=editDescription;
    setState(() {
    });
  }
  
}