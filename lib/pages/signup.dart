import 'package:flutter/material.dart';
import 'package:productivity_app/pages/loading_page.dart';
import 'package:productivity_app/pages/login.dart';
import 'package:productivity_app/services/auth.dart';

class SignUpPage extends StatefulWidget {
  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();
  AuthService _auth = AuthService();

  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            // Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoadingPage()));
          },
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 20,
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Form(
            key: widget._formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Create account",
                      style:
                          TextStyle(fontSize: 15, color: Colors.blueGrey[400]),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    CustomTextField(
                      label: 'Email',
                      onpressed: (val) {
                        setState(() => widget.email = val.trim());
                      },
                    ),
                    CustomTextField(
                      label: 'Password',
                      obscureText: true,
                      onpressed: (val) {
                        setState(() => widget.email = val.trim());
                      },
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 3, left: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () async {
                      if (widget._formKey.currentState!.validate()) {
                        //tries to create a new login
                        dynamic result = await widget._auth
                            .registerFirebaseUser(
                                widget.email, widget.password);
                      }
                    },
                    color: Color(0xff0095ff),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Already have an account?"),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text(
                        " Login",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class SignUpPge extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         brightness: Brightness.light,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back_ios),
//           iconSize: 20,
//           color: Colors.black,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 40),
//           height: MediaQuery.of(context).size.height - 50,
//           width: double.infinity,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               Column(
//                 children: <Widget>[
//                   Text(
//                     "Sign up",
//                     style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Text(
//                     "Create account",
//                     style: TextStyle(fontSize: 15, color: Colors.blueGrey[400]),
//                   )
//                 ],
//               ),
//               Column(
//                 children: <Widget>[
//                   inputFile(label: "First Name"),
//                   inputFile(label: "Last Name"),
//                   inputFile(label: "Email"),
//                   inputFile(label: "Password", obscureText: true),
//                 ],
//               ),
//               Container(
//                 padding: EdgeInsets.only(top: 3, left: 3),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50),
//                 ),
//                 child: MaterialButton(
//                   minWidth: double.infinity,
//                   height: 60,
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => LoadingPage()));
//                   },
//                   color: Color(0xff0095ff),
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                   child: Text(
//                     "Sign Up",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 18,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text("Already have an account?"),
//                   Text(
//                     " Login",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class CustomTextField extends StatefulWidget {
  final String label;
  bool obscureText;
  var onpressed;

  CustomTextField(
      {required this.label, this.obscureText = false, required this.onpressed});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          onChanged: widget.onpressed,
          obscureText: widget.obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFBDBDBD),
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFBDBDBD),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

// Widget inputFile({label, obscureText = false}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: <Widget>[
//       Text(
//         label,
//         style: TextStyle(
//             fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),
//       ),
//       SizedBox(
//         height: 5,
//       ),
//       TextField(
//         obscureText: obscureText,
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Color(0xFFBDBDBD),
//             ),
//           ),
//           border: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Color(0xFFBDBDBD),
//             ),
//           ),
//         ),
//       ),
//       SizedBox(
//         height: 10,
//       ),
//     ],
//   );
// }
