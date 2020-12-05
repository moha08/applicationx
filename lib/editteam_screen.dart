import 'dart:io';
import 'package:flutter/material.dart';
import 'package:applicationx/login_screen.dart';
import 'package:applicationx/team_screen.dart';
import 'package:image_picker/image_picker.dart';

class EditteamPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<EditteamPage> {
  File _image;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int _value = 1;

  Future getImage(ImageSource media) async {
    var img = await ImagePicker.pickImage(source: media);
    setState(() {
      _image = img;
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
                      getImage(ImageSource.gallery);
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
                      getImage(ImageSource.camera);
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
        title: Text('Edit Team'),
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
                //controller: nameController,
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
                  border: Border.all(color: Colors.green, width: 2),
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
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[700]),
                              //  fontWeight: FontWeight.bold),
                              // textAlign: TextAlign.center,
                            ),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Company',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[700]),
                            ),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Friends',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[700]),
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
                  onPressed: () {
                    Navigator.pop(
                      context,
                      MaterialPageRoute(builder: (context) => TeamPage()),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
