import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:muse/screens/home/artist/artisthome.dart';
import 'package:muse/screens/home/home.dart';

class UserManagement {
  
  User? currentUser = FirebaseAuth.instance.currentUser;
  directHomepage(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection('/users')
        .doc(currentUser!.uid)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        if (snapshot.data()!['role'] == 'artist') {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>  ArtistHome()));
        } else {
          Navigator.of(context).push( MaterialPageRoute(
              builder: (BuildContext context) =>  Home()));
        }
      } else {
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }
    });
  }

  checkSubscriptionStatus() async {
    bool? stats;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        stats = snapshot.data()!['subscribed'];
      } else {
        print('unable to check subscription status');
      }
    });
    return stats;
  }
}
