import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/home.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _name;

  String _email;

  String _password;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(hintText: 'Enter your Name'),
                  onChanged: (value) {
                    setState(() {
                      _name = value;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Enter your Email'),
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Password'),
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  child: Text('Register'),
                  onPressed: () async {
                    try {
                      UserCredential credential =
                          await auth.createUserWithEmailAndPassword(
                              email: this._email, password: this._password);
                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(
                      //     builder: (_) => Home(),
                      //   ),
                      // );
                    } on FirebaseAuthException catch (e) {
                      if(e.code == 'weak-password'){
                        // show Toast
                      }
                      else if(e.code == 'email-already-in-use')
                        {
                          // show snackBar
                        }
                      // print('exception');
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
