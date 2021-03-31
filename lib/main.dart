import 'package:flutter/material.dart';
import 'package:smart_home/Screens/Home%20Screen.dart';
import 'Screens/RegScreen.dart';
import 'Screens/login.dart';

void main() {
  runApp(Body());
}
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute:Login_Screen.screenID,
      routes: {
        RegScreen.screenID:(context)=>RegScreen(),
        Login_Screen.screenID:(context)=>Login_Screen(),
        HomeScreen.screenId: (context) => HomeScreen(),
      },
    );
  }
}

