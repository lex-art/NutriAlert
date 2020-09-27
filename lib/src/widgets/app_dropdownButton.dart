import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppDropdowButton extends StatefulWidget {
  List<String> menu;
  String select;

  AppDropdowButton({this.select, this.menu});

  @override
  _AppDropdowButtonState createState() => _AppDropdowButtonState();
}

class _AppDropdowButtonState extends State<AppDropdowButton> {
 
  //String tipo;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black12,
      //elevation: 0,
      borderRadius: BorderRadius.circular(50.0),
      child: Container(
        padding: EdgeInsets.all(10),
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton(
              //mapeamos la lista, para poder usarla
              items: widget.menu.map((String val) {
                return DropdownMenuItem(
                  value: val,
                  child: Text(val),
                );
              }).toList(),
              onChanged: (_value) {
                setState(() {
                  var tipo = _value;
                  return tipo;
                });
              },
              hint: Text(
                widget.select,
              ),
              elevation: 5,
            ),
          ],
        ),
      ),
    );
  }
}
