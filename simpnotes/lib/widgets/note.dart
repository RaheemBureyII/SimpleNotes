import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Note extends StatelessWidget {
  final CollectionReference collectionReference = FirebaseFirestore.instance.collection("notes");
   final TextEditingController textediter = TextEditingController();
  final String textvalue;
  final String id;
    Note(this.textvalue,this.id);
  @override
  Widget build(BuildContext context) {
    
    return Container(

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text(textvalue,style: TextStyle(fontSize: 14),),
        Row(children:[IconButton(icon: Icon(Icons.edit), onPressed: (){
          showModalBottomSheet(context: context, builder: (BuildContext context){
            return Column(children: [
               Expanded(child: TextField(controller:textediter ,)),
              ElevatedButton(onPressed: ()async{
                  await collectionReference.doc(id).update({"name":textediter.text}).then((value){
                    Navigator.of(context).pop();
                    return textediter.clear();});
              },child:Text("Add Note"))
            ],);
          });
          
        }),
        IconButton(icon: Icon(Icons.delete), onPressed: (){
          collectionReference.doc(id).delete();
        })])
        
      ],),
    );
  }
}