import 'package:flutter/material.dart';
import 'package:muse/screens/home/musicroom.dart';
import 'package:muse/tools/customfont.dart';
import 'package:muse/tools/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [BackgroundImage(image: AssetImage('lib/images/headset.jpg'),),
      Scaffold(
        backgroundColor: Colors.transparent,
        body:SingleChildScrollView(
          child: SafeArea(child: Column(
            children: [
              Container(
                height: 150,
                child: Center(
                  child: Text('Muse',
                  style: GoogleFonts.pacifico(fontSize:50,
                  fontStyle: FontStyle.italic,
                  color: Colors.white),
                  )),
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:40.0),
                  child: Column(
                    children: [
                      Column(
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        children: [Padding(
                          padding: const EdgeInsets.symmetric( vertical: 10),
                          child: Neumorph(
                            child: TextField(
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email or username',
                                hintStyle: mbodytext,
                                prefixIcon: Icon(Icons.mail,
                                color: Colors.purple[100],),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                            )),
                        ),
                          Padding(
                          padding: const EdgeInsets.symmetric( vertical: 10),
                          child: Neumorph(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextField(
                                textAlignVertical: TextAlignVertical.center,
                                //textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  hintStyle:mbodytext,
                                  prefixIcon: Icon(Icons.lock,
                                  color: Colors.purple[100],),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.done,
                                obscureText:true,
                                
                              ),
                            )),
                        ),
                        SizedBox(
                          child: InkWell(
                            onTap: () {
                              //move to registration page
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Create an account',
                              style: mbodytext,),
                            ),
                          ),
                        )],
                      ),
                    Column(
                children: [
                  SizedBox(
                    height:100,
                  ),
                  Container(
                  width: double.infinity,
                  decoration:BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadiusDirectional.circular(16)
                  ) ,
                child: TextButton(onPressed: () {
                  //login
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MusicRoom()));
                }, child: Text('Login',
                style: mbodytext),
                ),
                )],
              )],
                  ),
                ),
              ),
              
              
            ],
          )),
        ),
      ),],
    );
  }
}