import 'package:NutriAlert/src/screen/nurtriAlert_app.dart';
import 'package:NutriAlert/src/screen/optionRecordChild/viewRecordChild.dart';
import 'package:NutriAlert/src/screen/optionRecordChild/updateRecordChildren.dart';
import 'package:NutriAlert/src/service/child_Service.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StoryChild extends StatefulWidget {
  //nombre de la ruta
  static const String routName = "/story";
  final String id;
  bool pantallaTest;
  StoryChild({this.id, this.pantallaTest});

  @override
  _StoryChildState createState() => _StoryChildState();
}

class _StoryChildState extends State<StoryChild> {
  ///---variables que se paran como parametros por si desea visualizar o actualiza registro -----------
  String nombre,
      apellido,
      cui,
      direccion,
      edadMeses,
      estado,
      fechaRegistro,
      genero,
      madre,
      nacimiento,
      noCasa,
      noCel,
      noSector,
      padre,
      pueblo;
//--------------------------------- metodo para obtener el registro del niño ------------------------
  void _getdocChild() async {
    final child = await ChildService().getRecordChild(widget.id);

    nombre = child.data()["nombres"];
    apellido = child.data()["apellidos"];
    cui = child.data()["cui"];
    direccion = child.data()["direccion"];
    edadMeses = child.data()["edadMeses"];
    estado = child.data()["estado"];
    fechaRegistro = child.data()["fechaRegistro"];
    genero = child.data()["genero"];
    madre = child.data()["madre"];
    nacimiento = child.data()["nacimiento"];
    noCasa = child.data()["noCasa"];
    noCel = child.data()["noCel"];
    noSector = child.data()["noSector"];
    padre = child.data()["padre"];
    pueblo = child.data()["pueblo"];
   // print(child.data());
  }

  @override
  void initState() {
    super.initState();
    _getdocChild();

    //_getStory();
    //_getStory();
  }

// -------------------------------- menu end drawer (superioor Izquierda) ---------------------
  Drawer getDrawer(BuildContext context) {
    //opciones
    ListTile getItem(Icon icon, String description, String route, String id) {
      return ListTile(
        leading: icon,
        title: Text(description),
        onTap: () {
          if (route == "verRegistro") {
            //-------- con el navigator pasamos parametros  -------------------
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewRecordChild(
                        nombre: nombre,
                        apellido: apellido,
                        cui: cui,
                        direccion: direccion,
                        edadMeses: edadMeses,
                        estado: estado,
                        fechaRegistro: fechaRegistro,
                        genero: genero,
                        madre: madre,
                        nacimiento: nacimiento,
                        noCasa: noCasa,
                        noCel: noCel,
                        noSector: noSector,
                        padre: padre,
                        pueblo: pueblo)));
          }
          if (route == "actualizar") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UpdateRegisterChildren(
                        id: widget.id,
                        nombre: nombre,
                        apellido: apellido,
                        cui: cui,
                        direccion: direccion,
                        edadMeses: edadMeses,
                        estado: estado,
                        fechaRegistro: fechaRegistro,
                        genero: genero,
                        madre: madre,
                        nacimiento: nacimiento,
                        noCasa: noCasa,
                        noCel: noCel,
                        noSector: noSector,
                        padre: padre,
                        pueblo: pueblo)));
          }
          if (route == "eliminar") {
            cuandoPresionaBoton(
                "¿Esta deguro de eliminar este registro? Se eliminará todos los datos del niño");
          }
        },
      );
    }

    //lista de opcions
    ListView getList() {
      return ListView(
        children: <Widget>[
          //header,
          Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Opciones",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )),
          getItem(Icon(Icons.remove_red_eye), "Ver datos del niño",
              "verRegistro", widget.id),
          getItem(Icon(Icons.edit), "Editar registro del niño", "actualizar",
              widget.id),
          getItem(Icon(Icons.delete), "Eliminar registro del niño", "eliminar",
              widget.id),
          //getItem(Icon(Icons.help_outline), "Ayuda", "/help"),
        ],
      );
    }

    return Drawer(
      child: getList(),
    );
  }

