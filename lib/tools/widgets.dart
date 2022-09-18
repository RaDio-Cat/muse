import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:muse/screens/home/musicroom.dart';
import 'package:muse/screens/home/newmusicroom.dart';
import 'package:muse/services/usermanagement.dart';
import 'dart:math';

class BackBox extends StatelessWidget {
  final child;
  const BackBox({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: 350,
      padding: EdgeInsets.all(12),
      child: Center(
        child: child,
      ),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.purple.shade300,
                blurRadius: 15,
                offset: Offset(5, 5)),
            BoxShadow(
                color: Colors.purple.shade300,
                blurRadius: 15,
                offset: Offset(-5, -5))
          ]),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  final image;
  const BackgroundImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [Colors.black, Colors.black12],
        begin: Alignment.bottomCenter,
        end: Alignment.center,
      ).createShader(bounds),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: image,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken)),
        ),
      ),
    );
  }
}

class Neumorph extends StatelessWidget {
  final child;
  const Neumorph({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.purple.shade300,
                blurRadius: 15,
                offset: Offset(5, 5)),
            BoxShadow(
                color: Colors.purple.shade300,
                blurRadius: 15,
                offset: Offset(-5, -5))
          ]),
    );
  }
}

class SongList extends StatefulWidget {
  const SongList({Key? key}) : super(key: key);

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  String artistname = '';
  bool status = false;
  User? currentUser = FirebaseAuth.instance.currentUser;
  final Stream<QuerySnapshot> _songStream =
      FirebaseFirestore.instance.collection('tracks').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _songStream,
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
                String royal = data['royalty holder'];
                List<DocumentSnapshot> currentPlaylist = [];
                for (int i = 0; i < snapshot.data!.docs.length; i++) {
                  DocumentSnapshot snap = snapshot.data!.docs[i];
                  currentPlaylist.add(snap);
                }
                // final singer = UserManagement().retrieveArtistName(royalty: royal).toString();
                return Card(
                  color: Colors.grey[200],
                  child: MyCustomListTile(
                    title: data['name'],
                    subtitle: FutureBuilder(
                        future: retrieveArtistName(royalty: royal),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Text(artistname);
                          } else {
                            return Text('Unknown Artist');
                          }
                        }),
                    leading: data['image'],
                    onTap: () async {
                      //open music room and send necessary data
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => NewMusicRoom(
                      //             selectedPlaylist: currentPlaylist)));
                      status = await checkSubscriptionStatus();
                      if (status){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MusicRoom(
                                thumbnail:data['image'],
                                songname:data['name'],
                                song: data['song'],
                                singer:artistname,
                                  )));
                      }else{
                        Fluttertoast.showToast(msg: 'Subscription Unpaid');
                      }
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
        });
  }

  retrieveArtistName({required String royalty}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(royalty)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        artistname = snapshot.data()!['username'];
        return artistname;
      } else {
        return null;
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

class MyCustomListTile extends StatelessWidget {
  final VoidCallback onTap;
  final String leading;
  final String title;
  final Widget subtitle;
  const MyCustomListTile(
      {Key? key,
      required this.onTap,
      required this.leading,
      required this.title,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(leading),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  subtitle,
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Genre extends StatelessWidget {
  final String genreCaption;
  const Genre({required this.genreCaption, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          //Go to category
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => new GenreList(title: genreCaption)));
        },
        child: Container(
          decoration: BoxDecoration(
              color:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.black)),
          width: 140.0,
          child: ListTile(
            title: Center(
              child: Text(
                genreCaption,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GenreScroll extends StatefulWidget {
  const GenreScroll({Key? key}) : super(key: key);

  @override
  State<GenreScroll> createState() => _GenreScrollState();
}

class _GenreScrollState extends State<GenreScroll> {
  final Stream<QuerySnapshot> _genreScrollStream =
      FirebaseFirestore.instance.collection('genres').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _genreScrollStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('An error occured');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return Container(
              height: 100.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Genre(genreCaption: data['genre']);
                }).toList(),
              ),
            );
          } else {
            return Text('Check Internet Connection');
          }
        });
  }
}

class GenreList extends StatefulWidget {
  final title;
  const GenreList({Key? key, required this.title}) : super(key: key);

  @override
  State<GenreList> createState() => _GenreListState();
}

class _GenreListState extends State<GenreList> {
  String artistname = '';

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _songStream = FirebaseFirestore.instance
        .collection('tracks')
        .where('genre', isEqualTo: widget.title)
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
                widget.title,
                style: TextStyle(color: Colors.amber),
              ),
            ),
            body: StreamBuilder<QuerySnapshot>(
                stream: _songStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        String royal = data['royalty holder'];
                        List<DocumentSnapshot> currentPlaylist = [];
                        for (int i = 0; i < snapshot.data!.docs.length; i++) {
                          DocumentSnapshot snap = snapshot.data!.docs[i];
                          currentPlaylist.add(snap);
                        }
                        // final singer = UserManagement().retrieveArtistName(royalty: royal).toString();
                        return Card(
                          color: Colors.grey[200],
                          child: MyCustomListTile(
                            title: data['name'],
                            subtitle: FutureBuilder(
                                future: retrieveArtistName(royalty: royal),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Text(artistname);
                                  } else {
                                    return Text('Unknown Artist');
                                  }
                                }),
                            leading: data['image'],
                            onTap: () {
                              //open music room and send necessary data
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MusicRoom(
                                            singer: artistname,
                                            song: data['song'],
                                            songname: data['name'],
                                            thumbnail: data['image'],
                                          )));
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
                }))
      ],
    );
  }

  retrieveArtistName({required String royalty}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(royalty)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        artistname = snapshot.data()!['username'];
        return artistname;
      } else {
        return null;
      }
    });
  }
}
