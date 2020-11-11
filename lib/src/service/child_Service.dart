import 'package:NutriAlert/src/models/child_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChildService {
  //una isntacia de firestore para guardar datos
  final _fireStore = FirebaseFirestore.instance;
//------------------------------- funcion para registrar un niño nuevo ------------------------------------
  Future<ChildRequest> saveChild(
      {String collectionName, Map<String, dynamic> collectionValues}) async {
    ChildRequest childRequest = ChildRequest();
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

//-------------- suscripcion(con snapshot) a firestore para obtener los registros de los niños---------
  Stream<QuerySnapshot> getChildStream() {
    return _fireStore
        .collection("niños")
        .orderBy(
          "fechaRegistro", descending: true
        )
        .snapshots();
  }
  
//-------------- suscripcion(con snapshot) a firestore para obtener los registros de los niños para ver los registros---------
  Stream<QuerySnapshot> getChildStreamRegistros() {
    return _fireStore.collection("niños").orderBy("fechaRegistro", descending: true).snapshots();
  }
//---------------------------- metodo para obtener el historial del niño -----------------------------------
  // Future<QuerySnapshot> getStory(String id) async {
  //   // ignore: deprecated_member_use
  //   return await _fireStore.collection('niños/$id/historial').getDocuments();
  // }

//---------------------------- metodo para encontrar el registro del niño ----------------------------------
  Future<DocumentSnapshot> getRecordChild(String id) async {
    // ignore: deprecated_member_use
    return await _fireStore.collection("niños").doc(id).get();
    //collection("niños").doc(id).collection("historial").get()
  }

//---------------------------- metodo para Actualizar el registro del niño ----------------------------------
  Future<ChildRequest> updateRecordChild(
      {String collectionName,
      String id,
      Map<String, dynamic> collectionValues}) async {
    ChildRequest childRequest = ChildRequest();
    //print(collectionName);
    //print(id);
    try {
      await _fireStore
          .collection(collectionName)
          .doc(id)
          .update(collectionValues);
      //collection("niños").doc(id).collection("historial").get()
      childRequest.success = true;
    } catch (e) {
      _mapErrorMessage(childRequest, e.code);
    }
    return childRequest;
  }

//---------------------------- metodo para Actualizar el registro del niño ----------------------------------
// void updateRecordChild2(
//     {String collectionName,
//     String id,
//     Map<String, dynamic> collectionValues}) async {
//   // ignore: deprecated_member_use
//   await _fireStore
//       .collection(collectionName)
//       .doc(id)
//       .update(collectionValues);
//   //collection("niños").doc(id).collection("historial").get()
// }

//------------ suscripcion (con snapshot) a firestore para que nos envie el historial del niño automaticamente ----------
  Stream<QuerySnapshot> getChildStoryStream(String id) {
    return _fireStore
        .collection("niños/$id/historial")
        .orderBy("edad", descending: true)
        .snapshots();
  }

//-------------------------------- Método para eliminar un registro de un niño ----------------------------
  Future<ChildRequest> deleteChild({String collectionName, String id}) async {
    ChildRequest childRequest = ChildRequest();
    try {
      await _fireStore.collection(collectionName).doc(id).delete();
      childRequest.success = true;
    } catch (e) {
      _mapErrorMessage(childRequest, e.code);
    }
    return childRequest;
  }

  //-------------------------------- Método para eliminar las collecciones del hostorial----------------------------
  Future<ChildRequest> deleteStoryChild(
      {String collectionName, String id}) async {
    ChildRequest childRequest = ChildRequest();
    try {
      final documentos = await _fireStore
          .collection(collectionName)
          .doc(id)
          .collection('historial')
          .get();
      for (var item in documentos.docs) {
        _fireStore
            .collection(collectionName)
            .doc(id)
            .collection('historial')
            .doc(item.id)
            .delete();
      }

      childRequest.success = true;
    } catch (e) {
      _mapErrorMessage(childRequest, e.code);
    }
    return childRequest;
  }

//------------------------------- funcion para guardar elhistorial del niño --------------------------------
  // void saveStoryChild(
  //     {String collectionName, Map<String, dynamic> collectionValues}) {
  //   _fireStore.collection(collectionName).add(collectionValues);
  // }
  Future<ChildRequest> saveStorychild(
      {String collectionName, Map<String, dynamic> collectionValues}) async {
    ChildRequest childRequest = ChildRequest();
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

  //para el manejo de errores (mapero de errores) de firebase
  void _mapErrorMessage(ChildRequest childRequest, String code) {
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
      case 'not-found':
        childRequest.errorMenssage = "No encontrado.";
        break;
      default:
        childRequest.errorMenssage = code;
    }
  }
}
