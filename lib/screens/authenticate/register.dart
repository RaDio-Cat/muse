import 'package:flutter/material.dart';
import 'package:muse/screens/authenticate/signin.dart';
import 'package:muse/screens/home/musicroom.dart';
import 'package:muse/services/adduserfxn.dart';
import 'package:muse/tools/customfont.dart';
import 'package:muse/tools/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/usermanagement.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //create firebase auth instance variable
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  //Text editing controller will be used for authentication purposes
  TextEditingController _email = TextEditingController();
  TextEditingController _wallet = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  //String values will be used for validation process
  String email = "";
  String username = "";
  String password = "";
  String wallet = "";
  //radio button selection
  String role = '';

  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
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
                                        Icons.mail,
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
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Neumorph(
                                    child: ListTile(
                                  title: TextFormField(
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'MetaMask Address',
                                      hintStyle: mbodytext,
                                      prefixIcon: Icon(
                                        Icons.wallet,
                                        color: Colors.purple[100],
                                      ),
                                    ),
                                    validator: (val) =>
                                        val!.isEmpty ? 'Email required' : null,
                                    onChanged: (val) {
                                      //email string is assigned to val for validation process
                                      setState(() => wallet = val);
                                    },
                                    controller: _wallet,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                  ),
                                )),
                              ),
                              Row(
                                children: [
                                  Radio(value:'streamer', groupValue: role, onChanged: (value){
                                    setState(() {
                                      role = value as String;
                                    } );
                                  },
                                  fillColor: MaterialStateProperty.resolveWith(getColor)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Register as a streamer',
                                  style: mbodytext,)
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(value: 'artist'
                                  , groupValue: role, onChanged: (value){
                                    setState(() {
                                      role = value as String;
                                    } );
                                  },
                                  fillColor: MaterialStateProperty.resolveWith(getColor)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Register as an artist',
                                  style: mbodytext,)
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
                                      await UserRegistrationService(
                                        uid: userCredential.user!.uid,
                                      ).createUser(
                                        _username.text,
                                        _email.text,
                                        role,
                                        _wallet.text,
                                      );
                                      print('data added');
                                      //navigate to hompepage
                                       await UserManagement().directHomepage(context);
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
                            )
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