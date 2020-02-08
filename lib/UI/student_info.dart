
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:student_db/model/student.dart';



class StudentInfo extends StatefulWidget{

  final Student student;
  StudentInfo(this.student);

  @override
  State<StatefulWidget> createState() {

    return new StudentInfoState();
  }

}
final studentReferance=FirebaseDatabase.instance.reference().child("student");
class StudentInfoState extends State<StudentInfo>{


  @override
  void initState() {

    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        title: Text("Students Information"),
      ),
//      backgroundColor: Colors.red,
      body: Container(
//        margin: EdgeInsets.only(top: 15),
//        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Text(widget.student.name,style: TextStyle(fontSize: 22.0,color: Colors.deepPurple),),
            Text(widget.student.age,style: TextStyle(fontSize: 12.0,color: Colors.deepPurple),),
            Text(widget.student.city,style: TextStyle(fontSize: 12.0,color: Colors.deepPurple),),
            Text(widget.student.department,style: TextStyle(fontSize: 12.0,color: Colors.deepPurple),),
            Text(widget.student.discription,style: TextStyle(fontSize: 12.0,color: Colors.deepPurple),),



          ],
        ),
      ),
    );
  }}