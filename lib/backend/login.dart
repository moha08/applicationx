import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../beans/users.dart';

class Login {
  static Future<String> signIn(String userName, String password) async {
    String signInResult = "";

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userName,
        password: password,
      );
      signInResult = "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        signInResult = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        signInResult = 'Wrong password provided for that user.';
      } else {
        print(e.message);
        signInResult = e.message;
      }
    }

    return signInResult;
  }

  static Future<String> signUp(Users user) async {
    String signUpResult = "success";

    // create User
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    )
        .catchError((err) {
      signUpResult = err.toString();
    });
    print(signUpResult);
    // Add user to firebase cloud storage
    if (signUpResult == "success") {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      users
          .add({
            'full_name': user.fullName,
            'email': user.email,
            'password': user.password,
            'mobile_number': user.mobileNumber
          })
          .then((value) => signUpResult = "User Added")
          .catchError((error) => signUpResult = "Failed to add user: $error");
      return signUpResult;
    }

    return signUpResult;
  }
}
