import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  //parametros del boton
  final VoidCallback onPressed;
  final String nombre;
  final MaterialAccentColor color;
  //constructor
  AppButton({
    this.onPressed,
    this.nombre,
    this.color,
 
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Material(
          color: color,
          borderRadius: BorderRadius.circular(50.0),
          
          //sombra
          //elevation: 8.0,
          //tamaño del boton
          child: SizedBox(
            
            height: 35.0,
            width: 150,
            child: FlatButton(
              onPressed: onPressed,
              child: Text(
                nombre,
                style: TextStyle(color: Colors.white),
              ),
            ),
          )),
    );
  }
}
