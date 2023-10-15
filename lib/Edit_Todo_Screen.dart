import 'package:flutter/material.dart';

import 'Todo.dart';

class editToDoScreen extends StatefulWidget{
  const editToDoScreen({super.key, required this.todo,
    required this.onEditTodo});

  @override
  State<StatefulWidget> createState() {
    return _editToDoState();
  }
   final Todo todo;
  final Function(String,String) onEditTodo;

}
class _editToDoState extends State<editToDoScreen>{
   late TextEditingController titleTEcontroller=TextEditingController(text: widget.todo.Title);
  late TextEditingController descriptionTEcontroller=TextEditingController(text: widget.todo.SubTitle);
  GlobalKey<FormState> _form1key=GlobalKey();
  GlobalKey<FormState> _form2key=GlobalKey();
  @override
  Widget build(BuildContext context) {
   return Padding(
       padding: EdgeInsets.all(13.0),
     child: Column(
       mainAxisSize: MainAxisSize.min,
       children: [
         Form(
           key: _form1key,
           child: TextFormField(
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
         ElevatedButton(
             style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
             onPressed: (){
               if(_form1key.currentState!.validate()&&_form2key.currentState!.validate()){
                widget.onEditTodo(
                  titleTEcontroller.text.trim(),
                  descriptionTEcontroller.text.trim()
                );
                 Navigator.pop(context);
               }
             }, child: Text("Edit Done")),
       ],
     ),
   );
  }

}