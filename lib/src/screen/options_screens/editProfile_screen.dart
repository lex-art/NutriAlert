import 'package:NutriAlert/src/mixins/validation_mixins.dart';
import 'package:NutriAlert/src/service/authentication.dart';
import 'package:NutriAlert/src/service/user_service.dart';
import 'package:NutriAlert/src/widgets/app_error_message.dart';
import 'package:flutter/material.dart';
import 'package:NutriAlert/src/widgets/app_button.dart';
import 'package:NutriAlert/src/widgets/app_textField.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../login_screen.dart';

class EditProfile extends StatefulWidget {
  //ruta pagina principal
  static const String routName = "/edit";
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> with ValidationMixins {
  //un global key permite referenciar a un formulario y desde él tener accesos al estado de un textFormfield
  final GlobalKey<FormState> _formUserkey = GlobalKey<FormState>();
  var loggedInUser;
  bool showSpinner = false;

  ///aqui manejamos el estado d eun widget, entonces aquí creamos las dos variables
  ///para gurdar el email y la contraseña, seran variables a nivel interno
  FocusNode _focusNode;
  //------------------------- Controladores para los textfield de este formulario  para registrar  un usuairo nuevo -------------------
  TextEditingController _nombresController;
  TextEditingController _apellidosController;
  TextEditingController _dpiController;
  TextEditingController _telefonoController;

  TextEditingController _emailController;
  TextEditingController _passwordController;

  bool _autovalidate = true;
  String _errorMessage = "";

  String nombre, apellido, tel, dpi, id, correo;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    getCurrentUser();
  }

