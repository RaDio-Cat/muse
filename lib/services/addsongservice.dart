

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SongService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? currentUser = FirebaseAuth.instance.currentUser; 
  

  //add songs method
  Future<void>uploadSong({
    required String songName,
    required String? genre,
    required String song,
    required String thumbnail,
  }){
    String? artistName =currentUser!.uid;

    return _firestore.collection('tracks').add({
      'name': songName,
      'royalty holder': artistName,
      'genre': genre,
      'song': song,
      'image': thumbnail,
    });
  }

  
}