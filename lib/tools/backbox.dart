import 'package:flutter/material.dart';

class BackBox extends StatelessWidget {
  final child;
  const BackBox({Key? key,required this.child }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: child,),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(
            color: Colors.purple.shade300,
            blurRadius: 15,
            offset: Offset(5,5) 
          ),
          BoxShadow(
            color: Colors.purple.shade300,
            blurRadius: 15,
            offset: Offset(-5,-5) 
          )
          ]
        ),);
  }
}