import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:muse/screens/home/home.dart';
import 'package:web3dart/web3dart.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  final Stream<QuerySnapshot> _walletStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  Client? httpClient;
  Web3Client? ethClient;
  final metaAddress = '0xF91456cA9218ACab1a216a3C8DCfA0E40da8c8f3';
  @override
  Widget build(BuildContext context) {
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
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  print('user logged out');
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
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
                   decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical:20.0),
                            child: Text('Balance',
                            style: TextStyle(fontSize: 30),),
                          )
                        ],
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
}
