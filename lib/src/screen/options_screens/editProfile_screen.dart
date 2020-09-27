import 'package:flutter/material.dart';
import 'package:NutriAlert/src/widgets/app_button.dart';
import 'package:NutriAlert/src/widgets/app_textField.dart';

class EditProfile extends StatefulWidget {
  //ruta pagina principal
  static const String routName = "/edit";
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
   //un global key permite referenciar a un formulario y desde él tener accesos al estado de un textFormfield
  final GlobalKey<FormState> _formUserkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            //color al botron de retroceso
            leading: BackButton(color: Colors.white),
            title: Text(
              "Edita tu perfil",
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
                  _nombreField(),
                  SizedBox(
                    height: 10,
                  ),
                  _apellidosField(),
                  SizedBox(
                    height: 10,
                  ),
                  _dpiField(),
                  SizedBox(
                    height: 10,
                  ),
                  _telfonoField(),
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
                  _submitUser(),
                ],
              ),
            ),
          ),
        ),
    ));
  }
//------------------------  metodos para los inputs y botones  ---------------------------
  Widget _nombreField() {
    return AppTextField(
      //focusNode: _focusNode,
      //controller: _emailController,
      inputText: "Nombres",
      onSaved: (value) {},
    );
  }

  Widget _apellidosField() {
    return AppTextField(
      //focusNode: _focusNode,
      //controller: _emailController,
      inputText: "Apellidos",
      onSaved: (value) {},
    );
  }

  Widget _dpiField() {
    return AppTextField(
      //focusNode: _focusNode,
      //controller: _emailController,
      inputText: "DPI",
      textInputType: TextInputType.number, //tipo de teclado
      onSaved: (value) {},
    );
  }

  Widget _telfonoField() {
    return AppTextField(
      //focusNode: _focusNode,
      //controller: _emailController,
      inputText: "Número de telefono",
      textInputType: TextInputType.number, //tipo de teclado
      onSaved: (value) {},
    );
  }

  Widget _emailField() {
    return AppTextField(
      //focusNode: _focusNode,
      //controller: _emailController,
      inputText: "Ingrese el correo del usuario",
      textInputType: TextInputType.emailAddress, //tipo de teclado
      onSaved: (value) {},
    );
  }

  Widget _passwordField() {
    return AppTextField(
      //focusNode: _focusNode,
      //controller: _emailController,
      inputText: "Ingrese la contraseña del usariuo",
      textInputType: TextInputType.emailAddress, //tipo de teclado
      onSaved: (value) {},
      obscureText: true,
    );
  }

  Widget _submitUser() {
    return AppButton(
        nombre: "Editar Perfil", color: Colors.blueAccent, onPressed: () {});
  }
}