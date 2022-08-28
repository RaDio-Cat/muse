import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muse/screens/home/wallet.dart';
import 'package:muse/tools/widgets.dart';

import '../authenticate/intro.dart';
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
      Stack(
        children: [Container(
          decoration:BoxDecoration(
            gradient: LinearGradient(colors: [Colors.deepPurpleAccent,Colors.black],
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
        body: ListView(
          children: [
            Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Text(
              'Songs',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 3.0,
                color: Colors.amber,
              ),
            ),
          ),
          Container(
            height: 320.0,
            child: SongList(),
          )
          ],
        ),
        bottomNavigationBar: Container(
        color: Colors.black,
        child: Row(
          children: [
            Expanded(
              child: MaterialButton(
                onPressed: (){},
            child: Icon(
              Icons.volume_down,
            color: Colors.white,),)),
            Expanded(
              child: MaterialButton(
                onPressed: (){},
            child: Icon(
              Icons.playlist_add,
            color: Colors.white,),)),
            Expanded(
              child: MaterialButton(
                onPressed: (){
                  //go to user wallet
                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Wallet()));
                },
            child: Icon(
              Icons.wallet,
            color: Colors.white,
            ),)),
          ],
        ),
      ),)
        ],
      );
  }
}