  void getCurrentUser() async {
    //como lo fijimos firenbase trabaj con progra asyncrona y por eso se usa await y async
    var user = await Authentication().getCurrentUser(); //obtenemos el usaurio
    //le pasamos el usuriuo que trajimos de firebase y la asignamos la loggedInUdser
    if (user != null) {
      loggedInUser = user;
      id = loggedInUser.uid;
      final usuario = await UserService().getUser(loggedInUser.uid);
      setState(() {
        nombre = usuario.data()['nombre'];
        apellido = usuario.data()['apellidos'];
        tel = usuario.data()['telefono'];
        dpi = usuario.data()['dpi'];
        correo = usuario.data()['correo'];

        _nombresController = TextEditingController(text: nombre);
        _apellidosController = TextEditingController(text: apellido);
        _dpiController = TextEditingController(text: dpi);
        _telefonoController = TextEditingController(text: tel);

        _emailController = TextEditingController(text: correo);
        _passwordController = TextEditingController();

        print(nombre);
      });
    }
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
        appBar: AppBar(
            //color al botron de retroceso
            leading: BackButton(color: Colors.white),
            title: Text(
              "Edita tu perfil.",
              style: TextStyle(color: Colors.white),
            )),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
            child: Form(
              key: _formUserkey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 40, right: 40),
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.mode_edit,
                        size: 100,
                        color: Colors.blueAccent,
                      ),
                      _textoTitulo('Ingrese su nombre.'),
                      SizedBox(height: 5.0),
                      _nombreField(),
                      SizedBox(
                        height: 10,
                      ),
                      _textoTitulo('Ingrese su apellido.'),
                      SizedBox(height: 5.0),
                      _apellidosField(),
                      SizedBox(
                        height: 10,
                      ),
                      _textoTitulo('Ingrese su número de teléfono.'),
                      SizedBox(height: 5.0),
                      _telfonoField(),
                      SizedBox(
                        height: 10,
                      ),
                      _textoTitulo('Ingrese su DPI.'),
                      SizedBox(height: 5.0),
                      _dpiField(),
                      SizedBox(
                        height: 10,
                      ),
                      _textoTitulo('Ingrese su correo.'),
                      SizedBox(height: 5.0),
                      _emailField(),
                      SizedBox(
                        height: 10,
                      ),
                      _textoTitulo('Cambie o confirme su contraseña.'),
                      SizedBox(height: 5.0),
                      _passwordField(),
                      _showErrorMessage(),
                      _submitUser(),
                      SizedBox(height: 5.0),
                      _submitDeleteUser(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

//------------------------  metodos para los inputs y botones  ---------------------------
  Widget _nombreField() {
    return AppTextField(
      focusNode: _focusNode,
      validator: validateNameUser,
      controller: _nombresController,
      autoValidate: _autovalidate,
      inputText: "Nombres",
      onSaved: (value) {},
    );
  }

  Widget _apellidosField() {
    return AppTextField(
      //focusNode: _focusNode,
      controller: _apellidosController,
      validator: validateLastName,
      autoValidate: _autovalidate,
      inputText: "Apellidos",
      onSaved: (value) {},
    );
  }

  Widget _dpiField() {
    return AppTextField(
      //focusNode: _focusNode,
      validator: validateDPI,
      controller: _dpiController,
      autoValidate: _autovalidate,
      inputText: "DPI",
      textInputType: TextInputType.number, //tipo de teclado
      onSaved: (value) {},
    );
  }

  Widget _telfonoField() {
    return AppTextField(
      //focusNode: _focusNode,
      validator: validatePhone,
      controller: _telefonoController,
      autoValidate: _autovalidate,
      inputText: "Número de telefono",
      textInputType: TextInputType.number, //tipo de teclado
      onSaved: (value) {},
    );
  }

  Widget _emailField() {
    return AppTextField(
      inputText: "Ingrese el correo del usuario",
      controller:
          _emailController, //para saber el estado en todo momento de esta caja de texto
      //focusNode: _focusNode,
      autoValidate: _autovalidate, //el estdo de validacion del formulario
      // validator: validateEmail,
      textInputType: TextInputType.emailAddress, //tipo de teclado
      onSaved: (value) {},
    );
  }

  Widget _passwordField() {
    return AppTextField(
      inputText: "Ingrese la contraseña del usariuo",
      controller: _passwordController,
      // validator: validatePassword,
      autoValidate: _autovalidate, //el estdo de validacion del formulario
      textInputType: TextInputType.emailAddress, //tipo de teclado
      onSaved: (value) {},
      obscureText: true,
    );
  }

  Widget _submitUser() {
    return AppButton(
        nombre: "Editar Perfil",
        color: Colors.blueAccent,
        onPressed: () async {
          if (_formUserkey.currentState.validate()) {
            //progress barpara inciarlo
            setSpinnerStatus(true);
            var resultado = await Authentication().changeEmailPass(
                email: _emailController.text, pass: _passwordController.text);
            if (resultado.success) {
              var resul =
                  await UserService().updateDataUser(id: id, collectionValues: {
                "nombre": _nombresController.text,
                "apellidos": _apellidosController.text,
                "telefono": _telefonoController.text,
                "dpi": _dpiController.text,
              });
              if (resul.success) {
                _nombresController.text = "";
                _apellidosController.text = "";
                _telefonoController.text = "";
                _dpiController.text = "";
                Authentication().singOut();
                //cerramos todas las pantallas abiertas de la app
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false);
              } else {
                setState(() {
                  _errorMessage = resul.errorMenssage;
                });
              }
            } else {
              setState(() {
                _errorMessage = resultado.errorMenssage;
              });
            }
            setSpinnerStatus(false);
          } else {
            //tiene errores el formulario en la validacion de datos, aca los muestra
            setState(() {
              _autovalidate = true;
            });
          }
        });
  }

//---------------------------------- Para eliminar el registro -----------------------
  //metodo donde colocamos el resultado del alert
  Future<void> alertResultado(String action) async {
    if (action == "yes") {
       setSpinnerStatus(true);
      var deleteDataUser = await UserService().deleteDataUser(id: id);
          if (deleteDataUser.success) {
           
            var deleteUser = await Authentication().deleteUser();
            if (deleteUser.success) {
              //cerramos todas las pantallas abiertas de la app
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route<dynamic> route) => false);
            } else {
              setSpinnerStatus(false);
              _errorMessage = "No se pudo eliminar el usuario";
            }
          } else {
            setSpinnerStatus(false);
            _errorMessage = "No se pudo eliminar el usuario";
          }
    }
    if (action == "no") {
      Navigator.pop(context);
      // Navigator.pushNamed(context, "/nutriAlert");
    }
  }

  //cuanbdo se presiona el boton se ejecuta essta funcion
  void cuandoPresionaBoton(String value) {
    //asi se crea un alert dialog classic esta en la documentacion, matarialcomponet hats a abajo
    AlertDialog dialog = AlertDialog(
      //contenido del dialog
      content: Text(value, style: TextStyle(color: Colors.redAccent), textAlign: TextAlign.center,),
      //puede aplicarse varias acciones del dialog con actions y esta recibe una lista de widgets
      actions: <Widget>[
        //flat buton es un boton parecido al de raisebuton
        FlatButton(
            onPressed: () {
              alertResultado("yes");
            },
            child: Text("Si")),
        FlatButton(
            onPressed: () {
              alertResultado("no");
            },
            child: Text("No"))
      ],
    );
    //y debemos retornar un showDialog para que aparezaca
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }

  Widget _submitDeleteUser() {
    return AppButton(
        nombre: "Elimianr Usuario",
        color: Colors.redAccent,
        onPressed: () {
           cuandoPresionaBoton(
                "¿Esta deguro de eliminar su usuario? \nSe eliminará todos sus datos y no podra acceder a la aplicación");
        });
  }

  Widget _textoTitulo(String titulo) {
    return Text(
      titulo,
      style: TextStyle(color: Theme.of(context).accentColor),
    );
  }

  //un widget para mostrar el error de firebase
  Widget _showErrorMessage() {
    SizedBox(
      height: 5.0,
    );
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return ErrorMessage(errorMessage: _errorMessage);
    } else {
      return Container(height: 0.0);
    }
  }
}
