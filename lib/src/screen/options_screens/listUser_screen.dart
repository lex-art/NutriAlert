import 'package:NutriAlert/src/service/user_service.dart';

import 'package:flutter/material.dart';

import 'editUser.dart';

class User extends StatefulWidget {
  //ruta pagina principal
  static const String routName = "/listUser";
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //color al botron de retroceso
          leading: BackButton(color: Colors.white),
          title: Text(
            "Usuarios Registrados",
            style: TextStyle(color: Colors.white),
          )),
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder(
                //se encarga de escuchar los datos que viene del stream
                stream: UserService().getUserStream(),
                //metodo que se activa cada vez que hay un dato nuevo en el stream
                builder: (context, snapshot) {
                  //obtneer los datos de firebase
                  if (snapshot.hasData) {
                    return Flexible(
                      child: ListView(
                        children: _getUserItem(snapshot.data.documents),
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }

  //List<UserModel>
  List<UserItem> _getUserItem(dynamic users) {
    List<UserItem> userItem = [];
    for (var user in users) {
      final nameValue = user.data()["nombre"];
      final apellidoValue = user.data()["apellidos"];
      final telValue = user.data()["telefono"];
      final correoValue = user.data()["correo"];

      userItem.add(UserItem(
        nombre: nameValue,
        apellido: apellidoValue,
        telefono: telValue,
        correo: correoValue,
      ));
    }
    return userItem;
  }
}

class UserItem extends StatelessWidget {
  final String nombre;
  final String apellido;
  final String telefono;
  final String correo;

  UserItem({this.nombre, this.apellido, this.telefono, this.correo});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 8),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text(nombre[0].toUpperCase()),
              backgroundColor: Theme.of(context).buttonColor,
            ),
            title: Column(
              // mainAxisAlignment: MainAxisAlignment.start, //espacio entre los dos elementos del row
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(nombre + " " + apellido,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                Text(
                  "Cel: $telefono",
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
                correo,
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0),
              ),
            ),
            //cuando le da click lo lleva a otra pag
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute<Null>(
                  builder: (BuildContext context) => EditUser(correo: correo,)));
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
