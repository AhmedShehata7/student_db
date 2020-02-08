
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:student_db/model/student.dart';
import 'package:student_db/UI/student_info.dart';
import 'package:student_db/UI/student_screen.dart';




class StudentScreen extends StatefulWidget{

  final Student student;
  StudentScreen(this.student);

  @override
  State<StatefulWidget> createState() {

    return new StudentScreenState();
  }

}
final studentReferance=FirebaseDatabase.instance.reference().child("student");
class StudentScreenState extends State<StudentScreen>{

  TextEditingController _nameController;
  TextEditingController _ageController;
  TextEditingController _cityController;
  TextEditingController _departmentController;
  TextEditingController _discriptionController;
  @override
  void initState() {

    super.initState();
    _nameController=new TextEditingController(text: widget.student.name);
    _ageController=new TextEditingController(text: widget.student.age);
    _cityController=new TextEditingController(text: widget.student.age);
    _departmentController=new TextEditingController(text: widget.student.department);
    _discriptionController=new TextEditingController(text: widget.student.discription);

  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        title: Text("Students"),
        backgroundColor: Colors.pink.shade700,
      ),
//      backgroundColor: Colors.red,
      body: Container(
//        margin: EdgeInsets.only(top: 15),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(
style: TextStyle(fontSize: 16,color:Colors.deepPurple),
              controller: _nameController,
              decoration: InputDecoration(icon: Icon(Icons.person),labelText: 'Name'),
              
            ),
//            Padding(padding: EdgeInsets.only(top: 8.0)),
            TextField(
              style: TextStyle(fontSize: 16,color:Colors.deepPurple),
              controller: _ageController,
              decoration: InputDecoration(icon: Icon(Icons.person),labelText: 'Age'),

            ),
//            Padding(padding: EdgeInsets.only(top: 8.0)),
            TextField(
              style: TextStyle(fontSize: 16,color:Colors.deepPurple),
              controller: _cityController,
              decoration: InputDecoration(icon: Icon(Icons.location_city),labelText: 'City'),

            ),
//            Padding(padding: EdgeInsets.only(top: 8.0)),
            TextField(
              style: TextStyle(fontSize: 16,color:Colors.deepPurple),
              controller: _departmentController,
              decoration: InputDecoration(icon: Icon(Icons.perm_identity),labelText: 'Department'),

            ),
//            Padding(padding: EdgeInsets.only(top: 8.0)),
            TextField(
              style: TextStyle(fontSize: 16,color:Colors.deepPurple),
              controller: _discriptionController,
              decoration: InputDecoration(icon: Icon(Icons.person),labelText: 'Discription'),

            ),
//            Padding(padding: EdgeInsets.only(top: 8.0)),

            FlatButton(
              onPressed:(){
                if(widget.student.id != null ){
                  studentReferance.child(widget.student.id).set({
                   'name':_nameController.text,
                    'age':_ageController.text,
                    'city':_cityController.text,
                    'department':_departmentController.text,
                    'discription':_discriptionController.text,
                  }).then((_){
                   Navigator.pop(context) ;
                });
                }
                else{
                  studentReferance.push().set({
                    'name':_nameController.text,
                    'age':_ageController.text,
                    'city':_cityController.text,
                    'department':_departmentController.text,
                    'discription':_discriptionController.text,
                  }).then((_){
                    Navigator.pop(context) ;
                  });
                }
              } ,
              child: (widget.student.id != null )? Text('Update'):Text('Add'),
            ),
          ],
        ),
      ),

    ) ;
  }

}