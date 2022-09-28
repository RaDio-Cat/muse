import 'dart:async';
import 'dart:core';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:muse/screens/home/secondpm.dart';
import 'package:muse/tools/widgets.dart';
import 'package:web3dart/web3dart.dart' as web3;
import 'package:web3dart/crypto.dart';

class SmusicRoom extends StatefulWidget {
  final thumbnail;
  final songname;
  final song;
  final singer;
  final artistId;
  const SmusicRoom(
      {Key? key,
      required this.thumbnail,
      required this.songname,
      required this.song,
      required this.singer,
      required this.artistId})
      : super(key: key);

  @override
  State<SmusicRoom> createState() => _SmusicRoomState();
}

class _SmusicRoomState extends State<SmusicRoom> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  var apiUrl = "https://ropsten.infura.io/v3/39d2d450a3c44b9d85775471d60cd2e0";
  Client? httpClient;
  web3.Web3Client? ethClient;
  late final SpageManager _pageManager;

  @override
  void initState() {
    super.initState();
    _pageManager = SpageManager(selectedSong: widget.song);
    httpClient = Client();
    ethClient = web3.Web3Client(apiUrl, httpClient!);
    payArtist();
  }

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
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
          body: SingleChildScrollView(
            child: SafeArea(
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
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Column(
                            children: [
                              ValueListenableBuilder<ProgressBarState>(
                                valueListenable: _pageManager.progressNotifier,
                                builder: (_, value, __) {
                                  return ProgressBar(
                                    progress: value.current,
                                    buffered: value.buffered,
                                    total: value.total,
                                    timeLabelTextStyle: TextStyle(
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    onSeek: _pageManager.seek,
                                  );
                                },
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
                                ValueListenableBuilder<ButtonState>(
                                  valueListenable: _pageManager.buttonNotifier,
                                  builder: (_, value, __) {
                                    switch (value) {
                                      case ButtonState.loading:
                                        return Container(
                                          margin: const EdgeInsets.all(8.0),
                                          width: 32.0,
                                          height: 32.0,
                                          child:
                                              const CircularProgressIndicator(),
                                        );
                                      case ButtonState.paused:
                                        return IconButton(
                                          icon: const Icon(Icons.play_arrow),
                                          iconSize: 32.0,
                                          onPressed: _pageManager.play,
                                        );
                                      case ButtonState.playing:
                                        return IconButton(
                                          icon: const Icon(Icons.pause),
                                          iconSize: 32.0,
                                          onPressed: _pageManager.pause,
                                        );
                                    }
                                  },
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

  getCryptoAddy(String artistID) async {
    String cryptoAddy = '';
    await FirebaseFirestore.instance
        .collection('users')
        .doc(artistID)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        cryptoAddy = snapshot.data()!['cryptowallet address'];
        print(cryptoAddy);
      } else {
        print('Unable to get address');
      }
    });
    return cryptoAddy;
  }

  Future<String> retrievePrivateKey() async {
    String pKey = '';
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        pKey = snapshot.data()!['muse private key'];
        print('rpk: $pKey');
      } else {
        print('private key not found');
      }
    });
    return pKey;
  }

  Future<web3.DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString("assets/museabi.json");
    String contractAddress = "0xdffB63f76f69cf4Ff1736D170C109cFec88b8BBF";
    final contract = web3.DeployedContract(web3.ContractAbi.fromJson(abi, "muse_wallet"),
        web3.EthereumAddress.fromHex(contractAddress));
        return contract;
  }

  Future<List<dynamic>> query (String functionName, List<dynamic> args) async {
    final contract = await loadContract();
    //print("Checking Contract Address");
    //print('ADDRESS: ${contract.function}') ;
    final ethfunction = contract.function(functionName);
    final result = await ethClient!.call(contract: contract, function: ethfunction, params: args);
    return result;
  }

  Future<String> qr (String functionName, List<dynamic> args) async {
    
    var credentials = web3.EthPrivateKey.fromHex('ea00b21a02703e45bd9a8d531791bd0632d5db8748a53fed591e83b09aab3078');
    final contract = await loadContract();
    //print("Checking Contract Address");
    //print('ADDRESS: ${contract.function}') ;
    final ethfunction = contract.function(functionName);
    final result = await ethClient!.sendTransaction(credentials, web3.Transaction.callContract(contract: contract, function: ethfunction, parameters: args ),chainId: 3);
    return result;
  }

  Future<void> payArtist () async {
    web3. EthereumAddress artistAddress = web3.EthereumAddress.fromHex(await getCryptoAddy(widget.artistId));
     //EthereumAddress artistAdd = EthereumAddress.fromHex('0x28667Fe60e7CC7543F4012ac8f087d8585C831e4');
      var response = await qr('payArtist', [artistAddress]);
      print('response of contract $response');
    var resp = await query('balanceOf', []);
    print('balance of contract ${resp[0]}');
     
  }
}
