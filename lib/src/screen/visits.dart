import 'package:flutter/material.dart';


class Visits extends StatefulWidget {
   //nombre de la ruta
  static const String routName = "/visit";
  @override
  _VisitsState createState() => _VisitsState();
}

class _VisitsState extends State<Visits> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            //pone de color blanco a todos los iconos del appBar
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              "Visitas pendientes",
              style: TextStyle(color: Colors.white),
            )),
        );
  }
}