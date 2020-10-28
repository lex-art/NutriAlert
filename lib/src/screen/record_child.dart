import 'package:NutriAlert/src/screen/second_screen/storyChild_screen.dart';
import 'package:NutriAlert/src/service/child_Service.dart';
import 'package:flutter/material.dart';

String filter; //variable de filtro para la busqueta de registros

class RecordChild extends StatefulWidget {
  //nombre de la ruta
  static const String routName = "/record";
  @override
  _RecordChildState createState() => _RecordChildState();
}

class _RecordChildState extends State<RecordChild> {
  TextEditingController _searchController = new TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        filter = _searchController.text;
      });
    });
  }

//---------------- para limpiar lo que tiene en memoria el text fielf -----------------
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

//-------- funcion para iniciar la busqueda en el appBarr setteando la varible _isSearching -----
  void startSearching() {
    setState(() {
      _isSearching = true;
    });
  }

  //-------- funcion para parar la busqueda en el appBarr setteando la varible _isSearching -----
  void onSearchCancel() {
    setState(() {
      _isSearching = false;
    });
  }

//-------- funcion para buscar dentro de la listTile segun lo que capture el text fiel  -------
  void onSearch() {
    _searchController.addListener(() {
      setState(() {
        filter = _searchController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _isSearching
            ? getAppBarSearching(onSearchCancel, onSearch, _searchController)
            : getAppBarNotSearching("Registro de niños", startSearching),
        //AppBar(
        //    //pone de color blanco a todos los iconos del appBar
        //    iconTheme: IconThemeData(color: Colors.white),
        //    title: Text(
        //      "Registro de niños",
        //      style: TextStyle(color: Colors.white),
        //    )),
        body: SafeArea(
          child: Column(
            children: [
              //-------------- Text fiel de buscqueda --------------
              // _busqueda(),
              StreamBuilder(
                  stream: ChildService().getChildStreamRegistros(),
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
    String nombreCompleto = nombres + " " +apellidos;
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 8),
      child: Column(
        children: [
          //----------- primero vemos si no usa el filtro de busqueda------------
          filter == null || filter == ""
              ? ListTile(
                  leading: CircleAvatar(
                    child: Text(nombres[0].toUpperCase()),
                    backgroundColor: Theme.of(context).buttonColor,
                  ),
                  title: Column(
                    // mainAxisAlignment: MainAxisAlignment.start, //espacio entre los dos elementos del row
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(nombreCompleto,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0)),
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
                          color: estado == "Normal" ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0),
                    ),
                  ),
                  //cuando le da click lo lleva a otra pag
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute<Null>(
                        builder: (BuildContext context) => StoryChild(
                              id: id,
                              pantallaTest: false,
                            )));
                  },
                )
//---------------------- buscamos en base al nombre  o el apellido lo que el textField de busqueda nos pasa  ----------------
              : nombreCompleto.toLowerCase().contains(filter.toLowerCase()) 
                  ? ListTile(
                      leading: CircleAvatar(
                        child: Text(nombres[0].toUpperCase()),
                        backgroundColor: Theme.of(context).buttonColor,
                      ),
                      title: Column(
                        // mainAxisAlignment: MainAxisAlignment.start, //espacio entre los dos elementos del row
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(nombreCompleto,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0)),
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
                              color: estado == "Normal"
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0),
                        ),
                      ),
                      //cuando le da click lo lleva a otra pag
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute<Null>(
                            builder: (BuildContext context) => StoryChild(
                                  id: id,
                                  pantallaTest: false,
                                )));
                      },
                    )
                  : Container(),
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

//------------------------ funcion para un app bar si no activa la busqueda -------------
Widget getAppBarNotSearching(String title, Function startSearchFunction) {
  return AppBar(
    //pone de color blanco a todos los iconos del appBar
    iconTheme: IconThemeData(color: Colors.white),
    title: Text(
      title,
      style: TextStyle(color: Colors.white),
    ),
    actions: <Widget>[
      IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            startSearchFunction();
          }),
    ],
  );
}

//------------------------ funcion para un app bar si activa la busqueda -------------
Widget getAppBarSearching(Function cancelSearch, Function searching,
    TextEditingController searchController) {
  return AppBar(
    automaticallyImplyLeading: false,
    iconTheme: IconThemeData(color: Colors.white),
    leading: IconButton(
        icon: Icon(Icons.cancel),
        onPressed: () {
          cancelSearch();
        }),
    title: Padding(
      padding: const EdgeInsets.only(bottom: 5, right: 10),
      child: TextField(
        controller: searchController,
        onEditingComplete: () {
          searching();
        },
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        autofocus: true,
        decoration: InputDecoration(
          hintText: "Buscar registro",
          hintStyle: TextStyle(color: Colors.white),
          focusColor: Colors.white,
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        ),
      ),
    ),
  );
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
