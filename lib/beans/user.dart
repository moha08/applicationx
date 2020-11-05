import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String fullName;
  String email;
  String password;

  User({this.fullName, this.email, this.password});

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    return users
        .add({'full_name': fullName, 'email': email, 'password': password})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
