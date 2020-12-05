import 'package:image/image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../beans/team.dart';

class Teams {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage firebase_storage = FirebaseStorage.instance;

  Future<String> addTeam(Team team) async {
    String addTeamResult = "";
    CollectionReference teams = FirebaseFirestore.instance.collection('teams');

    var userUID = _firebaseAuth.currentUser.uid;

    try {
      Image image = decodeJpg(team.image.readAsBytesSync());
      Image thumbnail = copyResize(image, width: 120);

      await firebase_storage
          // .ref('uploads/${userUID}_${team.name}.png')
          .ref('uploads/test.png')
          //  .getDownloadURL()
          .putData(encodePng(thumbnail))
          .whenComplete(() {
        teams
            .add({
              'team_name': team.name,
              'team_desc': team.desc,
              'team_type': team.type,
              'user': userUID
            })
            .catchError((error) => addTeamResult = "$error")
            .whenComplete(() => addTeamResult = "success");
      });
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      addTeamResult = e.toString();
    }
    return addTeamResult;
  }

  Future<Team> getTeam() async {
    Team team = Team();
    var userUID = _firebaseAuth.currentUser.uid;
    String imageUrl;

    // Directory appDocDir = await getApplicationDocumentsDirectory();
    //File downloadToFile = File('${appDocDir.path}/test.png');

    try {
      imageUrl = await FirebaseStorage.instance
          .ref('uploads/test.png')
          .getDownloadURL();
      //  .writeToFile(downloadToFile);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print(e.toString());
    }

    QuerySnapshot querySnap = await FirebaseFirestore.instance
        .collection("teams")
        .where("user", isEqualTo: userUID)
        .get();
    querySnap.docs.forEach((doc) {
      print(doc["team_desc"]);
      print(doc["team_name"]);
      print(doc["team_type"]);
      team.desc = doc["team_desc"];
      team.name = doc["team_name"];
      team.type = doc["team_type"];
      //  team.image = downloadToFile;
      team.imageLink = imageUrl;
    });

    return team;
  }
}
