import 'package:flutter/material.dart';

class AppFlatButton extends StatelessWidget {
  //parametros del boton
  final VoidCallback onPressed;
  final String nombre;
  final MaterialColor color;
  final Icon icon;
  //constructor
  AppFlatButton({
    this.onPressed,
    this.nombre,
    this.color,
    this.icon
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
          color: color,
          borderRadius: BorderRadius.circular(50.0),
          //tamaño del boton
          child: SizedBox(
            height: 35.0,
            width: 140,
            child: FlatButton.icon(
              color: color,
              icon: icon,
              label: Text(
                nombre,
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              onPressed: onPressed,
            ),
          )),
    );
  }
}
