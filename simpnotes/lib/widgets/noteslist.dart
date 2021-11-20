import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simpnotes/widgets/note.dart';

class NotesList extends StatefulWidget {
  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  final TextEditingController textediter = TextEditingController();
  final CollectionReference collectionReference = FirebaseFirestore.instance.collection("notes");

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Expanded(child: TextField(controller:textediter ,)),
              ElevatedButton(onPressed: ()async{
                  await collectionReference.add({"name":textediter.text}).then((value) => textediter.clear());
              },child:Text("Add Note"))
            ],),
          ),
          Expanded(child:StreamBuilder(stream:collectionReference.snapshots(),builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.hasData)
              {
                  return ListView(
                    children:snapshot.data.docs.map((e)=>Note(e["name"],e.id)).toList()
                  );
              }
              return(Center(child:Text("No data")));
          })),
        ],
      ),
    );
  }
}