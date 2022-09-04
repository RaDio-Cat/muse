import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

import '../../../tools/widgets.dart';

class ArtistSongs extends StatefulWidget {
  const ArtistSongs({Key? key}) : super(key: key);

  @override
  State<ArtistSongs> createState() => _ArtistSongsState();
}

class _ArtistSongsState extends State<ArtistSongs> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _artistSongsStream = FirebaseFirestore.instance
      .collection('tracks')
      .where('royalty holder', isEqualTo: currentUser!.uid)
      .snapshots();
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurpleAccent, Colors.black],
              stops: [0.01, 1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              'Manage Songs',
              style: TextStyle(color: Colors.amber),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<QuerySnapshot>(
        stream: _artistSongsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
            return Text('Trouble retrieving songs');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
              ),
            );
            }
            if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            // String royal = data['royalty holder'];

            // final singer = UserManagement().retrieveArtistName(royalty: royal).toString();
            return Card(
              color: Colors.grey[200],
              child: ListTile(
                title: Text(data['name']),
                // subtitle: FutureBuilder(
                //     future: retrieveArtistName(royalty: royal),
                //     builder: (context, snapshot) {
                //       if (snapshot.connectionState ==
                //           ConnectionState.done) {
                //         return Text(artistname);
                //       } else {
                //         return Text('Unknown Artist');
                //       }
                //     }),
                leading: Image.network(data['image']),
                onTap: () {
                  //open music room and send necessary data
                 
                },
              ),
            );
              }).toList(),
            );
            } else {
            return Center(
              child: CircularProgressIndicator(),
            );
            }
        }),
          ),
        )
      ],
    );
  }
}
