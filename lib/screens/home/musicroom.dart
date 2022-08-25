import 'package:flutter/material.dart';
import 'package:muse/screens/authenticate/intro.dart';
import 'package:muse/tools/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MusicRoom extends StatefulWidget {
  final thumbnail;
  final songname;
  final song;
  final singer;
  const MusicRoom(
      {Key? key,
      required this.thumbnail,
      required this.songname,
      required this.song,
      required this.singer})
      : super(key: key);

  @override
  State<MusicRoom> createState() => _MusicRoomState();
}

class _MusicRoomState extends State<MusicRoom> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(
          image: AssetImage('lib/images/humble.jpg'),
        ),
        Scaffold(
          backgroundColor: Colors.transparent.withOpacity(0.5),
          body: SafeArea(
            child: Column(
              children: [
                //appbar stuff
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 70,
                      child: InkWell(
                        child: const Icon(Icons.arrow_back_ios_new_outlined),
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          //go back to previous page
                          await FirebaseAuth.instance.signOut();
                          print('user logged out');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => IntroPage()));
                          // Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 70,
                      child: InkWell(
                        child: Icon(Icons.favorite_border),
                        highlightColor: Colors.transparent,
                        onTap: () {
                          //add to favourites playlist
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'H u m b l e',
                        style: TextStyle(color: Colors.deepPurpleAccent),
                      ),
                    ),
                  ],
                ),
                //image, artist and song name
                BackBox(child: Image.asset('lib/images/humble.jpg')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Kendrick Lamar',
                        style: TextStyle(color: Colors.deepPurpleAccent),
                      ),
                    ),
                  ],
                ),
                //controls
                SizedBox(
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipOval(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              // previous song
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.skip_previous),
                            ),
                          ),
                        ),
                      ),
                      ClipOval(
                        child: Material(
                          //color: Colors.blue,
                          child: InkWell(
                            onTap: () {
                              // pause and play song
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Icon(Icons.pause),
                            ),
                          ),
                        ),
                      ),
                      ClipOval(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              // next song
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.skip_next),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: Container(
            color: Colors.black,
            child: Row(
              children: [
                Expanded(
                    child: MaterialButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.volume_down,
                    color: Colors.white,
                  ),
                )),
                Expanded(
                    child: MaterialButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.playlist_add,
                    color: Colors.white,
                  ),
                )),
                Expanded(
                    child: MaterialButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                )),
              ],
            ),
          ),
        )
      ],
    );
  }
}
