import 'package:NutriAlert/src/mixins/validation_mixins.dart';
import 'package:NutriAlert/src/service/authentication.dart';
import 'package:NutriAlert/src/widgets/app_error_message.dart';
import 'package:flutter/material.dart';
import 'package:NutriAlert/src/widgets/app_button.dart';
import 'package:NutriAlert/src/widgets/app_textField.dart';

class EditUser extends StatefulWidget {
  final String correo;

  //ruta pagina principal
  static const String routName = "/editUser";
  EditUser({this.correo});

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> with ValidationMixins {
  //un global key permite referenciar a un formulario y desde él tener accesos al estado de un textFormfield
  final GlobalKey<FormState> _formUserkey = GlobalKey<FormState>();

  ///aqui manejamos el estado d eun widget, entonces aquí creamos las dos variables
  ///para gurdar el email y la contraseña, seran variables a nivel interno
  FocusNode _focusNode;
  //------------------------- Controladores para los textfield de este formulario  para registrar  un usuairo nuevo -------------------

  TextEditingController _emailController = TextEditingController();

  bool _autovalidate = true;
  String _errorMessage = "";
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    setState(() {
      print(widget.correo);
      _emailController = TextEditingController(text: widget.correo);
    });
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
              "Cambio de contraseña.",
              style: TextStyle(color: Colors.white),
            )),
        body: SingleChildScrollView(
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
                    _textoTitulo('Ingrese su correo .'),
                    SizedBox(height: 5.0),
                    _emailField(),
                    SizedBox(
                      height: 10,
                    ),
                    _textoTitulo(
                        'Se le enviará un correo, donde podrá cambiar su contraseña.'),
                    SizedBox(
                      height: 10,
                    ),
                    _showErrorMessage(),
                    _submitUser(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

//------------------------  metodos para los inputs y botones  ---------------------------
  Widget _emailField() {
    return AppTextField(
      focusNode: _focusNode,
      inputText: "Ingrese el correo del usuario",
      controller:
          _emailController, //para saber el estado en todo momento de esta caja de texto
      autoValidate: _autovalidate, //el estdo de validacion del formulario
      textInputType: TextInputType.emailAddress, //tipo de teclado
      onSaved: (value) {},
    );
  }

  Widget _submitUser() {
    return AppButton(
        nombre: "Cambiar",
        color: Colors.blueAccent,
        onPressed: () async {
          if (_formUserkey.currentState.validate()) {
            var resul = await Authentication().changePass(email: widget.correo);
            if (resul.success) {
              Navigator.pushNamed(context, '/nutriAlert');
              _emailController.text = "";
            } else {
              _errorMessage = resul.errorMenssage;
            }
          }
        });
  }

  Widget _textoTitulo(String titulo) {
    return Text(
      titulo,
      style: TextStyle(color: Theme.of(context).accentColor),
      textAlign: TextAlign.center,
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
