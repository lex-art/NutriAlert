import 'package:cloud_firestore/cloud_firestore.dart';

class ChildService {
  //una isntacia de firestore para guardar datos
  // ignore: deprecated_member_use
  final _fireStore = Firestore.instance;
  //funcion para registrar un niño nuevo
  void saveChild(
      {String collectionName, Map<String, dynamic> collectionValues}) {
    _fireStore.collection("niños").add(collectionValues);
  }

  //suscripcion(con snapshot) a firestore para que nos envien automaticamente los msj
  Stream<QuerySnapshot> getChildStream() {
    return _fireStore.collection("niños").snapshots();
  }
}
