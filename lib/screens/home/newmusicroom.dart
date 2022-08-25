// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:muse/screens/authenticate/intro.dart';
// import 'package:muse/tools/widgets.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class NewMusicRoom extends StatefulWidget {
//   const NewMusicRoom({Key? key}) : super(key: key);

//   @override
//   State<NewMusicRoom> createState() => _NewMusicRoomState();
// }

// class _NewMusicRoomState extends State<NewMusicRoom> {

//   final Stream<QuerySnapshot> _musicStream = FirebaseFirestore.instance.collection('tracks').snapshots();

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _musicStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
//         if(snapshot.hasError) {
//           return Text('Something went wrong');
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }
//         if (snapshot.hasData) {
//           return Stack(
//             children: snapshot.data!.docs.map((DocumentSnapshot document) {
//               Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
//             }).toList(),
//           )
//         }else{
//           return Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           )
//         }
//       });
//   }
// }