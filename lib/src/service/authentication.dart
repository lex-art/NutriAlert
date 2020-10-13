import 'package:NutriAlert/src/models/auth_request.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  //para poder usar firebase tenemos que declara una instancia para poder utilizarlo a nivel de nuestro codigo
  ///instance creau un nuevo objeto, pero lo crea a travez de un singelton, lo que hace es que crea una
  ///solamente una instancia de un objeto y no la crea cada vez que se llama un objeto, si no que solo una vez se crea para
  ///varios objetos  y queda disponoble para toda la app
  final _auth = FirebaseAuth.instance;
  //para usar un metodo  en donde podamos crear un usuario y solo llamemos a este metodo  lo hacemos de la sig manera
  // pasamos los parametros , sera de tipo asyncrono e importamos la lib de firebas
  Future<AuthenticationRequest> createUser(
      {String email , String password }) async {
    //hacemos a crear una instancia de AuthenticationRequest
    AuthenticationRequest authRequest = AuthenticationRequest();
    //por si hay un error lo envolvemos priumero en yn try catch
    try {
      ///aqui enviaremos esos valores a firebase para registrar un usuario
      ///llamadas asincronas lo vere despues, await quiere decir que nosotros de alguna manera esta llamando esta funcionalidad,
      ///pero no esta deteniendo la app, no esta dejando al usuario congelado, por decilo esta trabajando en sefundo plano
      ///Todas la llamades en firebnase deben ser asyncronas
      ///retornamos asi el consumidor puede hacer lo que quiera
      var user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        //si el usuario fue logueado exitosamente
        authRequest.success = true;
      }
    } catch (e) {
      _mapErrorMessage(authRequest, e.code);
    }
    //si no hay un resultado enviamos null
    return authRequest;
  }
  ///ahora hacemos lo mismo para la sesion del usuario

//------------------------- Metodo para obtener los datos del usuario ----------------------
  // ignore: deprecated_member_use
  ///ahora hacemos lo mismo para la sesion del usuario
  Future getCurrentUser() async {
    try {
      return _auth.currentUser;
    } catch (e) {
      print(e);
    }
    return null;
  }
  ///----------------------- metodo para loguear al usuario --------------------------------
  Future<AuthenticationRequest> loginUser(
      {String email, String password}) async {
    //hacemos a crear una instancia de AuthenticationRequest
    AuthenticationRequest authRequest = AuthenticationRequest();
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password); //funcion de firebase para autenticacion del user
      if (user != null) {
        //si el usuario fue logueado exitosamente
        authRequest.success = true;
      }
    } catch (e) {
      _mapErrorMessage(authRequest, e.code);
    }
    return authRequest;
  }

//---------------------------- funcion para poder salir de sesion ------------------
  Future<void> singOut() async {
    try {
      return await _auth.signOut(); //con esto cerramos sesion
    } catch (e) {
      print(e);
    }
    return null;
  }

  //para el manejo de errores (mapero de errores) de firebase
  void _mapErrorMessage(AuthenticationRequest authRequest, String code) {
    //code es el msj de errorde
    //firebase y la tenemos que mapear
    switch (code) {
      case 'user-not-found':
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
