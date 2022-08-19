import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:muse/screens/authenticate/intro.dart';
import 'package:muse/screens/authenticate/register.dart';
import 'package:muse/screens/home/home.dart';
import 'package:muse/screens/home/musicroom.dart';
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context,snapshot){
        if (snapshot.connectionState == ConnectionState.active){
          User? user = snapshot.data;
          if (user == null){
            return IntroPage();
          }
          return MusicRoom();
        }else{
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      });
  }
}