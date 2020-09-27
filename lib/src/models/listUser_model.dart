import 'package:NutriAlert/src/service/user_service.dart';

class UserModel {
  final String name;
  final String secondName;
  final String dpi;
  final String phone;
  final String email;
  final String rol;

  UserModel({
    this.name,
    this.secondName,
    this.dpi,
    this.phone,
    this.email,
    this.rol,
  });
}

Future<List<UserModel>> getUserItem() async{
  List<UserModel> userItem = [];
  await for (var users in UserService().getUserStream()) {
    for (var user in users.documents) {
      final nombre = user.data()["nombre"];
      final apellido = user.data()["nombre"];
      final dpi = user.data()["nombre"];
      final tel = user.data()["nombre"];
      final correo = user.data()["nombre"];
      final rol = user.data()["nombre"];

      userItem.add(UserModel(
        name: nombre,
        secondName: apellido,
        dpi: dpi,
        phone: tel,
        email: correo,
        rol: rol,
      ));
      return userItem;
    }
  }

  return userItem;
}
