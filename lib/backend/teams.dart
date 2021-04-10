import 'package:image/image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../beans/team.dart';
import 'dart:math';

class Teams {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage firebase_storage = FirebaseStorage.instance;
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  //Random string function to get data for team_code
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<String> addTeam(Team team) async {
    String addTeamResult = "";
    CollectionReference teams = FirebaseFirestore.instance.collection('teams');

    var userUID = _firebaseAuth.currentUser.uid;
    String team_code = getRandomString(5);

    try {
      Image image = team.image == null
          ? Image.rgb(100, 100)
          : decodeJpg(team.image.readAsBytesSync());
      Image thumbnail = copyResize(image, width: 120);

      await firebase_storage
          // .ref('uploads/${userUID}_${team.name}.png')
          .ref('uploads/test.png')
          //  .getDownloadURL()
          .putData(encodePng(thumbnail));
      await teams
          .add({
            'team_name': team.name,
            'team_desc': team.desc,
            'team_type': team.type,
            'user': userUID,
            'team_code': team_code,
            'group_members': FieldValue.arrayUnion([userUID])
          })
          .catchError((error) => addTeamResult = "$error")
          .whenComplete(() => addTeamResult = "success");
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      addTeamResult = e.toString();
    }
    return addTeamResult;
  }

  Future<List<Team>> getTeams() async {
    var userUID = _firebaseAuth.currentUser.uid;
    String imageUrl;

    try {
      imageUrl = await FirebaseStorage.instance
          .ref('uploads/test.png')
          .getDownloadURL();
      //  .writeToFile(downloadToFile);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print(e.toString());
    }
    List<Team> teams = List<Team>();
    QuerySnapshot querySnap = await FirebaseFirestore.instance
        .collection("teams")
        //.where("user", isEqualTo: userUID)
        .where("group_members", arrayContains: userUID)
        .get();

    querySnap.docs.forEach((doc) {
      Team team = Team.url(
        name: doc["team_name"],
        desc: doc["team_desc"],
        type: doc["team_type"],
        teamCode: doc["team_code"],
        imageLink: imageUrl,
        docID: doc.id,
        user: doc["user"],
        isAdmin: (userUID == doc["user"]) ? true : false,
      );

      teams.add(team);
    });

    return teams;
  }

  Future<String> joinTeam(String teamCode) async {
    String joinTeamResult = "";
    var userUID = _firebaseAuth.currentUser.uid;

    CollectionReference teams = FirebaseFirestore.instance.collection('teams');
    QuerySnapshot querySnap = await FirebaseFirestore.instance
        .collection("teams")
        //.where("user", isEqualTo: userUID)
        .where("team_code", isEqualTo: teamCode)
        .get();
    if (querySnap.size == 0) return "wrongID";
    String docID = querySnap.docs[0].id;
    if (docID == null) return "wrongID";
    List<dynamic> groupMembers = querySnap.docs[0]["group_members"];
    groupMembers.add(userUID);
    await teams
        .doc(docID)
        .update({'group_members': groupMembers})
        .whenComplete(() => joinTeamResult = "success")
        .then((value) => joinTeamResult = "success")
        .catchError((error) => print("Failed to update user: $error"));

    return joinTeamResult;
  }

  Future<String> getTeamByCode(String teamCode) async {
    var userUID = _firebaseAuth.currentUser.uid;
    String teamName = "";

    CollectionReference teams = FirebaseFirestore.instance.collection('teams');
    QuerySnapshot querySnap = await FirebaseFirestore.instance
        .collection("teams")
        //.where("user", isEqualTo: userUID)
        .where("team_code", isEqualTo: teamCode)
        .get();
    if (querySnap.size == 0) return "wrongID";
    teamName = querySnap.docs[0]["team_name"];
    if (teamName == null) return "wrongID";

    return teamName;
  }
}
