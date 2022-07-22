import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        body:SafeArea(child: Column(
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
          ],
        )),
      )],
    );
  }
}