import 'package:firebase_database/firebase_database.dart';
class Student{
  String _id;
  String _name;
  String _age;
  String _city;
  String _department;
  String _discription;

  Student(this._id,this._name,this._age,this._city,this._department,this._discription);
  Student.map(dynamic obj){
    this._name=obj['name'];
    this._age=obj['age'];
    this._city=obj['city'];
    this._department=obj['department'];
    this._discription=obj['discription'];


  }
  String get id=>_id;
  String get name=>_name;
  String get age=>_age;
  String get city=>_city;
  String get department=>_department;
  String get discription=>_discription;



  Student.fromSnapShot(DataSnapshot snapshot){
    _id=snapshot.key;
    _name=snapshot.value['name'];
    _age=snapshot.value['age'];
    _city=snapshot.value['city'];
    _department=snapshot.value['department'];
    _discription=snapshot.value['discription'];

  }




}