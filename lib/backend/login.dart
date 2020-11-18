import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../beans/users.dart';

class Login {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String userName, String password) async {
    String signInResult = "";

    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: userName,
        password: password,
      );

      if (!userCredential.user.emailVerified) return "email not verified";

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

  Future<String> signUp(Users user) async {
    String signUpResult = "success";

    // create User
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    )
        .catchError((err) {
      signUpResult = err.toString();
    });
    try {
      await userCredential.user.sendEmailVerification();
      //return user.uid;
    } catch (e) {
      print("An error occured while trying to send email verification");
      print(e.message);
    }

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

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
