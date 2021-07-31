import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/pages/calendar_page.dart';
import 'package:productivity_app/pages/loading_page.dart';
import 'package:productivity_app/providers/event_provider.dart';
import 'package:productivity_app/pages/login.dart';
import 'package:productivity_app/services/auth.dart';
import 'package:productivity_app/pages/signup.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => EventProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _initialized = false;
  bool _error = false;

  void initializedFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      print(e.toString());
      _error = true;
    }
  }

  @override
  void initState() {
    initializedFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return Container(
        child: Text("Failed to Connect to servers"),
      );
    }

    if (!_initialized) {
      return Container(
        child: Text("Connecting"),
      );
    }
    return Streamer();
  }
}

class Streamer extends StatefulWidget {
  const Streamer({Key? key}) : super(key: key);

  @override
  _StreamerState createState() => _StreamerState();
}

class _StreamerState extends State<Streamer> {
  final _streamProvider = AuthService().user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(
          stream: _streamProvider,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? LoadingPage()
                  : LandingPage();
            } else {
              return CalendarPage(currentUser: snapshot.data);
            }
          }),
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "Welcome",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Begin Planning Out Your Days Today",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blueGrey[400],
                    fontSize: 20,
                  ),
                )
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/calendar.png"),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                // login button
                MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),

                SizedBox(height: 20),
                //  sign up button
                MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  color: Color(0xff0095ff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
                // test button
                // MaterialButton(
                //   minWidth: double.infinity,
                //   height: 60,
                //   onPressed: () {
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (context) => MyApp()));
                //   },
                // ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}

// 1JW7Y2nwBze1HxxR8wtisR8zum2