import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:student_db/UI/student_info.dart';
import 'package:student_db/model/student.dart';
import 'package:student_db/UI/student_screen.dart';
import 'package:student_db/UI/student_info.dart';



class ListViewStudent extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return ListViewStudentState();
  }

}

final studentReferance=FirebaseDatabase.instance.reference().child("student");
class ListViewStudentState extends State<ListViewStudent>{

  List<Student> items;
  StreamSubscription<Event>_onStudentAddedSubscription;
  StreamSubscription<Event>_onStudentChangedSubscription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items=new List();
    _onStudentAddedSubscription=studentReferance.onChildAdded.listen(_onStudentAdded);
    _onStudentChangedSubscription=studentReferance.onChildChanged.listen(_onStudentChanged);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onStudentAddedSubscription.cancel();
    _onStudentChangedSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      title: 'Student Db',
      home:new Scaffold(
        appBar: new AppBar(
          title: new Text("Student Information"),
          centerTitle: true,
          backgroundColor: Colors.pink.shade900,
        ),
        body: new Container(
          child: ListView.builder(
              itemCount: items.length,
//              padding: EdgeInsets.only(top: 12.0),

              itemBuilder: (context,position){

                return new Column(
                  children: <Widget>[
                    Divider(height: 5.0,),
                    Row(
                        children: <Widget>[
                          Expanded(
                            child: ListTile(
                                title: Text("${items[position].name}",style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 22.0

                                ),),
                                subtitle:Text("${items[position].discription}",style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 14.0

                                ),),
                                leading:new Column(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor: Colors.amber,
                                      radius: 14.0,
                                      child:Text("${position+1}",style: TextStyle(
                                          color: Colors.redAccent) ,
                                      ),
                                    ),

                                  ],
                                ) ,
                                onTap:()=>_navigateToStudentInfo(context,items[position]) ) ,
                          ),

                          IconButton(icon: Icon(Icons.delete,color: Colors.red,)
                              , onPressed:()=>_deleteStudent(context,items[position],position) ),
                          IconButton(icon: Icon(Icons.edit,color: Colors.white,)
                              , onPressed:()=>_navigateToStudent(context,items[position]) ),
                        ],

                    ),



                  ],
                );
              }

          ),
        ),

        floatingActionButton:FloatingActionButton(
          onPressed:()=> _createNewStudent(context),
          child: Icon(Icons.add,color: Colors.white,),
          backgroundColor: Colors.deepOrange,
        ),


      ),
    );
  }

  void _onStudentAdded(Event event){
setState(() {
  items.add(new Student.fromSnapShot(event.snapshot));
});
  }
  void _onStudentChanged(Event event){
var oldStudentValue=items.singleWhere((student)  =>student.id==event.snapshot.key);
setState(() {
  items[items.indexOf(oldStudentValue)]=new Student.fromSnapShot(event.snapshot);
});
  }
  void _deleteStudent(BuildContext context,Student student,int position)async{
   await studentReferance.child(student.id).remove().then((_){
setState(() {
  items.removeAt(position);
});
   });

  }
  void _navigateToStudent(BuildContext context, Student student)async{
    await Navigator.push(context,
      MaterialPageRoute(builder:(context)=>StudentScreen(student)),
    );
  }
  void _navigateToStudentInfo(BuildContext context, Student student)async{
    await Navigator.push(context,
      MaterialPageRoute(builder:(context)=>StudentInfo(student)),
    );
  }
  void _createNewStudent(BuildContext context)async{
    await Navigator.push(context,
      MaterialPageRoute(builder:(context)=>StudentScreen(Student(null, '', '', '', '',''))),
    );
  }



}