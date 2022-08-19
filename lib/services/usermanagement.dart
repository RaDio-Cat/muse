import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:muse/screens/home/artist/artisthome.dart';
import 'package:muse/screens/home/home.dart';

class UserManagement {
  directHomepage(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection('/users')
        .where('uid', isEqualTo: currentUser!.uid)
        .get()
        .then((snapshot) {
      if (snapshot.docs[0].exists) {
        if (snapshot.docs[0].data()['role'] == 'artist') {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ArtistHome()));
        }
        else{
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      }
    });
    ;
  }
}