//---------------------------------- Para eliminar el registro -----------------------
  //metodo donde colocamos el resultado del alert
  Future<void> alertResultado(String action) async {
    if (action == "yes") {
      var resul = await ChildService()
          .deleteStoryChild(collectionName: 'niños', id: widget.id);

      if (resul.success) {
        var resul2 = await ChildService()
            .deleteChild(collectionName: 'niños', id: widget.id);
        if (resul2.success) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => NutriAlert()),
              (Route<dynamic> route) => false);
        }
      }
    }
    if (action == "no") {
      Navigator.pop(context);
      // Navigator.pushNamed(context, "/nutriAlert");
    }
  }

  //cuanbdo se presiona el boton se ejecuta essta funcion
  void cuandoPresionaBoton(String value) {
    //asi se crea un alert dialog classic esta en la documentacion, matarialcomponet hats a abajo
    AlertDialog dialog = AlertDialog(
      //contenido del dialog
      content: Text(value, style: TextStyle(color: Colors.redAccent),textAlign: TextAlign.center),
      //puede aplicarse varias acciones del dialog con actions y esta recibe una lista de widgets
      actions: <Widget>[
        //flat buton es un boton parecido al de raisebuton
        FlatButton(
            onPressed: () {
              alertResultado("yes");
            },
            child: Text("Si")),
        FlatButton(
            onPressed: () {
              alertResultado("no");
            },
            child: Text("No"))
      ],
    );
    //y debemos retornar un showDialog para que aparezaca
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }

//------------------------------ empieza el scafold para parte grafica de la pantalla ----------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //------ cuando se guarde el test y lo lleve alregistro, y cuando quiera retroceder, esete no lo lleve 
          // a la pantalla de evaluacion si no al menu principal
            leading: widget.pantallaTest
                ? IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => NutriAlert()),
                        (Route<dynamic> route) => false),
                  )
                : null,
            //pone de color blanco a todos los iconos del appBar
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              "Historial",
              style: TextStyle(color: Colors.white),
            )),
        endDrawer: getDrawer(context),
        body: SafeArea(
//------------------------ Empieza el stream donde escucha a la bd y renderizamos los datos en un page wview ------------
            child: (StreamBuilder(
                stream: ChildService().getChildStoryStream(widget.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return PageView(children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            DataTable(
                                //sortColumnIndex: 0,
                                columns: [
                                  DataColumn(
                                      label: Text("Fecha",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .accentColor))),
                                  DataColumn(
                                      label: Text("Edad",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .accentColor))),
                                  DataColumn(
                                      label: Text("Peso",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .accentColor))),
                                  DataColumn(
                                      label: Text("Talla",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .accentColor))),
                                ], rows: _getRow(snapshot.data.documents)),
                          ],
                        ),
                      ),
//----------------------------------------- Segunda Pantalla ------------------------------------
                      SingleChildScrollView(
                        child: DataTable(
                            //sortColumnIndex: 0,
                            columns: [
                              DataColumn(
                                  label: Text("Peso\nEdad",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).accentColor))),
                              DataColumn(
                                  label: Text("Estado",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).accentColor))),
                              DataColumn(
                                  label: Text("Long.\nTalla\nEdad",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).accentColor))),
                              DataColumn(
                                  label: Text("Estado",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).accentColor))),
                            ], rows: _getRow2(snapshot.data.documents)),
                      ),
//--------------------------- Tercera Pantalla --------------------------------
                      SingleChildScrollView(
                        child: DataTable(
                            //sortColumnIndex: 0,
                            columns: [
                              DataColumn(
                                  label: Text("Z\n0a2",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).accentColor))),
                              DataColumn(
                                  label: Text("Z\n2a5",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).accentColor))),
                              DataColumn(
                                  label: Text("Estado",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).accentColor))),
                              DataColumn(
                                  label: Text("Prox.\nCita",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).accentColor))),
                            ], rows: _getRow3(snapshot.data.documents)),
                      ),
                      SingleChildScrollView(
                        child: DataTable(
                            //sortColumnIndex: 0,
                            columns: [
                              DataColumn(
                                  label: Text("Tratamiento",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).accentColor))),
                            ], rows: _getRow4(snapshot.data.documents)),
                      )
                    ]);
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [Center(child: CircularProgressIndicator())],
                    );
                  }
                }))));
  }

//------------------------------- Mapeamos en una lista los datos que nnos devuelve el snapshot ------------------
  List<DataRow> _getRow(dynamic storys) {
    List<DataRow> storyChild = [];
    for (var story in storys) {
      storyChild.add(buildDataRow(story.data()["fecha"], story.data()["edad"],
          story.data()["peso"], story.data()["longitud"]));
    }
    return storyChild;
  }

