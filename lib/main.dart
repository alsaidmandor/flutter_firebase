import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/provider/auth_provider.dart';
import 'package:flutter_firebase/screens/home.dart';
import 'package:flutter_firebase/screens/login.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // is used to interact with the flutter engine
  await Firebase
      .initializeApp(); // need to call native code to initialize firebase
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _showHomeScreen(context),
    );
  }

  Widget _showHomeScreen(context) {
    var prov = Provider.of<AuthProvider>(context);
    switch (prov.authStatus) {
      case AuthStatus.authenticating:
      case AuthStatus.unAuthenticated:
        return Login();
      case AuthStatus.authenticated:
        return Home(prov.user);
    }
    return Container();
  }
}
