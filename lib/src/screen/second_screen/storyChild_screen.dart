import 'package:flutter/material.dart';
import 'package:NutriAlert/src/models/storyChild_model.dart';

class StoryChild extends StatefulWidget {
  //nombre de la ruta
  static const String routName = "/story";
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
              "Historial del niño",
              style: TextStyle(color: Colors.white),
            )),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 8, left: 8, top: 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, //espacio entre los dos elementos del row
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Mes: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0)),
                      Text("Peso: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0)),
                      Text("Altura: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0)),
                      Text("Fecha: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0)),
                      Text("Estado: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0)),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
                child: ListView.builder(
                  //permite utilizar el modelo que tenemos ya creado enb loa clase chat model
                  itemCount: storyData.length, //tamaño de la lista
                  itemBuilder: (context, index) => Column(
                    children: <Widget>[
                      //es como un item donde va el titulo y la info

                      ListTile(
                        contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, //espacio entre los dos elementos del row
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(storyData[index].meses,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0)),
                            Text(storyData[index].peso,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0)),
                            Text(storyData[index].altura,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0)),
                            Text(storyData[index].fecha,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0)),
                            Text(storyData[index].estado,
                                style: TextStyle(
                                    color: storyData[index].estado == "Grave"
                                        ? Colors.red
                                        : storyData[index].estado == "Medio"
                                            ? Colors.orange
                                            : Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0)),
                          ],
                        ),

                        //cuando le da click lo lleva a otra pag
                        onTap: () {},
                      ),
                      Divider(
                        //divisiones entre la lista
                        height: 1.0,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
