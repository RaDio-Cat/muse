import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../authenticate/intro.dart';
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
      Stack(
        children: [Container(
          decoration:BoxDecoration(
            gradient: LinearGradient(colors: [Colors.purple.shade300,Colors.black],
            stops: [0.01,1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter)
          )
        ),
        Scaffold(extendBodyBehindAppBar: true,
        backgroundColor:Colors.transparent,
        appBar: AppBar(
          leading: InkWell(
          onTap: ()async {
            await FirebaseAuth.instance.signOut();
                    print('user logged out');
                    Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  IntroPage()));
          },
          child: Icon(Icons.arrow_back_ios)
        ),
          backgroundColor: Colors.transparent,
          title: Text('Home',
          style: TextStyle(color: Colors.amber),),
        ),
        )
        ],
      );
  }
}