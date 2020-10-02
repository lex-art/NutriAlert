import 'package:NutriAlert/src/screen/second_screen/storyChild_screen.dart';
import 'package:NutriAlert/src/service/child_Service.dart';
import 'package:flutter/material.dart';

class RecordChild extends StatefulWidget {
  //nombre de la ruta
  static const String routName = "/record";
  @override
  _RecordChildState createState() => _RecordChildState();
}

class _RecordChildState extends State<RecordChild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            //pone de color blanco a todos los iconos del appBar
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              "Registro de niños",
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
                  })
            ],
          ),
        ));
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
        estado: child.data()["estado"],
      ));
    }
    return childItem;
  }
}

class ChildItem extends StatelessWidget {
  final String nombres, edad, apellidos, estado, id;
  ChildItem({
    this.id,
    this.nombres,
    this.apellidos,
    this.edad,
    this.estado,
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
                estado,
                style: TextStyle(
                    color: estado == "Grave"
                        ? Colors.red
                        : estado == "Moderado" ? Colors.orange : Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0),
              ),
            ),
            //cuando le da click lo lleva a otra pag
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute<Null>(builder: (BuildContext context)  => StoryChild(id)));
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

/*
 style: TextStyle(
                        color: recordsData[index].state == "Grave"
                            ? Colors.red
                            : recordsData[index].state == "Medio"
                                ? Colors.orange
                                : Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),*/
