import 'package:flutter/material.dart';
import 'package:productivity_app/models/myAppUser.dart';
import 'package:productivity_app/services/auth.dart';

class SettingsPage extends StatelessWidget {
  AuthService auth = AuthService();
  MyAppUser currentUser;
  SettingsPage({required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF76D5FC),
        title: Text(
          'Settings',
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              height: 40,
              onPressed: () {
                auth.signOutFirebaseUser();
              },
              color: Color(0xff0095ff),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                "Sign out",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text('Current User ID: ' + currentUser.uid),
            )
          ],
        ),
      ),
    );
  }
}
