import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_home/Screens/Home%20Screen.dart';

class RegScreen extends StatefulWidget {
  static String screenID='registeration';
  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  String email,password;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor:Color(0xFF2F2F30) ,elevation: 0,),
      backgroundColor: Color(0xFF2F2F30),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.70,
          width: MediaQuery.of(context).size.width * 0.90,
          decoration: BoxDecoration(
              color: Color(0xffA0D8EB), borderRadius: BorderRadius.circular(25)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(child: Icon(Icons.home,size: 75,),tag: 'icon',),
              Text("Smart Home",style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold
              ),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign:TextAlign.center,
                  onChanged: (value){
                    email = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email Id',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: true,
                  textAlign:TextAlign.center,
                  onChanged: (value){
                    password=value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Buttons_for_user(
                  buttText: 'Register',
                  Backgroundcolour: Colors.pinkAccent,
                  work: () async {
                    try{
                      final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                      if(newUser!=null){
                        Navigator.pushNamed(context, HomeScreen.screenId);
                      }
                    }
                    catch(e){
                      print(e);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Buttons_for_user extends StatelessWidget {
  final Color Backgroundcolour;
  final String buttText;
  final Function work;
  Buttons_for_user({this.Backgroundcolour,this.buttText,this.work});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80,
      height: MediaQuery.of(context).size.width * 0.10,
      child: TextButton(
        onPressed: work,
        child: Text(buttText),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Backgroundcolour),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
              side: BorderSide(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
