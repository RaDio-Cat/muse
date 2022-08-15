import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muse/screens/authenticate/artregister.dart';
import 'package:muse/screens/authenticate/register.dart';
import 'package:muse/screens/authenticate/signin.dart';
import 'package:muse/tools/customfont.dart';
import 'package:muse/tools/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muse/tools/widgets.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [BackgroundImage(image: AssetImage('lib/images/billie.jpeg')),
      Scaffold(
        backgroundColor:Colors.transparent,
        body:SingleChildScrollView(
          child: SafeArea(child: Column(
            children: [
              Container(
                  height: 150,
                  child: Center(
                    child: Text("What's good?",
                    style: GoogleFonts.pacifico(fontSize:50,
                    fontStyle: FontStyle.italic,
                    color: Colors.white),
                    )),
                ),
                SizedBox(
                        height:300,
                      ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:[
                      Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        decoration:BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadiusDirectional.circular(25)
                        ) ,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:5.0),
                        child: OutlinedButton(onPressed: () {
                          // go to login page
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
                        }, child: Text('Streamer Sign in',
                        style: mbodytext),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          side: BorderSide(width:2, color: Colors.white)
                        ),
                        ),
                      ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        decoration:BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadiusDirectional.circular(25)
                        ) ,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:5.0),
                        child: OutlinedButton(onPressed: () {
                          //go to registration page
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                        }, child: Text('Streamer Sign up',
                        style: mbodytext),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          side: BorderSide(width:2, color: Colors.white)
                        ),
                        ),
                      ),
                      ),
                    ),Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        decoration:BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadiusDirectional.circular(25)
                        ) ,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:5.0),
                        child: OutlinedButton(onPressed: () {
                          //go to artist registration page
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ArtistRegister()));
                        }, child: Text('Artist Sign Up',
                        style: mbodytext),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          side: BorderSide(width:2, color: Colors.white)
                        ),
                        ),
                      ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        decoration:BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadiusDirectional.circular(25)
                        ) ,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:5.0),
                        child: OutlinedButton(onPressed: () {
                          //go to artist registration page
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ArtistRegister()));
                        }, child: Text('Artist Sign In',
                        style: mbodytext),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          side: BorderSide(width:2, color: Colors.white)
                        ),
                        ),
                      ),
                      ),
                    ),
                    ],
                  ),
                )
            ],
          )),
        ),
      )],
    );
  }
}