import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smart_home/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  static String screenId = 'Welcome';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    getcurrentUser();
    super.initState();
  }

  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  void getcurrentUser()async{
    try{
      final user = await _auth.currentUser();
      if(user==null){
        Navigator.pop(context);
      }
      else{
        loggedInUser = user;
        print(loggedInUser.email);
      }
    }
    catch(e){
      print(e);
    }
  }

  List Room_List = [
    'Living Room'.toUpperCase(),
    'Kitchen'.toUpperCase(),
    'Drawing Room'.toUpperCase(),
    'Dining room'.toUpperCase(),
    'Garden'.toUpperCase(),
    'Study Area'.toUpperCase()
  ];
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2F2F30),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF2F2F30),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage('assets/snowflake.png'),
                    width: 55,
                    height: 55,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "23\u00B0C",
                  style: TextStyle(fontSize: 45),
                )
              ],
            ),
            Icon(
              Icons.notifications,
              size: 55,
            )
          ],
        ),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 25,
          ),
          ScrollBarTop(Room_List: Room_List),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              card(context,'snowflake.png',0xffA0D8EB,'Air Conditioner','Voltas RF-1450'),
              card(context,'monitor.png',0xFFECB524,'Smart TV','Samsung EX55 4k')
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              card(context,'bulb.png',0xFF17B856,'Light Bulb','Philips HUE 2'),
              card(context,'door.png',0xFF812FFE,'Smart Door','Smart Door')
            ],
          ),
        ],
      ),
    );
  }

  Container card(BuildContext context , String image , var colorCode , String type,String model) {
    return Container(
              width: MediaQuery.of(context).size.width * 0.40,
              height: MediaQuery.of(context).size.width * 0.50,
              decoration: BoxDecoration(
                  color: Color(colorCode),
                  borderRadius: BorderRadius.circular(25)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                      image: AssetImage('assets/'+image),
                      width: 40,
                      height: 40,
                      color: Colors.white,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          type,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          model,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15
                          ),
                        ),
                        Switch(
                          value: isSwitched,
                          onChanged: (value){
                            setState(() {
                              isSwitched=value;
                              print(isSwitched);
                            });
                          },
                          activeTrackColor: Colors.white,
                          inactiveThumbColor: Colors.black,
                          activeColor: Colors.red,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
  }
}

class ScrollBarTop extends StatelessWidget {
  const ScrollBarTop({
    Key key,
    @required this.Room_List,
  }) : super(key: key);

  final List Room_List;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                Room_List[index],
                style: top_navigation_text_style,
              ),
            ),
          );
        },
      ),
    );
  }
}
