import 'package:flutter/material.dart';

class CardMenu extends StatelessWidget {
  final Icon icon;
  final String text;
  final VoidCallback onPressed;
  const CardMenu(
      {Key key, @required this.icon, this.text, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).accentColor,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Material(
              color: Color(0xff006CD9),
              borderRadius: BorderRadius.circular(10.0),
              //sombra
              elevation: 8.0,
              //tamaño del boton
              child: SizedBox(
                height: 70.0,
                width: 70.0,
                child: FlatButton(
                    onPressed: onPressed,
                    padding: EdgeInsets.all(0.0),
                    child: icon),
              )),
          SizedBox(
            height: 10,
          ),
          Text(
            this.text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.normal),
          )
        ])),
      ),
    );
  }
}
