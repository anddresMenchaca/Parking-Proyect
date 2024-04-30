
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 
FirebaseFirestore db =FirebaseFirestore.instance;
 
Future<List> getPeople() async {
  List people = [];
  CollectionReference collectionReference = db.collection('usuario');
 
  QuerySnapshot quertPeople = await collectionReference.get();
 
 
  quertPeople.docs.forEach((element) {
    people.add(element.data());
  });
 
  return people;
  
}
    