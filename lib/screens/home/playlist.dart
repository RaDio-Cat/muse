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
      Scaffold(backgroundColor: Colors.purple[900],
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.deepPurple[800],
        title: Text('Playlist Name',
        style: TextStyle(color: Colors. amber),),
      ),);
    
  }
}