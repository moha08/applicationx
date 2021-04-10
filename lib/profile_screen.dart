import 'package:flutter/material.dart';
import 'package:applicationx/login_screen.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PROFILE'),
        ),
        body: Center(
            child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  child: Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Container(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                // height: 40,
                child: Text(
                  'Personal Information',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )),
            new TextFormField(
              enabled: false,
              readOnly: true,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: '   Last Name: Khalaf',
                suffixIcon: Icon(Icons.edit),
              ),
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            new TextFormField(
              enabled: false,
              readOnly: true,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: '   First Name: Mohammed',
                suffixIcon: Icon(Icons.edit),
              ),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            new TextFormField(
              enabled: false,
              readOnly: true,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: '   Role: Defender',
                suffixIcon: Icon(Icons.edit),
              ),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            new TextFormField(
              enabled: false,
              readOnly: true,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: '   Email: Mohammed@hotmail.com',
                suffixIcon: Icon(Icons.edit),
              ),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            new TextFormField(
              enabled: false,
              readOnly: true,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: '   Mobile Number: 0795324045',
                suffixIcon: Icon(Icons.edit),
              ),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )));
  }
}
