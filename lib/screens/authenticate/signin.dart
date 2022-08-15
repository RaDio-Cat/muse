import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muse/screens/authenticate/register.dart';
import 'package:muse/screens/home/musicroom.dart';
import 'package:muse/tools/customfont.dart';
import 'package:muse/tools/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  String email = "";
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  //Text editing controller will be used for authentication purposes
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  //String values will be used for validation process
  String email = "";
  String password = "";

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
                                        //password length validation
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
                                    textInputAction: TextInputAction.done,
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
                              SizedBox(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Register()));
                                    //move to registration page
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Create an account',
                                      style: mbodytext,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 100,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius:
                                      BorderRadiusDirectional.circular(16)),
                              child: TextButton(
                                onPressed: () async {
                                  //login
                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      UserCredential userCredential =
                                          await FirebaseAuth.instance
                                              .signInWithEmailAndPassword(
                                                  email: _email.text,
                                                  password: _password.text);
                                      //go to home page
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MusicRoom()));
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'user not found') {
                                        print('No user has this email.');
                                      } else if (e.code == 'wrong-password') {
                                        print('password invalid');
                                      }
                                    }
                                  }
                                  ;
                                },
                                child: Text('Login', style: mbodytext),
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
