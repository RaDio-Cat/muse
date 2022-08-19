import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:muse/screens/home/artist/addsongs.dart';
import 'package:muse/tools/customfont.dart';

class ArtistHome extends StatefulWidget {
  const ArtistHome({Key? key}) : super(key: key);

  @override
  State<ArtistHome> createState() => _ArtistHomeState();
}

class _ArtistHomeState extends State<ArtistHome> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.purple.shade300, Colors.black],
          stops: [0.01, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,),
          ),
        ),
        Scaffold(extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Home',
        style: TextStyle(color: Colors. amber),),
      ),
      body:SingleChildScrollView(
        child:SafeArea(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                children:[
                  Card(elevation: 50,
                  shadowColor: Colors.amberAccent,
                  
                  child: InkWell(
                    onTap:() {
                      //show list of uploads
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: GridTile(child: Image.asset('lib/images/billie.jpeg'),
                      footer: Container(
                        height: 50,
                        color: Colors.transparent,
                        child: Center(
                          child: Text('Manage Songs',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),),
                    ),
                  ),
                ),
                Card(elevation: 50,
                  shadowColor: Colors.amberAccent,
                  
                  child: InkWell(
                    onTap:() {
                      //show list of uploads
                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddSongs()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: GridTile(child: Image.asset('lib/images/billie.jpeg'),
                      footer: Container(
                        height: 50,
                        color: Colors.transparent,
                        child: Center(
                          child: Text('Upload Songs',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),),
                    ),
                  ),
                ),Card(elevation: 50,
                  shadowColor: Colors.amberAccent,
                  
                  child: InkWell(
                    onTap:() {
                      //show list of uploads
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: GridTile(child: Image.asset('lib/images/billie.jpeg'),
                      footer: Container(
                        height: 50,
                        color: Colors.transparent,
                        child: Center(
                          child: Text('Wallet',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),),
                    ),
                  ),
                ),
                Card(elevation: 50,
                  shadowColor: Colors.amberAccent,
                  
                  child: InkWell(
                    onTap:() {
                      //show list of uploads
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: GridTile(child: Image.asset('lib/images/billie.jpeg'),
                      footer: Container(
                        height: 50,
                        color: Colors.transparent,
                        child: Center(
                          child: Text('Profile',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),),
                    ),
                  ),
                ),
                Card(elevation: 50,
                  shadowColor: Colors.amberAccent,
                  
                  child: InkWell(
                    onTap:() {
                      //show list of uploads
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: GridTile(child: Image.asset('lib/images/billie.jpeg'),
                      footer: Container(
                        height: 50,
                        color: Colors.transparent,
                        child: Center(
                          child: Text('Manage Songs',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),),
                    ),
                  ),
                )
                ] 
              ),
            )
          ],),
        ),
      ),)
      ],
    );
  }
}

// Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: Text('Playlist Name',
//         style: TextStyle(color: Colors. amber),),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(colors: [Colors.purple.shade300, Colors.black],
//           stops: [0.01, 1],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,),
//         ),
//       ),);