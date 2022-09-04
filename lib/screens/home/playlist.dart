import 'package:flutter/material.dart';

class PlaylistLayout extends StatefulWidget {
  const PlaylistLayout({Key? key}) : super(key: key);

  @override
  State<PlaylistLayout> createState() => _PlaylistLayoutState();
}

class _PlaylistLayoutState extends State<PlaylistLayout> {
  @override
  Widget build(BuildContext context) {
    return 
      Stack(
      children: [
        Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.deepPurpleAccent, Colors.black],
          stops: [0.01, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,),
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Playlist Name',
        style: TextStyle(color: Colors. amber),),
      ),)
      ],
    );
    
  }
}