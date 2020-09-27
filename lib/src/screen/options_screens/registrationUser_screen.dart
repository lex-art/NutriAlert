import 'package:NutriAlert/src/mixins/validation_mixins.dart';
import 'package:NutriAlert/src/service/authentication.dart';
import 'package:NutriAlert/src/service/user_service.dart';
import 'package:NutriAlert/src/widgets/app_error_message.dart';
import 'package:flutter/material.dart';
import 'package:NutriAlert/src/widgets/app_button.dart';
import 'package:NutriAlert/src/widgets/app_textField.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
//libreria de firebase para poder registrar un usuario

class CreateUser extends StatefulWidget {
  //nombre de la ruta
  static const String routName = "/createUser";
  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> with ValidationMixins {
  ///  with ValidationMixins asi usarmos el mixins que nos ayuda a validar los datos, son como "reglas"

  bool showSpinner = false;
  //un global key permite referenciar a un formulario y desde él tener accesos al estado de un textFormfield
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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
  //guardamos el usuario que nos llega desde firebase, para poder crear una especie de sesion en la app
  var loggedInUser;

  //seteamos el autovalidate
  bool _autovalidate = false;
  String _errorMessage = "";

  //necesitamos inciciar los controller de los textfield lo hacemos con init state

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    _nombresController = TextEditingController();
    _apellidosController = TextEditingController();
    _dpiController = TextEditingController();
    _telefonoController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  //metodo para la barra de progreso
  void setSpinnerStatus(bool status) {
    //re-renderizar la app para que muestre el progres bar
    setState(() {
      showSpinner = status;
    });
  }

  var _lista = ["Normal", "Administrador"];
  //seleccion del rol
  String _select = "Normal";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //color al botron de retroceso
          leading: BackButton(color: Colors.white),
          title: Text(
            "Registrar un nuevo usuario",
            style: TextStyle(color: Colors.white),
          )),
      //backgroundColor: Theme.of(context).accentColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                //padding: const EdgeInsets.only(top: 15, left: 40, right: 40),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.person_add,
                      size: 100,
                      color: Colors.blueAccent,
                    ),
                    _nombreField(),
                    SizedBox(
                      height: 10,
                    ),
                    _apellidosField(),
                    SizedBox(
                      height: 10,
                    ),
                    _telfonoField(),
                    SizedBox(
                      height: 10,
                    ),
                    _dpiField(),
                    SizedBox(
                      height: 10,
                    ),
                    _emailField(),
                    SizedBox(
                      height: 10,
                    ),
                    _passwordField(),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: DropdownButton(
                        items: _lista.map((String a) {
                          return DropdownMenuItem(value: a, child: Text(a));
                        }).toList(),
                        onChanged: (_value) => {
                          setState(() {
                            _select = _value;
                          }),
                        },
                        hint: Text(_select),
                      ),
                    ),
                    _showErrorMessage(),
                    _submitUser(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

//------------------------  metodos para los inputs y botones  ---------------------------
  Widget _nombreField() {
    return AppTextField(
      focusNode: _focusNode,
      controller: _nombresController,
      autoValidate: _autovalidate,
      validator: validateNameUser,
      inputText: "Nombres",
      onSaved: (value) {},
    );
  }

  Widget _apellidosField() {
    return AppTextField(
      controller: _apellidosController,
      autoValidate: _autovalidate,
      validator: validateLastName,
      inputText: "Apellidos",
      onSaved: (value) {},
    );
  }

  Widget _dpiField() {
    return AppTextField(
      controller: _dpiController,
      inputText: "DPI",
      autoValidate: _autovalidate,
      //validator: validateDPI,
      textInputType: TextInputType.number, //tipo de teclado
      onSaved: (value) {},
    );
  }

  Widget _telfonoField() {
    return AppTextField(
      controller: _telefonoController,
      autoValidate: _autovalidate,
      //validator: validatePhone,
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
        nombre: "Crear Usuario",
        color: Colors.blueAccent,
        onPressed: () async {
          if (_formkey.currentState.validate()) {
            //cuando se incia el procesos de auntenricacion llamamos al metodo que hara el progress bar
            //para inciarlo
            setSpinnerStatus(true);
            var auth = await Authentication().createUser(
                //usamos la clase  Authentication donde hicmos todo el proceso para crear usuarios
                //y tambbien hacemos uso de los textcontrollers de una vez validados gracias al mixins
                email: _emailController.text,
                password: _passwordController.text);
            if (auth.success) {
              //aqui empieza la magia de los roles :v
              //guardamos el usuario que nos llega desde firebase, para poder gurdar los demas datos
              var user = await Authentication().getCurrentUser();
              loggedInUser = user;
              //print("--------------------------------------------${loggedInUser.uid}");
              //guardamos los datos del usuario creado
              UserService().saveUser(
                  collectionName: "usuarios",
                  collectionValues: {
                    'nombre': _nombresController.text,
                    'apellidos': _apellidosController.text,
                    'telefono': _telefonoController.text,
                    'dpi': _dpiController.text,
                    'correo': loggedInUser.email,
                    'rol': _select,
                  },
                  id: loggedInUser.uid);

              //si se crea el usuario reederigimos a la pg principal y limpiamos los textfield
              Navigator.pushNamed(context, '/nutriAlert');
              _emailController.text = "";
              _passwordController.text = "";
              FocusScope.of(context).requestFocus(_focusNode);
            } else {
              //si no se crea el usuario mostrara el error que se genera, pero tenemos mapeadas algunas comunes
              setState(() {
                _errorMessage = auth.errorMenssage;
              });
            }
            //cuando termine el proceso de auntenticaion se cierrar la barra de progreso
            setSpinnerStatus(false);

          } else {
            //tiene errores el formulario en la validacion de datos, aca los muestra
            setState(() {
              _autovalidate = true;
            });
          }
        });
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
/*
onPressed: () async {
          //con la key sabremos el estado en todo momento del formulario
          if (_formkey.currentState.validate()) {
            //cuando se incia el procesos de auntenricacion llamamos al metodo que hara el progress bar
            //para inciarlo
            setSpinnerStatus(true);
            var auth = await Authentication().createUser(
                //usamos la clase  Authentication donde hicmos todo el proceso para crear usuarios
                //y tambbien hacemos uso de los textcontrollers de una vez validados gracias al mixins
                email: _emailController.text,
                password: _passwordController.text);
            if (auth.success) {
              //aqui empieza la magia de los roles :v
              //guardamos el usuario que nos llega desde firebase, para poder gurdar los demas datos
              var user = await Authentication().getCurrentUser();
              loggedInUser = user;
              //print("--------------------------------------------${loggedInUser.uid}");
              //guardamos los datos del usuario creado
              UserService().saveUser(
                  collectionName: "usuarios",
                  collectionValues: {
                    'nombre': _nombresController.text,
                    'apellidos': _apellidosController.text,
                    'telefono': _telefonoController.text,
                    'dpi': _dpiController.text,
                    'correo': loggedInUser.email,
                    'rol':  AppDropdowButton().select.toString(),
                  },
                  id: loggedInUser.uid);

              //si se crea el usuario reederigimos a la pg principal y limpiamos los textfield
              Navigator.pushNamed(context, '/nutriAlert');
              _emailController.text = "";
              _passwordController.text = "";
              FocusScope.of(context).requestFocus(_focusNode);
            } else {
              //si no se crea el usuario mostrara el error que se genera, pero tenemos mapeadas algunas comunes
              setState(() {
                _errorMessage = auth.errorMenssage;
              });
            }
            //cuando termine el proceso de auntenticaion se cierrar la barra de progreso
            setSpinnerStatus(false);
          } else {
            //tiene errores el formulario en la validacion de datos, aca los muestra
            setState(() {
              _autovalidate = true;
            });
          }
 */
