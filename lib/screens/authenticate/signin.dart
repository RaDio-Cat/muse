import 'package:flutter/material.dart';
import 'package:muse/tools/widgets.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [BackgroundImage(image: AssetImage('lib/images/headset.jpg'),)],
    );
  }
}