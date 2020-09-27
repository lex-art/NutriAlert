import 'package:NutriAlert/src/mixins/validation_mixins.dart';
import 'package:NutriAlert/src/service/authentication.dart';
import 'package:NutriAlert/src/service/user_service.dart';
import 'package:NutriAlert/src/widgets/app_error_message.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:NutriAlert/src/widgets/app_button.dart';
import 'package:NutriAlert/src/widgets/app_logo.dart';
import 'package:NutriAlert/src/widgets/app_textField.dart';

class LoginScreen extends StatefulWidget {
  //ruta rincipal
  static const String routName = "";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationMixins {
  //aqui llamamos al mixins tipo herencia, para empezar a utilizarlo
  //variables que nos ayudaran a autenticar a el usuario
  //String _email; estos ya estan definidos en el email y password controller
  //String _password;
  //para limpiar la caja de texto usuamos el controller
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  //paa posicionar el parpadeo del texto esta definio en el archivo app_textField
  FocusNode _focusNode;
  bool showSpinner = false;
  //funcion que nos permitira validar el formulario
  bool _autoValidate = false;
  //un global key permite referenciar a un formulario y desde él tener accesos al estado de un textFormfield
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _errorMessage = "";

  //guardamos el usuario que nos llega desde firebase, para poder crear una especie de sesion en la app
  var loggedInUser;

  //en el momento que se inicializa el estado de este widget, tambien tiene que iniciar el focun
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  //dispose libera los recursos que ya no se usan cuando salimos de la pantalla
  @override
  void dispose() {
    super.dispose();
    //asegurarnos que focus node libere  los recursos cuando ya no se utilice
    _focusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  //metodo para la barra de progreso
  void setSpinnerStatus(bool status) {
    //re-renderizar la app para que muestre el progres bar
    setState(() {
      showSpinner = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        //barra de progreso cuando hace login, se hace desde el principio
        body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            //---------------------Formulario de inicio de sesión -----------------
            child: Form(
              //llava que nos permitira saber el estado del formulario
              key: _formkey,
              child: Container(
                  //padding: EdgeInsets.all(40.0),
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          40.0), //cuando el teclado se abre todo se acomode y no se pierda la pantalla
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppLogo(),
                        SizedBox(height: 30.0), //espacio entre los widget
                        _emailField(),
                        SizedBox(height: 15.0),
                        _passwordField(),
                        SizedBox(height: 15.0),
                        _showErrorMessage(),
                        _submitField(),
                      ],
                    ),
                  )),
            )));
  }

  //metodos para los inputs y botones
  Widget _emailField() {
    return AppTextField(
      focusNode: _focusNode,
      controller: _emailController,
      validator: validateEmail,
      autoValidate: _autoValidate,
      inputText: "Ingrese su correo aquí",
      textInputType: TextInputType.emailAddress, //tipo de teclado
      onSaved: (value) {},
    );
  }

  Widget _passwordField() {
    return AppTextField(
      controller: _passwordController,
      validator: validatePassword,
      autoValidate: _autoValidate,
      inputText: "Ingrese su contraseña aquí",
      obscureText: true,
      onSaved: (value) {},
    );
  }

  Widget _submitField() {
    return AppButton(
      color: Colors.blueAccent,
      nombre: "Iniciar sesión",
      onPressed: () async {
        ///aqui hacemos uso del global key para validar el formulario, para cada uno de los
        /// textField, si esta bien los datos, ejecuta el codigo para el ingreso
        if (_formkey.currentState.validate()) {
          //cuando se incia el procesos de auntenricacion llamamos al metodo que hara el progress bar
          //para inciarlo
          setSpinnerStatus(true);
          //aqui validamos  el usuario en firebase
          var auth = await Authentication().loginUser(
              email: _emailController.text, password: _passwordController.text);
          //si es distinto a nul entonces el usuario existe
          if (auth.success) {
            _getUser();
            //si el logueo es exitosos entra aqui
            Navigator.pushNamed(context, '/nutriAlert');
            //aca utilizamos el focus node
            FocusScope.of(context).requestFocus(_focusNode);
            //aca lipiamos los textfield despues autenticarnos
            _emailController.text = "";
            _passwordController.text = "";
          } else {
            //si no es exitoso entra en esta parte, donde muestra el error en un widget
            setState(() {
              _errorMessage = auth.errorMenssage;
            });
          }
          //cuando termine el proceso de auntenticaion se cierrar la barra de progreso
          setSpinnerStatus(false);
        } else {
          ///si cambia el error debemos de re-renderizar la pantalla, para quitar el autrovalidate
          ///en false para pasarlo a true
          setState(() => _autoValidate = true);
        }
      },
    );
  }

  //---------------------------- Metodo para obtener el usaurios en la bd -----------
  void _getUser() async {
    //obtner el id del usuaio
    var user = await Authentication().getCurrentUser();
    loggedInUser = user;
    String idUser = loggedInUser.uid;

    //todos los datos de la coleccion
    final usuarios = await UserService().getUser();
    for (var usuario in usuarios.documents) {
      //print("-----------------------------------------${usuario.get("rol")}");
      //verificamos que sea el mismo usuario
      if (usuario.id == idUser) {
        //si es el mismo usuairo, ahora vemos que rol tiene
        if (usuario.get("rol") == "admin") {
        
          //por ultimo lo redirigimos a la pagina que quiere
          Navigator.pushNamed(context, '/nutriAlert');
          break;
        } else {
          Navigator.pushNamed(context, '/record');
          break;
        }
      } else {
        print("Usuario no valido");
      }
    }
  }

  //un widget para mostrar el error de firebase
  Widget _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return ErrorMessage(errorMessage: _errorMessage);
    } else {
      return Container(height: 0.0);
    }
  }
}
