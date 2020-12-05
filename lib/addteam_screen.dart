import 'dart:io';
import 'show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:applicationx/login_screen.dart';
import 'package:applicationx/team_screen.dart';
import 'package:image_picker/image_picker.dart';
import './backend/teams.dart';
import './beans/team.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AddteamPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<AddteamPage> {
  File _image;
  var picker = ImagePicker();
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  int _value = 1;

  @override
  void dispose() {
    super.dispose();
    _image = null;
    picker = null;
  }

  Future getImage(String source) async {
    PickedFile pickedFile;

    if (source == 'From Gallery') {
      pickedFile = await picker.getImage(source: ImageSource.gallery);
    } else {
      pickedFile = await picker.getImage(source: ImageSource.camera);
    }
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage('From Gallery');
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage('From Camera');
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Team'),
      ),
      body: Padding(
        padding: EdgeInsets.all(50),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Team Information',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                obscureText: false,
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Please enter a team name',
                  //suffixIcon: Icon(Icons.contact_page),
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white70,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Team Name',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                obscureText: false,
                maxLines: 5,
                controller: descController,
                decoration: InputDecoration(
                  hintText: 'Please enter description',
                  //suffixIcon: Icon(Icons.contact_page),
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white70,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              //color: Colors.orangeAccent,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        dropdownColor: Colors.green[50],
                        // elevation: 8,
                        isExpanded: true,
                        value: _value,
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              'Select Team Type',
                              style: TextStyle(fontSize: 17),
                              //  fontWeight: FontWeight.bold),
                              // textAlign: TextAlign.center,
                            ),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Company',
                              style: TextStyle(fontSize: 17),
                            ),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Friends',
                              style: TextStyle(fontSize: 17),
                            ),
                            value: 3,
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _value = value;
                          });
                        }),
                  ),
                ),
              ),
            ),
            Container(
              child: Text(
                'Upload Team Profile',
                style: TextStyle(fontSize: 17, color: Colors.blueGrey[500]),
                //fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
              child: _image == null
                  ? GestureDetector(
                      onTap: () {
                        myAlert();
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        child: CircleAvatar(
                          radius: 100,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.add_a_photo,
                            size: 100,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        _image,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 5,
                      ),
                    ),
            ),
            Container(
                height: 80,
                padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.green,
                  child: Text(
                    'Assign Players',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                )),
            Container(
                height: 80,
                padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.green,
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () => getData(),
                )),
          ],
        ),
      ),
    );
  }

  void getData() async {
    EasyLoading.show(
      status: 'loading...',
    );
    Team teamObj = Team(
        name: nameController.text,
        desc: descController.text,
        type: _value,
        image: _image);
    String str = await Teams().addTeam(teamObj);
    if (str == 'success') {
      EasyLoading.dismiss();
      Navigator.pop(
        context,
        true,
      );
    } else {
      ShowDialogMessage.dialogShow(
        context,
        str,
        "Message",
      );
    }
  }
}
