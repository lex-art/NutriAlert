//importar el packge de firestone para guardar datos
import 'package:NutriAlert/src/models/auth_request.dart';
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
  Future<QuerySnapshot> getUsers() async {
    // ignore: deprecated_member_use
    return await _fireStore.collection('usuarios').getDocuments();
  }

  ///metodo para obtener los usuarios
  Future<DocumentSnapshot> getUser(String id) async {
    // ignore: deprecated_member_use
    return await _fireStore.collection('usuarios').doc(id).get();
  }

  //suscripcion(con snapshot) a firestore para que nos envien automaticamente los msj
  Stream<QuerySnapshot> getUserStream() {
    return _fireStore.collection("usuarios").snapshots();
  }

  Future<AuthenticationRequest> updateDataUser(
      {String id,
        Map<String, dynamic> collectionValues,
      }) async {
    AuthenticationRequest authenticationRequest = AuthenticationRequest();
    try {
      await _fireStore.collection('usuarios').doc(id).update(collectionValues);
      authenticationRequest.success = true;
    } catch (e) {
      _mapErrorMessage(authenticationRequest, e.code);
    }
    return authenticationRequest;
  }
  Future<AuthenticationRequest> deleteDataUser(
      {String id}) async {
    AuthenticationRequest authenticationRequest = AuthenticationRequest();
    try {
      await _fireStore.collection('usuarios').doc(id).delete();
      authenticationRequest.success = true;
    } catch (e) {
      _mapErrorMessage(authenticationRequest, e.code);
    }
    return authenticationRequest;
  }

  //para el manejo de errores (mapero de errores) de firebase
  void _mapErrorMessage(AuthenticationRequest authRequest, String code) {
    //code es el msj de errorde
    //firebase y la tenemos que mapear
    switch (code) {
      case 'not-found':
        authRequest.errorMenssage = "Usuario no encontrado";
        break;
      case 'wrong-password':
        authRequest.errorMenssage = "Contraseña incorrecta";
        break;
      case 'network-request-failed':
        authRequest.errorMenssage = "Error de red";
        break;
      case 'email-already-in-use':
        authRequest.errorMenssage = "El usuario ya está registrado";
        break;
      case 'invalid-email':
        authRequest.errorMenssage = "El correo es incorrecto";
        break;
      case 'unknown':
        authRequest.errorMenssage = "Ingrese todos los datos";
        break;
      case 'weak-password':
        authRequest.errorMenssage = "Su contraseña es muy débil";
        break;

      default:
        authRequest.errorMenssage = code;
    }
  }
}
