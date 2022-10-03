import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:muse/screens/home/home.dart';
import 'package:web3dart/web3dart.dart' as web3;
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
  web3.Web3Client? ethClient;
  // final metaAddress = '0xF91456cA9218ACab1a216a3C8DCfA0E40da8c8f3';
  String privatKey = '';
  web3.EtherAmount disBal = web3.EtherAmount.zero();
  String wallAddress = '';
  String balance = '';
  String txnHash = '';
  String contractAddress = '0xdffB63f76f69cf4Ff1736D170C109cFec88b8BBF';

  @override
  void initState() {
    httpClient = Client();
    ethClient = web3.Web3Client(apiUrl, httpClient!);

    super.initState();
  }

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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
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
                                  return Text(balance, style: TextStyle(fontSize: 20),);
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
                                  child: Text('Copy private key',
                                      style: mbodytext),
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
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusDirectional.circular(12)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Directions',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )
                            ],
                          ),
                          Container(
                            // width: 500,
                            // height: 55,
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              "*Tap on the 'Copy private key' to copy your muse wallet private key. \n\n*Open Metamask and import the muse wallet using the private key you copied. \n\n*Populate the muse wallet with ether. The subscription fee is 1ETH. \n\n*Once the muse transaction is a success you will see the balance reflected above. \n\n*You can now pay the subscription fee by taping 'Pay Subscription'. \n\n*Enjoy",
                              overflow: TextOverflow.clip,
                              style: TextStyle(fontSize: 15,
                              wordSpacing: 3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      //width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadiusDirectional.circular(25)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: OutlinedButton(
                          onPressed: () {
                            // pay subscription
                            payUpBro();

                            // Navigator.pop(context);
                          },
                          child: Text('Pay Subscription', style: mbodytext),
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              side: BorderSide(width: 2, color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                ],
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
    String pKey = await retrievePrivateKey();
    privatKey = pKey;
    print('gab: $pKey');
    var credentials = web3.EthPrivateKey.fromHex(pKey);

    final address = credentials.address;
    await ethClient!.getBalance(address).then((value) {
      print('balance recieved');
      disBal = value;
      print(disBal.getValueInUnit(web3.EtherUnit.ether));
      balance = disBal.getValueInUnit(web3.EtherUnit.ether).toString();
    });

    return balance;
  }

  Future<web3.DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString("assets/museabi.json");
    String contractAddress = "0xdffB63f76f69cf4Ff1736D170C109cFec88b8BBF";
    final contract = web3.DeployedContract(
        web3.ContractAbi.fromJson(abi, "muse_wallet"),
        web3.EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    final contract = await loadContract();
    final ethfunction = contract.function(functionName);
    final result = await ethClient!
        .call(contract: contract, function: ethfunction, params: args);
    return result;
  }

  Future<String> payUpBro() async {
    var bigAmount = web3.EtherAmount.fromUnitAndValue(web3.EtherUnit.ether, 1);
    var gasPriceu =
        web3.EtherAmount.fromUnitAndValue(web3.EtherUnit.wei, 20000000000);
    var response = await submit("payup", [], bigAmount, gasPriceu);
    //change subscription status
    changeStatus();

    print('payment made');
    txnHash = response;
    print(txnHash);
    if (response != '') {
      Fluttertoast.showToast(msg: txnHash);
    }
    return response;
  }

  Future<String> submit(String functionName, List<dynamic> args,
      web3.EtherAmount? amount, web3.EtherAmount gasPrice) async {
    web3.EthPrivateKey creds = web3.EthPrivateKey.fromHex(privatKey);
    web3.DeployedContract contract = await loadContract();
    final ethfunction = contract.function(functionName);
    final result = await ethClient!.sendTransaction(
      creds,
      web3.Transaction.callContract(
          contract: contract,
          function: ethfunction,
          parameters: args,
          value: amount,
          gasPrice: gasPrice),
      chainId: 3,
    );

    return result;
  }

  changeStatus() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .update({'subscribed': true})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
    print('subscription payed');
  }
}
