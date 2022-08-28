import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:muse/services/addsongservice.dart';
import 'package:muse/tools/customfont.dart';
import 'package:path/path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../services/firebase_api.dart';
import '../../../tools/widgets.dart';

class AddSongs extends StatefulWidget {
  const AddSongs({Key? key}) : super(key: key);

  @override
  State<AddSongs> createState() => _AddSongsState();
}

class _AddSongsState extends State<AddSongs> {
  //stream of genres for dropdown menu
  final Stream<QuerySnapshot> _genreStream =
      FirebaseFirestore.instance.collection('genres').snapshots();
  SongService _songService = SongService();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  //controllers
  TextEditingController _songname = TextEditingController();
  TextEditingController _artistname = TextEditingController();

  UploadTask? task;
  UploadTask? imgtask;
  File? file;
  File? image;
  String? genre = '';
  String dropdownValue = 'Select Song Genre';
  String? sname = '';
  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No file selected';
    final imgfileName =
        image != null ? basename(image!.path) : 'No file selected';
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade300, Colors.black],
              stops: [0.01, 1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              'Add Song',
              style: TextStyle(color: Colors.amber),
            ),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Form(
                        key: _formkey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 20),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Neumorph(
                                    child: ListTile(
                                  title: TextFormField(
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Song name',
                                      hintStyle: mbodytext,
                                      prefixIcon: Icon(
                                        Icons.mail,
                                        color: Colors.purple[100],
                                      ),
                                    ),
                                    validator: (val) => val!.isEmpty
                                        ? 'song name required'
                                        : null,
                                    onChanged: (val) {
                                      //email string is assigned to val for validation process
                                      setState(() => sname = val);
                                    },
                                    controller: _songname,
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                  ),
                                )),
                              ),
                              StreamBuilder<QuerySnapshot>(
                                  stream: _genreStream,
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Text('Loading');
                                    } else {
                                      List<DropdownMenuItem<String?>>
                                          genreItems = [];
                                      for (int i = 0;
                                          i < snapshot.data!.docs.length;
                                          i++) {
                                        DocumentSnapshot snap =
                                            snapshot.data!.docs[i];
                                        genreItems.add(DropdownMenuItem(
                                          child: Text(snap['genre']),
                                          value: snap['genre'],
                                        ));
                                      }
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Text(
                                              'Song genre: ',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  backgroundColor:
                                                      Colors.purple.shade300),
                                            ),
                                          ),
                                          DropdownButton<String?>(
                                            items: genreItems,
                                            onChanged: (String? newvalue) {
                                              setState(() {
                                                genre = newvalue;
                                                print('genre selected');
                                              });
                                            },
                                            //value: genre,
                                            isExpanded: false,
                                            hint: const Text('Select genre'),
                                          )
                                        ],
                                      );
                                    }
                                  }),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.purple.shade300,
                                      borderRadius:
                                          BorderRadiusDirectional.circular(25)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: OutlinedButton(
                                      onPressed: () {
                                        // select file
                                        selectMusicFile();
                                      },
                                      child: Text('Select music file',
                                          style: mbodytext),
                                      style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          side: BorderSide(
                                              width: 2, color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  fileName,
                                  style: TextStyle(
                                    backgroundColor: Colors.lightBlue,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.purple.shade300,
                                      borderRadius:
                                          BorderRadiusDirectional.circular(25)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: OutlinedButton(
                                      onPressed: () {
                                        // select file
                                        selectImage();
                                      },
                                      child: Text('Select display image',
                                          style: mbodytext),
                                      style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          side: BorderSide(
                                              width: 2, color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  imgfileName,
                                  style: TextStyle(
                                    backgroundColor: Colors.lightBlue,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  //width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius:
                                          BorderRadiusDirectional.circular(25)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: OutlinedButton(
                                      onPressed: () {
                                        // upload song
                                        songTostorage();
                                        Fluttertoast.showToast(
                                            msg: 'Category added');
                                            print('we got em boys');
                                       // Navigator.pop(context);
                                      },
                                      child:
                                          Text('Upload File', style: mbodytext),
                                      style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          side: BorderSide(
                                              width: 2, color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              task != null
                                  ? showUploadprogress(task!)
                                  : Container(),
                              SizedBox(
                                height: 20,
                              ),
                              imgtask != null
                                  ? showUploadprogress(imgtask!)
                                  : Container(),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Future selectMusicFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.audio);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() => file = File(path));
    print('song selected');
  }

  Future selectImage() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final imagepath = result.files.single.path!;
    setState(() => image = File(imagepath));
    print('image selected');
  }

  Future songTostorage() async {
    if (_formkey.currentState!.validate()) {
      //upload song file to firebase storage
      if (file == null) return;
      final filename = basename(file!.path);
      final destination = 'tracks/$filename';
      task = FirebaseApi.uploadMusicFile(destination, file!);
      setState(() {});
      if (task == null) return;
      final snapshot = await task!.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();

      //upload image to firebase storage
      if (image == null) return;
      final imgfilename = basename(image!.path);
      final imgdestination = 'tracks/$imgfilename';
      imgtask = FirebaseApi.uploadFile(imgdestination, image!);
      setState(() {});
      if (imgtask == null) return;
      final imgsnapshot = await imgtask!.whenComplete(() {});
      final imgurlDownload = await imgsnapshot.ref.getDownloadURL();

      //test if it worked
      print('link: $urlDownload');
      print('link: $imgurlDownload');

      _songService.uploadSong(
          songName: _songname.text,
          genre: genre,
          song: urlDownload,
          thumbnail: imgurlDownload);
    }
  }

  Widget showUploadprogress(UploadTask task) {
    return StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percent = (progress * 100).toStringAsFixed(2);
            return Text('$percent %');
          } else {
            return Container();
          }
        });
  }
}
