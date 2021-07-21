// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();

//   /// InheritedWidget style accessor to our State object.
//   /// We can call this static method from any descendant context to find our
//   /// State object and switch the themeMode field value & call for a rebuild.
//   static _MyAppState of(BuildContext context) =>
//       context.findAncestorStateOfType<_MyAppState>();
// }

// /// Our State object
// class _MyAppState extends State<MyApp> {
//   /// 1) our themeMode "state" field
//   ThemeMode _themeMode = ThemeMode.system;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(),
//       darkTheme: ThemeData.dark(),
//       themeMode: _themeMode, // 2) ← ← ← use "state" field here //////////////
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }

//   /// 3) Call this to change theme from any context using "of" accessor
//   /// e.g.:
//   /// MyApp.of(context).changeTheme(ThemeMode.dark);
//   void changeTheme(ThemeMode themeMode) {
//     setState(() {
//       _themeMode = themeMode;
//     });
//   }
// }

// class MyHomePage extends StatelessWidget {
//   final String title;

//   MyHomePage({this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back_ios),
//           iconSize: 20,
//           color: Colors.black,
//         ),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Choose your theme:',
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 /// //////////////////////////////////////////////////////
//                 /// Change theme & rebuild to show it using these buttons
//                 /// to find our State object and call changeTheme()
//                 ElevatedButton(
//                     onPressed: () =>
//                         MyApp.of(context).changeTheme(ThemeMode.light),
//                     child: Text('Light')),
//                 ElevatedButton(
//                     onPressed: () =>
//                         MyApp.of(context).changeTheme(ThemeMode.dark),
//                     child: Text('Dark')),

//                 /// //////////////////////////////////////////////////////
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
