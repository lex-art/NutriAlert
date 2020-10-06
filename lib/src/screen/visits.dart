import 'package:NutriAlert/src/service/child_Service.dart';
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
      body: SafeArea(
          child: Column(
        children: [
          StreamBuilder(
              stream: ChildService().getChildStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Flexible(
                      child: ListView(
                    children: _getChildItem(snapshot.data.documents),
                  ));
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Center(child: CircularProgressIndicator())],
                  );
                }
              }),
        ],
      )),
    );
  }

  //mapeamos los datos del stream
  List<ChildItem> _getChildItem(dynamic childs) {
    List<ChildItem> childItem = [];
    for (var child in childs) {
      childItem.add(ChildItem(
        id: child.id,
        nombres: child.data()["nombres"],
        apellidos: child.data()["apellidos"],
        edad: child.data()["edadMeses"],
        proxCita: child.data()["proxCita"],
      ));
    }
    return childItem;
  }
}

class ChildItem extends StatelessWidget {
  final String nombres, edad, apellidos, proxCita, id;
  ChildItem({
    this.id,
    this.nombres,
    this.apellidos,
    this.edad,
    this.proxCita,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 8),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text(nombres[0].toUpperCase()),
              backgroundColor: Theme.of(context).buttonColor,
            ),
            title: Column(
              // mainAxisAlignment: MainAxisAlignment.start, //espacio entre los dos elementos del row
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(nombres + " " + apellidos,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                Text(
                  "$edad Meses",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 14.0),
                ),
              ],
            ),
            subtitle: Container(
              padding: const EdgeInsets.only(top: 0.0),
              child: Text(
                proxCita,
                style: TextStyle(
                    color: proxCita == "Grave"
                        ? Colors.red
                        : proxCita == "Moderado" ? Colors.orange : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0),
              ),
            ),
            //cuando le da click lo lleva a otra pag
            onTap: () {
///------------------------- Mandamos los datos a la pantalla de -----------------------


            },
          ),
          Divider(
            height: 1.0,
            //thickness: 1,
            color: Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}
