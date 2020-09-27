import 'package:flutter/material.dart';
import 'package:NutriAlert/src/models/register_model.dart';

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
        body: ListView.builder(
          //permite utilizar el modelo que tenemos ya creado enb loa clase chat model
          itemCount: recordsData.length, //tamaño de la lista
          itemBuilder: (context, index) => Column(
            children: <Widget>[
              Divider(
                //divisiones entre la lista
                height: 1.0,
                color: Colors.black26,
              ),
              //es como un item donde va el titulo y la info
              ListTile(
                leading: CircleAvatar(
                  child: Text(recordsData[index].name[0]),
                  backgroundColor: Theme.of(context).buttonColor,
                ),
                title: Column(
                  // mainAxisAlignment: MainAxisAlignment.start, //espacio entre los dos elementos del row
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(recordsData[index].name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0)),
                    Text(
                      "${recordsData[index].year} meses",
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
                    recordsData[index].proximaCita,
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                ),
                //cuando le da click lo lleva a otra pag
                onTap: () {},
              )
            ],
          ),
        ));
  }
}