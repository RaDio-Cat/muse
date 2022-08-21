import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muse/screens/authenticate/intro.dart';
import 'package:muse/screens/authenticate/register.dart';
import 'package:muse/screens/authenticate/signin.dart';
import 'package:muse/screens/home/artist/addsongs.dart';
import 'package:muse/screens/home/artist/artisthome.dart';
import 'package:muse/screens/home/musicroom.dart';
import 'package:muse/screens/home/playlist.dart';
import 'package:muse/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     // darkTheme:ThemeData(
       // colorSchemeSeed: Colors.purple,
        //brightness: Brightness.light,
        //useMaterial3: true,
        
      //),
      theme: ThemeData(
        textTheme:GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
        colorSchemeSeed: Colors.purple,
        brightness:Brightness.light,
        appBarTheme: AppBarTheme(
          color: Colors.purple
        ),
        iconTheme: IconThemeData(color: Colors.purple),
      ),
      home: IntroPage(),
    );
  }
}


class ThemeTest extends StatelessWidget {
  const ThemeTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Con Te Partiro'),
      ),
      body: Center(
        child:Text('Andromeda'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){},
      ),
    );
  }
}


