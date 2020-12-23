import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/provider/auth_provider.dart';
import 'package:flutter_firebase/screens/login.dart';
import 'package:provider/provider.dart';


class Home extends StatelessWidget {

  User user ;


  Home(this.user);

  @override
  Widget build(BuildContext context) {

    var prov = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: (){
            prov.logOut();
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Login(),),);
          },)
        ],
      ),
      body: Center(child: Text(prov.user.email)),
    );
  }
}


/*
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth auth = FirebaseAuth.instance; // server auth db
  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                  auth.signOut();
              },
            ),
          ],
        ),
        body: Center(
          child: Text('Home Screen'),
        ));
  }
}
*/
