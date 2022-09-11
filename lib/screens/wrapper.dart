import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:muse/screens/authenticate/intro.dart';
import 'package:muse/screens/authenticate/register.dart';
import 'package:muse/screens/home/artist/artisthome.dart';
import 'package:muse/screens/home/home.dart';
import 'package:muse/screens/home/musicroom.dart';

import '../services/usermanagement.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool isArtist = false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user == null) {
              return IntroPage();
            }
            return FutureBuilder(
                future: directHomepage(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (isArtist == true){
                      return ArtistHome();
                    }else{
                      return Home();
                    }
                    // isArtist  ? ArtistHome() : Home();
                  }
                    return Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  
                  //       else{
                  //   return Scaffold(
                  //     body: Center(
                  //       child: CircularProgressIndicator(),
                  //     ),
                  //   );
                  // }
                });
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  directHomepage() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('/users')
        .doc(currentUser!.uid)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        if (snapshot.data()!['role'] == 'artist') {
          isArtist = true;
        } else {
          isArtist = false;
        }
      }
    });
    return isArtist;
  }
}
