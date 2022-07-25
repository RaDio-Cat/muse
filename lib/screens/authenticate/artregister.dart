import 'package:flutter/material.dart';
import 'package:muse/tools/customfont.dart';
import 'package:muse/tools/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ArtistRegister extends StatefulWidget {
  const ArtistRegister({Key? key}) : super(key: key);

  @override
  State<ArtistRegister> createState() => _ArtistRegisterState();
}

class _ArtistRegisterState extends State<ArtistRegister> {
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
                  child: Text('So you wanna be a muse artist?',
                  style: GoogleFonts.pacifico(fontSize:30,
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
                                hintText: 'Email ',
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
                            child: TextField(
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Username',
                                hintStyle: mbodytext,
                                prefixIcon: Icon(Icons.person,
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
                              //move to login page
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Already have an account?',
                              style: mbodytext,),
                            ),
                          ),
                        )],
                      ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height:100,
                  ),
                  Container(
                  decoration:BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadiusDirectional.circular(16)
                  ) ,
                child: TextButton(onPressed: () {
                  //create an account
                }, child: Text('Next',
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