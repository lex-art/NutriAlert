import 'package:NutriAlert/src/screen/test_screen/test_nutritional.dart';
import 'package:NutriAlert/src/service/child_Service.dart';
import 'package:flutter/material.dart';

String filter; //variable de filtro para la busqueta de registros

class Visits extends StatefulWidget {
  //nombre de la ruta
  static const String routName = "/visit";
  @override
  _VisitsState createState() => _VisitsState();
}

class _VisitsState extends State<Visits> {
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
            : getAppBarNotSearching("Visitas pendientes", startSearching),
     // AppBar(
     //     //pone de color blanco a todos los iconos del appBar
     //     iconTheme: IconThemeData(color: Colors.white),
     //     title: Text(
     //       "Visitas pendientes",
     //       style: TextStyle(color: Colors.white),
     //     )),
      body: SafeArea(
          child: Column(
        children: [
          //-------------- Text fiel de buscqueda --------------

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
        genero: child.data()["genero"],
      ));
    }
    return childItem;
  } 
}

class ChildItem extends StatelessWidget {
  final String nombres, edad, apellidos, proxCita, id, genero;
  ChildItem(
      {this.id,
      this.nombres,
      this.apellidos,
      this.edad,
      this.proxCita,
      this.genero});
  @override
  Widget build(BuildContext context) {
    String nombreCompleto = nombres + " " +apellidos;
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 8),
      child: Column(
        children: [
          //----------- primero vemos si no unas el filtro de busqueda------------
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
                      proxCita,
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0),
                    ),
                  ),
                  //cuando le da click lo lleva a otra pag
                  onTap: () {
//------------------------- Mandamos los datos a la pantalla de -----------------------
                    Navigator.of(context).push(MaterialPageRoute<Null>(
                        builder: (BuildContext context) => TestNutritional(
                              id: id,
                              nombre: nombres,
                              edad: edad,
                              genero: genero,
                            )));
                  },
                )
              : nombreCompleto.toLowerCase().contains(filter.toLowerCase()) ? 
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
                          proxCita,
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0),
                        ),
                      ),
                      //cuando le da click lo lleva a otra pag
                      onTap: () {
//------------------------- Mandamos los datos a la pantalla de -----------------------
                        Navigator.of(context).push(MaterialPageRoute<Null>(
                            builder: (BuildContext context) => TestNutritional(
                                  id: id,
                                  nombre: nombres,
                                  edad: edad,
                                  genero: genero,
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
