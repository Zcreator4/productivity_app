import 'package:flutter/material.dart';
import 'package:productivity_app/models/myAppUser.dart';
import 'package:productivity_app/pages/settings.dart';
import 'package:productivity_app/services/auth.dart';
import 'package:productivity_app/widgets/calendar_widget.dart';
import 'package:productivity_app/pages/event_editing.dart';

class CalendarPage extends StatelessWidget {
  AuthService auth = AuthService();
  MyAppUser currentUser;
  CalendarPage({required this.currentUser});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          // sign out page
          leading: IconButton(
            onPressed: () {
              // auth.signOutFirebaseUser();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SettingsPage(currentUser: currentUser)));
            },
            icon: Icon(Icons.settings),
            color: Colors.white,
          ),
          title: Text('Calendar'),
          centerTitle: true,
          backgroundColor: Color(0xFF76D5FC),
        ),
        body: CalendarWidget(currentUser: currentUser),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Color(0xFF099FFC),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) =>
                    EventEditingPage(currentUser: currentUser)),
          ),
        ),
      );
}

// Center(
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Color(0xFFAED581),
//                 Color(0xFF81D4FA),
//               ],
//             ),
//           ),
//         ),
//       )