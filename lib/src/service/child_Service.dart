import 'package:NutriAlert/src/models/child_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChildService {
  //una isntacia de firestore para guardar datos
  // ignore: deprecated_member_use
  final _fireStore = Firestore.instance;
//------------------------------- funcion para registrar un niño nuevo ------------------------------------
  Future<RegisterChildRequest> saveChild(
      {String collectionName, Map<String, dynamic> collectionValues}) async {
    RegisterChildRequest childRequest = RegisterChildRequest();
    try {
      var child =
          await _fireStore.collection(collectionName).add(collectionValues);
      if (child != null) {
        childRequest.success = true;
      }
    } catch (e) {
      _mapErrorMessage(childRequest, e.code);
    }
    return childRequest;
  }

//-------------- suscripcion(con snapshot) a firestore para que nos envien automaticamente los msj ---------
  Stream<QuerySnapshot> getChildStream() {
    return _fireStore.collection("niños").snapshots();
  }

//---------------------------- metodo para obtener el historial del niño -----------------------------------
  Future<QuerySnapshot> getStory(String id) async {
    // ignore: deprecated_member_use
    return await _fireStore.collection('niños/$id/historial').getDocuments();
  }

//---------------------------- metodo para encontrar el registro del niño ----------------------------------
  Future<DocumentSnapshot> getRecordChild(String id) async {
    // ignore: deprecated_member_use
    return await _fireStore.collection("niños").doc(id).get();
    //collection("niños").doc(id).collection("historial").get()
  }

//---------------------------- metodo para Actualizar el registro del niño ----------------------------------
  void updateRecordChild(
      {String collectionName,
      String id,
      Map<String, dynamic> collectionValues}) async {
    // ignore: deprecated_member_use
    return _fireStore
        .collection(collectionName)
        .doc(id)
        .update(collectionValues);
    //collection("niños").doc(id).collection("historial").get()
  }

//------------------- suscripcion (con snapshot) a firestore para que nos envien automaticamente los msj ----------
  Stream<QuerySnapshot> getChildStoryStream(String id) {
    return _fireStore.collection("niños/$id/historial").snapshots();
  }

//-------------------------------- Método para eliminar un registro de un niño ----------------------------
  Future deleteChild(String collectionName, String id) {
    return _fireStore.collection(collectionName).doc(id).delete();
  }

//------------------------------- funcion para guardar elhistorial del niño --------------------------------
  void saveStoryChild(
      {String collectionName, Map<String, dynamic> collectionValues}) {
    _fireStore.collection(collectionName).add(collectionValues);
  }

  //para el manejo de errores (mapero de errores) de firebase
  void _mapErrorMessage(RegisterChildRequest childRequest, String code) {
    //code es el msj de errorde
    //firebase y la tenemos que mapear
    switch (code) {
      case 'error-unknown':
        childRequest.errorMenssage = "Ocurrió un error desconocido.";
        break;
      case 'error-object-not-found':
        childRequest.errorMenssage =
            "No existe ningún objeto en la referencia deseada.";
        break;
      default:
        childRequest.errorMenssage = code;
    }
  }
}
