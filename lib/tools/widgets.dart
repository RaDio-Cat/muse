import 'package:flutter/material.dart';

class BackBox extends StatelessWidget {
  final child;
  const BackBox({Key? key,required this.child }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: 350,
      padding: EdgeInsets.all(12),
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

class BackgroundImage extends StatelessWidget {
  final image;
  const BackgroundImage({
    Key? key, required this.image
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(shaderCallback: (bounds) => LinearGradient(
      colors: [Colors.black,Colors.black12],
      begin: Alignment.bottomCenter,
      end: Alignment.center,).createShader(bounds), 
      blendMode: BlendMode.darken, 
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: image,
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken)),
        ),
      ),);
  }
}