//-------------------------------- Llenamos los datos para cada fial de la PRIMERA página ----------------------
  DataRow buildDataRow(String fecha, String edad, String peso, String talla) {
    return DataRow(cells: [
      DataCell(Text(fecha)),
      DataCell(Text("$edad Meses")),
      DataCell(Text("$peso kg")),
      DataCell(Text("$talla cm")),
      //DataRow(cells: [DataCell(Text("help")),
    ]);
  }

//------------------------------- Mapeamos en una lista los datos que nnos devuelve el snapshot ------------------
  List<DataRow> _getRow2(dynamic storys) {
    List<DataRow> storyChild = [];
    for (var story in storys) {
      storyChild.add(buildDataRow2(
        story.data()["pesoEdad"],
        story.data()["estadoPeso"],
        story.data()["longTallaEdad"],
        story.data()["estadoLongTalla"],
      ));
    }
    return storyChild;
  }

  //-------------------------------- Llenamos los datos para cada fial de la SEGUNDA página ----------------------
  //z2  = puntuacion z de 0 a dos años y z5 puntutaicon Z de 3 a 5 años
  DataRow buildDataRow2(
    String pesoEdad,
    String estadoPeso,
    String longTallaEdad,
    String estadoLongTalla,
  ) {
    return DataRow(cells: [
      DataCell(Text(pesoEdad)),
      DataCell(Text(estadoPeso,style: TextStyle(
          color: estadoPeso == "Peso Normal" ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),)),
      DataCell(Text(longTallaEdad)),
      DataCell(Text(estadoLongTalla, style: TextStyle(
          color: estadoLongTalla == "Long/talla Normal" ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),),),

      //DataRow(cells: [DataCell(Text("help")),
    ]);
  }

//------------------------------- Mapeamos en una lista los datos que nnos devuelve el snapshot ------------------
  List<DataRow> _getRow3(dynamic storys) {
    List<DataRow> storyChild = [];
    for (var story in storys) {
      storyChild.add(buildDataRow3(
          story.data()["z2ages"],
          story.data()["z5ages"],
          story.data()["estadoZScore"],
          story.data()["proximaCita"]));
    }
    return storyChild;
  }

//-------------------------------- Llenamos los datos para cada fial de la TERCERA página ----------------------
  DataRow buildDataRow3(
      String z0a2, String z2a5, String estado, String proxCita) {
    return DataRow(cells: [
      DataCell(Text(z0a2)),
      DataCell(Text(z2a5)),
      DataCell(Text(
        estado,
        style: TextStyle(
          color: estado == "Normal" ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      )),
      DataCell(Text(proxCita)),
      //DataRow(cells: [DataCell(Text("help")),
    ]);
  }

  //------------------------------- Mapeamos en una lista los datos que nnos devuelve el snapshot ------------------
  List<DataRow> _getRow4(dynamic storys) {
    List<DataRow> storyChild = [];
    for (var story in storys) {
      storyChild.add(buildDataRow4(story.data()["tratamiento"]));
    }
    return storyChild;
  }

//-------------------------------- Llenamos los datos para cada fial de la CUARTA página ----------------------
  DataRow buildDataRow4(String tratamiento) {
    return DataRow(cells: [
      DataCell(Text(tratamiento)),
    ]);
  }

  //obtener datos normal
  //void _getStory() async {
  //  final historial = await ChildService().getStory(widget.id);
  //  // ignore: deprecated_member_use
  //  for (var histo in historial.documents) {
  //    print(histo.data());
  //  }
  //}

  //obtener datos via stream prueba
  //void _getStory() async {
  //  await for (var snapshot in ChildService().getChildStoryStream(widget.id)) {
  //    for (var histo in snapshot.docs) {
  //      print(histo.data());
  //    }
  //  }
  //}
}

/*
SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DataTable(
              //sortColumnIndex: 0,
              columns: [
                DataColumn(
                    label: Text(
                  "Nombre",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor),
                )),
                DataColumn(
                    label: Text("Apellido",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).accentColor)))
              ], rows: [
            buildDataRow(), 
          ]),
        ],
      )),
 */
/*
Flexible(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DataTable(
                            //sortColumnIndex: 0,
                            columns: [
                              DataColumn(
                                  label: Text("Fecha",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).accentColor))),
                              DataColumn(
                                  label: Text("Edad",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).accentColor))),
                              DataColumn(
                                  label: Text("Peso",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).accentColor))),
                              DataColumn(
                                  label: Text("Talla",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).accentColor))),
                            ], rows:  _getRow(snapshot.data.documents)
                        ),
                      ],
                    ));
 */
