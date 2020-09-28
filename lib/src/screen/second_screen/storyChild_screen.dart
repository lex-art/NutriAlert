import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StoryChild extends StatefulWidget {
  //nombre de la ruta
  static const String routName = "/story";
  String id;
  StoryChild(this.id);

  @override
  _StoryChildState createState() => _StoryChildState();
}

class _StoryChildState extends State<StoryChild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //color al botron de retroceso
          leading: BackButton(color: Colors.white),
          title: Text(
            "${widget.id}",
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
