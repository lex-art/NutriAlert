//importar el packge de firestone para guardar datos
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  //una isntacia de firestore para guardar datos
  // ignore: deprecated_member_use
  final _fireStore = Firestore.instance;

  ///Map <String, dynamic> asigna una  clave String con el  valor dinámico. Dado que la
  ///clave es siempre una cadena y el valor puede ser de cualquier tipo , se mantiene tan
  ///dinámica para estar en el lado más seguro. Es muy útil para leer un objeto JSON, ya
  /// que el objeto JSON representa un conjunto de pares clave-valor donde la clave es de
  /// tipo String, mientras que el valor puede ser de cualquier tipo, incluyendo String, 
  /// List <String>, List <Object> o List <Map >. Eche un vistazo al siguiente ejemplo:

  void saveUser(
      {String collectionName,
      Map<String, dynamic> collectionValues,
      String id}) //recibe los datos que son necesarios a guradar en la bd
  {
    ///collection recibe varios parametros para guardar en la bd primero la coleccion
    ///luego llamamos a la funcion add para agregar los datos
    //_fireStore.collection("usuarios").add(collectionValues);
    //guarda un documento con un id personalizado 
    _fireStore.collection("usuarios").doc(id).set(collectionValues);
  }

  ///metodo para obtener los usuarios
  Future<QuerySnapshot> getUser() async {
    // ignore: deprecated_member_use
    return await _fireStore.collection('usuarios').getDocuments();
  }

  //suscripcion(con snapshot) a firestore para que nos envien automaticamente los msj
  Stream<QuerySnapshot> getUserStream() {
    return _fireStore.collection("usuarios").snapshots();
  }
}
