import 'dart:math';
import 'package:web3dart/crypto.dart';
import 'package:flutter/material.dart';
import 'package:muse/screens/authenticate/signin.dart';
import 'package:muse/screens/home/musicroom.dart';
import 'package:muse/services/adduserfxn.dart';
import 'package:muse/tools/customfont.dart';
import 'package:muse/tools/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import '../../services/usermanagement.dart';


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var apiUrl = "http://127.0.0.1:7545";
  var httpClient = Client();
  //create firebase auth instance variable
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  //Text editing controller will be used for authentication purposes
  TextEditingController _email = TextEditingController();
  TextEditingController _cryptowallet = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  //String values will be used for validation process
  String email = "";
  String username = "";
  String password = "";

  //radio button selection
  String role = '';
  String trueForm = '';

  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    var ethClient = Web3Client(apiUrl, httpClient);
    return Stack(
      children: [
        BackgroundImage(
          image: AssetImage('lib/images/headset.jpg'),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
                child: Column(
              children: [
                Container(
                  height: 150,
                  child: Center(
                      child: Text(
                    'Muse',
                    style: GoogleFonts.pacifico(
                        fontSize: 50,
                        fontStyle: FontStyle.italic,
                        color: Colors.white),
                  )),
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.end,
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
                                      hintText: 'Username',
                                      hintStyle: mbodytext,
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.purple[100],
                                      ),
                                    ),
                                    validator: (val) => val!.isEmpty
                                        ? 'username required'
                                        : null,
                                    onChanged: (val) {
                                      //email string is assigned to val for validation process
                                      setState(() => username = val);
                                    },
                                    controller: _username,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                  ),
                                )),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Neumorph(
                                    child: ListTile(
                                  title: TextFormField(
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Email',
                                      hintStyle: mbodytext,
                                      prefixIcon: Icon(
                                        Icons.mail,
                                        color: Colors.purple[100],
                                      ),
                                    ),
                                    validator: (val) =>
                                        val!.isEmpty ? 'Email required' : null,
                                    onChanged: (val) {
                                      //email string is assigned to val for validation process
                                      setState(() => email = val);
                                    },
                                    controller: _email,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                  ),
                                )),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Neumorph(
                                    child: ListTile(
                                  title: TextFormField(
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Password',
                                      hintStyle: mbodytext,
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Colors.purple[100],
                                      ),
                                    ),
                                    validator: (val) {
                                      //make sure text field is not empty
                                      if (val == null || val.isEmpty) {
                                        return 'Password required';
                                      }
                                      if (val.length < 6) {
                                        return "You're gonna need a longer password";
                                      }
                                    },
                                    onChanged: (val) {
                                      //password string is assigned to val for validation process
                                      setState(() => password = val);
                                    },
                                    controller: _password,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    obscureText: hidePassword,
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          hidePassword = false;
                                        });
                                      },
                                      icon: Icon(Icons.remove_red_eye)),
                                )),
                              ),
                              role == 'artist' ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Neumorph(
                                    child: ListTile(
                                  title: TextFormField(
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'CryptoWallet Address',
                                      hintStyle: mbodytext,
                                      prefixIcon: Icon(
                                        Icons.mail,
                                        color: Colors.purple[100],
                                      ),
                                    ),
                                    // validator: (val) =>
                                    //     val!.isEmpty ? 'Email required' : null,
                                    // onChanged: (val) {
                                    //   //email string is assigned to val for validation process
                                    //   setState(() => email = val);
                                    // },
                                    controller: _cryptowallet,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                  ),
                                )),
                              ): Text(''),
                              Row(
                                children: [
                                  Radio(
                                      value: 'streamer',
                                      groupValue: role,
                                      onChanged: (value) {
                                        setState(() {
                                          role = value as String;
                                        });
                                      },
                                      fillColor:
                                          MaterialStateProperty.resolveWith(
                                              getColor)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Register as a streamer',
                                    style: mbodytext,
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: 'artist',
                                      groupValue: role,
                                      onChanged: (value) {
                                        setState(() {
                                          role = value as String;
                                        });
                                      },
                                      fillColor:
                                          MaterialStateProperty.resolveWith(
                                              getColor)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Register as an artist',
                                    style: mbodytext,
                                  )
                                ],
                              ),
                              SizedBox(
                                child: InkWell(
                                  onTap: () {
                                    //move to login page
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignIn()));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Already have an account?',
                                      style: mbodytext,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 100,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius:
                                      BorderRadiusDirectional.circular(16)),
                              child: TextButton(
                                onPressed: () async {
                                  //create an account
                                  if (_formKey.currentState!.validate()) {
                                    print('validation is complete');
                                    try {
                                      UserCredential userCredential = await auth
                                          .createUserWithEmailAndPassword(
                                              email: _email.text,
                                              password: _password.text);
                                      print('user created');
                                      //create private key for user wallet
                                      if (role == 'streamer'){
                                        trueForm = revealPrivateKey();
                                        await UserRegistrationService(
                                        uid: userCredential.user!.uid,
                                      ).createUser(
                                       name : _username.text,
                                       email: _email.text,
                                        role: role,
                                        wallet: trueForm,
                                      );
                                    }else{
                                      await UserRegistrationService(
                                        uid: userCredential.user!.uid,
                                      ).createUser(
                                       name : _username.text,
                                       email: _email.text,
                                        role: role,
                                        address: _cryptowallet.text,
                                      );
                                    } 
                                      print('data added');
                                      //navigate to hompepage
                                      await UserManagement()
                                          .directHomepage(context);
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             MusicRoom()));
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'weak-password') {
                                        print(
                                            'The password provided is too weak.');
                                      } else if (e.code ==
                                          'email-already-in-use') {
                                        print(
                                            'The account already exists for that email.');
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                    ;
                                  }
                                },
                                child: Text('Next', style: mbodytext),
                              ),
                            ),
                            Container(
                                child: TextButton(
                                    onPressed: ()async {
                                      print('ppd: $revealPrivateKey()');
                                      var credentials =
                                          EthPrivateKey.fromHex(revealPrivateKey());

                                      print('got key');
                                      final address = credentials.address;
                                      print(address.hexEip55);
                                       String disBal =(await ethClient
                                          .getBalance(address))
                                          .toString();
                                          print(disBal);
                                    },
                                    child: Text('Debug')))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
          ),
        ),
      ],
    );
  }
}

Color getColor(Set<MaterialState> states) {
  return Colors.white;
}

String revealPrivateKey() {
  var randomNumber = Random.secure();
  print(randomNumber);
  EthPrivateKey key = EthPrivateKey.createRandom(randomNumber);
  print(key);
   String s = bytesToHex(key.privateKey);
  if (s.length > 64) {
    s = s.substring(2);
  }
  print('gen: $s');
  return s;
}
