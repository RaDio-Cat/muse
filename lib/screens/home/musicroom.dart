import 'package:flutter/material.dart';
import 'package:muse/screens/authenticate/intro.dart';
import 'package:muse/tools/customfont.dart';
import 'package:muse/tools/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:audioplayers/audioplayers.dart';


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
  final audioPlayer = AudioPlayer();
  bool isPlaying = true;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState(){
    super.initState();

    setAudio();
    playSong();
    

    //Listen for song state
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
     });
    // audio duration
    audioPlayer.onDurationChanged.listen((newDuration) { 
      setState(() {
        duration = newDuration;
      });
    });
    //slider position monitoring
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  Future setAudio() async {
    audioPlayer.setSourceUrl(widget.song);
  }
  Future playSong()async{
    await audioPlayer.play(widget.song);
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(
          image: NetworkImage(widget.thumbnail),
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

                          Navigator.pop(context);
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
                        widget.songname,
                        style: TextStyle(color: Colors.deepPurpleAccent),
                      ),
                    ),
                  ],
                ),
                //image, artist and song name
                BackBox(child: Image.network(widget.thumbnail)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        widget.singer,
                        style: TextStyle(color: Colors.deepPurpleAccent),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:20.0),
                        child: Column(
                          children: [
                            Slider(
                            min: 0,
                            max: duration.inSeconds.toDouble(),
                            value: position.inSeconds.toDouble(),
                            onChanged: (value) async {
                              //control song position
                              final position = Duration(seconds: value.toInt());
                              await audioPlayer.seek(position);

                              await audioPlayer.resume();
                            }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Text('0:00',
                                // style: mbodytext,),
                                // Text('3:43',
                                // style: mbodytext,),
                                 Text(position.inMinutes.toString()),
                                Text(duration.inMinutes.toString()),
                              ],
                            ),
                          ],
                        ),
                      ),
                  //controls
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
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
                                onTap: () async{
                                  // pause and play song
                                  if (isPlaying){
                                    //pause
                                    await audioPlayer.pause();
                                  }else{
                                    //play
                                    await audioPlayer.resume();
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
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
