import 'package:flutter/material.dart';
import 'package:muse/tools/backbox.dart';

class MusicRoom extends StatefulWidget {
  const MusicRoom({Key? key}) : super(key: key);

  @override
  State<MusicRoom> createState() => _MusicRoomState();
}

class _MusicRoomState extends State<MusicRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[900],
      body: SafeArea(
        child: Column(children: [
          //appbar stuff
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 70,
                width: 70,
                child: InkWell(child: const Icon(Icons.arrow_back_ios_new_outlined),
                highlightColor: Colors.transparent,
                onTap: (){
                  //go back to previous page
                },),
              ),
              SizedBox(
                height: 70,
                width: 70,
                child: InkWell(child: Icon(Icons.favorite_border),
                highlightColor: Colors.green,
                onTap: (){
                  //go back to previous page
                },),
              )
            ],
          )
          //image, artist and song name
      
          //controls
        ],),
      ),
    );
  }
}