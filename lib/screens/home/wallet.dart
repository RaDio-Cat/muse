import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:muse/screens/home/home.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3dart/crypto.dart';
import 'package:clipboard/clipboard.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../tools/customfont.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  final Stream<QuerySnapshot> _walletStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  var apiUrl = "https://ropsten.infura.io/v3/39d2d450a3c44b9d85775471d60cd2e0";
  Client? httpClient;
  // Web3Client? ethClient;
  // final metaAddress = '0xF91456cA9218ACab1a216a3C8DCfA0E40da8c8f3';
  String privatKey = '';
  String disBal = '';
  String wallAddress = '';
  String staticKey =
      '2dc30b5f18ae9d6c79cc3aae2a072c198bf0c7e0b9e0c52bd9ee1e66e27721b9';

  @override
  void initState() {
    super.initState();

    httpClient = Client();
  }

  @override
  Widget build(BuildContext context) {
    // var ethClient = Web3Client(apiUrl, httpClient!);
    // var credentials = EthPrivateKey.fromHex('3b94d0493278e8149f52f79f8d3c8dcba3f610ce4d8bc88f74dad5ede1552127');
    // EtherAmount balance = ethClient.getBalance(credentials.address) as EtherAmount;
    // String display_bal = balance.getValueInUnit(EtherUnit.ether).toString();
    // print(display_bal);

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
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios)),
            backgroundColor: Colors.transparent,
            title: Text(
              'Wallet',
              style: TextStyle(color: Colors.amber),
            ),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Text(
                              'Balance',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                        ],
                      ),
                      FutureBuilder(
                          future: getAccBalance(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Text(disBal);
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          //width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius:
                                  BorderRadiusDirectional.circular(25)),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: OutlinedButton(
                              onPressed: () {
                                // upload song
                                FlutterClipboard.copy(privatKey)
                                    .then((value) => print('copied'));
                                ;
                                Fluttertoast.showToast(
                                    msg: 'Copied to clipboard');
                                // Navigator.pop(context);
                               },
                              child: Text('Copy private key', style: mbodytext),
                              style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  side: BorderSide(
                                      width: 2, color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
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

  getAccBalance() async {
    var ethClient = Web3Client(apiUrl, httpClient!);
    String pKey = await retrievePrivateKey();
    print('gab: $pKey');
    var credentials = EthPrivateKey.fromHex(pKey);
    // var credentials = EthereumAddress.fromHex(privKey);
    print('got key');
    final address = credentials.address;
    final musekey =(hexToBytes(pKey));
    //privatKey = musekey;
    print(privatKey);
    wallAddress = address.hexEip55;
    disBal = (await ethClient.getBalance(address)).toString();
    print(disBal);
    return disBal;

    // EtherAmount balance = await ethClient.getBalance(credentials.address) ;
    // print('got balance');
    //  displayBal = balance.getValueInUnit(EtherUnit.ether).toStringAsFixed(2);
    //  print('balance assigned');
    // return displayBal;
  }
}

//'3b94d0493278e8149f52f79f8d3c8dcba3f610ce4d8bc88f74dad5ede1552127'

