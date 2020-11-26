import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../beans/users.dart';
import '../metadata/errors_enum.dart';


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

      if (!userCredential.user.emailVerified)
        return ErrorEnum.VERIFICATION_MAIL_ERROR;

      signInResult = "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        signInResult = ErrorEnum.NO_USER_FOUND_ERROR;
      } else if (e.code == 'wrong-password') {
        signInResult = ErrorEnum.WRONG_PASSWORD_ERROR;
      } else {
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
      signUpResult = ErrorEnum.VERIFICATION_MAIL_ERROR;
      // print("An error occured while trying to send email verification");
      print(e.message);
    }

    // Add user to firebase cloud storage
    if (signUpResult == "success") {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      users.add({
        'full_name': user.fullName,
        'email': user.email,
        'password': user.password,
        'mobile_number': user.mobileNumber
      }).catchError(
          (error) => signUpResult = "$ErrorEnum.FAILED_ADD_USER_ERROR $error");
      return signUpResult;
    }

    return signUpResult;
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
