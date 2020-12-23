import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/provider/auth_provider.dart';
import 'package:flutter_firebase/screens/home.dart';
import 'package:flutter_firebase/screens/register.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email;

  String _password;

  var loginKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<AuthProvider>(context);

    return Scaffold(
        key: loginKey,
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(hintText: 'Email'),
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
                child: Column(
                  children: [
                    prov.authStatus == AuthStatus.authenticating ? CircularProgressIndicator() :  Text('Login'),
                  ],
                ),
                onPressed: () async {
                  if (!await prov.login(_email, _password)) {
                    loginKey.currentState.showSnackBar(
                        SnackBar(content: Text(prov.errorMessage)));
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(prov.user),
                      ),
                    );
                  }
                }
              ),
              FlatButton(
                child: Text('Sign Up'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => Register(),
                    ),
                  );
                },
              )
            ],
          ),
        ));
  }
}
