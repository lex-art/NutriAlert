import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  //ruta pagina principal
  static const String routName = "/help";
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            //color al botron de retroceso
            leading: BackButton(color: Colors.white),
            title: Text(
              "Ayuda",
              style: TextStyle(color: Colors.white),
            )),
      
    );
  }
}