import 'dart:io';

class Team {
  String name;
  String desc;
  int type;
  File image;
  String imageLink;
  String docID;
  String teamCode;

  Team.imageFile({
    this.name,
    this.desc,
    this.type,
    this.image,
    this.docID,
  });

  Team.url({
    this.name,
    this.desc,
    this.type,
    this.imageLink,
    this.teamCode,
    this.docID,
  });
}
