import 'package:flutter/material.dart';
import 'package:muse/screens/home/home.dart';
import 'package:muse/screens/home/musicroom.dart';
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MusicRoom();
  }
}