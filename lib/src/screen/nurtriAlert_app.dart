import 'package:NutriAlert/src/service/authentication.dart';
import 'package:NutriAlert/src/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:NutriAlert/src/widgets/app_cardMenu.dart';

import 'login_screen.dart';

class NutriAlert extends StatefulWidget {
  //ruta pagina principal
  static const String routName = "/nutriAlert";

  @override
  _NutriAlertState createState() => _NutriAlertState();
}

class _NutriAlertState extends State<NutriAlert> {
  //guardamos el usuario que nos llega desde firebase, para poder crear una especie de sesion en la app
  var loggedInUser;
  bool admin = false;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    //como lo fijimos firenbase trabaj con progra asyncrona y por eso se usa await y async
    var user = await Authentication().getCurrentUser(); //obtenemos el usaurio
    //le pasamos el usuriuo que trajimos de firebase y la asignamos la loggedInUdser
    if (user != null) {
      loggedInUser = user;
      final usuarios = await UserService().getUser();
      for (var usuario in usuarios.docs) {
        //print("-----------------------------------------${usuario.get("rol")}");
        //verificamos que sea el mismo usuario
        if (usuario.id == loggedInUser.uid) {
          //si es el mismo usuairo, ahora vemos que rol tiene
          if (usuario.get("rol") == "Administrador") {
            //por ultimo lo redirigimos a la pagina que quiere
            admin = true;
            setState(() {
              getDrawer(context);
            });
            break;
          }
        }
      }
    }
  }

  //menu end drawer
  Drawer getDrawer(BuildContext context) {
    //info de la aplición
    var info = AboutListTile(
      child: Text("Información de la Apliccación"),
      applicationName: "Nutri Alert",
      applicationIcon: Image.asset(
        'images/isotipo2.png',
        width: 50.0,
      ),
      applicationVersion: "1.0.0",
      icon: Icon(Icons.info),
    );
    //opciones
    ListTile getItem(Icon icon, String description, String route) {
      return ListTile(
        leading: icon,
        title: Text(description),
        onTap: () {
          if (route == "salir") {
            Authentication().singOut();
            //cerramos todas las pantallas abiertas de la app
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (Route<dynamic> route) => false);
          } else {
            Navigator.pushNamed(context, route);
          }
        },
      );
    }

    //lista de opcions para uduarios administradores
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

          getItem(Icon(Icons.edit), "Editar Perfil", "/edit"),
          getItem(Icon(Icons.person), "Usuarios", "/listUser"),
          getItem(Icon(Icons.person_add), "Crear usuario", "/createUser"),
          getItem(Icon(Icons.help_outline), "Ayuda", "/help"),
          getItem(Icon(Icons.exit_to_app), "Cerrar sesión", "salir"),
          info,
        ],
      );
    }

    //lista de opcions para uduarios normales
    ListView getList2() {
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

          getItem(Icon(Icons.edit), "Editar Perfil", "/edit"),
          getItem(Icon(Icons.help_outline), "Ayuda", "/help"),
          getItem(Icon(Icons.exit_to_app), "Cerrar sesión", "salir"),
          info,
        ],
      );
    }

    return Drawer(
      child: admin == true ? getList() : getList2(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: AppBar(
          //color al botron de retroceso
          //leading: BackButton(color: Colors.white),
          title: Text(
            "Bienvenido",
          ),
          //pone de color blanco a todos los iconos del appBar
          iconTheme: IconThemeData(color: Colors.white),
          //Quita el boton de retroceso en la app
          automaticallyImplyLeading: false,
        ),
        endDrawer: getDrawer(context),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                //imagen de portada
                Container(
                  child: Image.asset("images/girls.jpg"),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //logo nutri alert
                      Image.asset(
                        "images/logomenu.png",
                        width: 150.0,
                      ),
                      Text(
                        "Combatiendo la desnutrición",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w200),
                      )
                    ],
                  ),
                ),
                //primeros dos botones
                Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //-------------------- Opciones del menú principal ------------
                        _testNutritional(),
                        _registerChildren(),
                      ],
                    )),
                //Botones de abajo
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //-------------------- Opciones del menú principal ------------
                    _visits(),
                    _registerChild(),
                  ],
                )),
              ],
            ),
          ),
        ));
  }

  //botones del menu principal
  Widget _testNutritional() {
    return CardMenu(
      icon: Icon(
        Icons.straighten,
        color: Colors.white,
        size: 55,
      ),
      text: "Evaluar",
      onPressed: () {
        Navigator.pushNamed(context, "/test");
      },
    );
  }

  Widget _registerChildren() {
    return CardMenu(
      icon: Icon(
        Icons.sentiment_satisfied,
        color: Colors.white,
        size: 55,
      ),
      text: "Registrar",
      onPressed: () {
        Navigator.pushNamed(context, '/register');
      },
    );
  }

  Widget _visits() {
    return CardMenu(
      icon: Icon(
        Icons.remove_red_eye,
        color: Colors.white,
        size: 55,
      ),
      text: "Visitas",
      onPressed: () {
        Navigator.pushNamed(context, '/visit');
      },
    );
  }

  Widget _registerChild() {
    return CardMenu(
      icon: Icon(
        Icons.archive,
        color: Colors.white,
        size: 55,
      ),
      text: "Registros",
      onPressed: () {
        Navigator.pushNamed(context, '/record');
      },
    );
  }
}
