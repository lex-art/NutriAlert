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
  StoryChild(
    this.id,
  );

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
    print(child.data());
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
  void alertResultado(String action) {
    if (action == "yes") {
      ChildService().deleteChild("niños", widget.id);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NutriAlert()));
    }
    if (action == "no") {
      Navigator.pop(context);
      // Navigator.pushNamed(context, "/nutriAlert");
    }
    print("Tu seleccion es  $action");
  }

  //cuanbdo se presiona el boton se ejecuta essta funcion
  void cuandoPresionaBoton(String value) {
    //asi se crea un alert dialog classic esta en la documentacion, matarialcomponet hats a abajo
    AlertDialog dialog = AlertDialog(
      //contenido del dialog
      content: Text(value, style: TextStyle(color: Colors.redAccent)),
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
                                  DataColumn(
                                      label: Text("PesoEdad",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .accentColor))),
                                  DataColumn(
                                      label: Text("PesoAltura",
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
                                  label: Text("Peso/Edad",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .accentColor))),
                              DataColumn(
                                  label: Text("Talla/Edad",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .accentColor))),
                              DataColumn(
                                  label: Text("Z \n0-2",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .accentColor))),
                              DataColumn(
                                  label: Text("Z \n3-5",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .accentColor))),
                            ], rows: _getRow2(snapshot.data.documents)),
                      ),
//--------------------------- Tercera Pantalla --------------------------------
                       SingleChildScrollView(
                          child: DataTable(
                                //sortColumnIndex: 0,
                                columns: [
                                  DataColumn(
                                      label: Text("Tratamiento",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .accentColor))),
                                  DataColumn(
                                      label: Text("Estado",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .accentColor))),
                                  DataColumn(
                                      label: Text("Prox. Cita",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .accentColor))),
                                ], rows: _getRow3(snapshot.data.documents)),
                      

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
      DataCell(Text("$talla cm")),
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
          story.data()["longitudEdad"],
          story.data()["z2ages"],
          story.data()["z5ages"]));
    }
    return storyChild;
  }

  //-------------------------------- Llenamos los datos para cada fial de la SEGUNDA página ----------------------
  //z2  = puntuacion z de 0 a dos años y z5 puntutaicon Z de 3 a 5 años
  DataRow buildDataRow2(
      String pesoEdad, String tallaEedad, String z2, String z5) {
    return DataRow(cells: [
      DataCell(Text(pesoEdad)),
      DataCell(Text(tallaEedad)),
      DataCell(Text(z2)),
      DataCell(Text(z5)),
      //DataRow(cells: [DataCell(Text("help")),
    ]);
  }

//------------------------------- Mapeamos en una lista los datos que nnos devuelve el snapshot ------------------
  List<DataRow> _getRow3(dynamic storys) {
    List<DataRow> storyChild = [];
    for (var story in storys) {
      storyChild.add(buildDataRow3(story.data()["tratamiento"],
          story.data()["estado"], story.data()["proximaCita"]));
    }
    return storyChild;
  }

//-------------------------------- Llenamos los datos para cada fial de la TERCERA página ----------------------
  DataRow buildDataRow3(String trata, String estado, String proxCita) {
    return DataRow(cells: [
      DataCell(Text(trata)),
      DataCell(Text(
        estado,
        style: TextStyle(
          color: estado == "Grave"
              ? Colors.red
              : estado == "Moderado" ? Colors.orange : Colors.green,
          fontWeight: FontWeight.bold,
        ),
      )),
      DataCell(Text(proxCita)),
      //DataRow(cells: [DataCell(Text("help")),
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
