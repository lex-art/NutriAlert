import 'package:NutriAlert/src/algoritmos/proxima_cita.dart';
import 'package:NutriAlert/src/mixins/validationChild_mixins.dart';
import 'package:flutter/material.dart';
import 'package:NutriAlert/src/widgets/app_button.dart';
import 'package:NutriAlert/src/widgets/app_textField.dart';

import '../nurtriAlert_app.dart';

// ignore: must_be_immutable
class ResultTestRelease extends StatefulWidget {
  final String idChild;
  final String edad;
  final String peso;
  final String altura;
  String trata;

  //nombre de la ruta
  static const String routName = "/result";

//---------------- Constructor de  este widget que son los datos del niño -----------------------------
  ResultTestRelease({this.idChild, this.edad, this.peso, this.altura});

  @override
  _ResultTestStateRelease createState() => _ResultTestStateRelease();
}

class _ResultTestStateRelease extends State<ResultTestRelease>
    with ValidationChildMixins {
  bool _autovalidate = false;

  TextEditingController _pesoEdadController = TextEditingController();
  TextEditingController _longitudEdadController = TextEditingController();
  TextEditingController _zde0a2Controller = TextEditingController();
  TextEditingController _zde3a5Controller = TextEditingController();
  TextEditingController _trataController = TextEditingController();

  bool showSpinner = false;
  //un global key permite referenciar a un formulario y desde él tener accesos al estado de un textFormfield
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  //tipo de teclado

  @override
  void initState() {
    super.initState();
    _pesoEdadController = TextEditingController();
    _longitudEdadController = TextEditingController();
    _zde0a2Controller = TextEditingController();
    _zde3a5Controller = TextEditingController();
    _trataController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _pesoEdadController.dispose();
    _longitudEdadController.dispose();
    _zde0a2Controller.dispose();
    _zde3a5Controller.dispose();
    _trataController.dispose();
  }

  DateTime _dateTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //color al botron de retroceso
          leading: BackButton(color: Colors.white),
          title: Text(
            "Resultados",
            style: TextStyle(color: Colors.white),
          )),
      backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(
        //para que permita hacer scroll cuando la pantalla se llene
        padding: EdgeInsets.only(right: 15.0, left: 15.0, top: 10, bottom: 15),
        child: Container(
          child: Center(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Text(
                    "Alerta",
                    style: TextStyle(
                        fontSize: 36,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.normal),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: [
                        Text(
                          "Peso para la Edad (0 a 5 años)",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        _pesoParaEdad(),
                        SizedBox(height: 10.0),
                        Text(
                          "Longitud/Talla para la edad (0 a 5 años)",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        _alturaParaEdad(),
                        SizedBox(height: 10.0),
                        Text(
                          "Pesos para la longitud (Puntuación Z de 0 a 2 años)",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        _puntuacionZa2(),
                        SizedBox(height: 10.0),
                        Text(
                          "Pesos para la longitud (Puntuación Z de 3 a 5 años)",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        _puntuacionZ3a5(),
                        SizedBox(height: 10.0),
                        Text(
                          "Proxima evaluación:",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          CalculateDate().proximaCita(widget.edad),
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 24),
                        ),

                        /// _cita(),
                        SizedBox(height: 10.0),
                        Text(
                          "Basado en Estándares de crecimiento de la OMS 2006 ",
                          style: TextStyle(
                              fontSize: 8,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                        _submitResult(),
                        Text(
                          "Tratamiento",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(height: 5.0),
                        _tratamietno(),
                        SizedBox(height: 15.0),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//-------------------------- textField para los resultados -----------------------------------------
  Widget _pesoParaEdad() {
    return AppTextField(
      autoValidate: _autovalidate,
      validator: validateResult,
      controller: _pesoEdadController,
      textInputType: TextInputType.number,
      inputText: "Peso para la edad",
    );
  }

  Widget _alturaParaEdad() {
    return AppTextField(
      autoValidate: _autovalidate,
      validator: validateResult,
      controller: _longitudEdadController,
      textInputType: TextInputType.number,
      inputText: "Altura para la edad",
    );
  }

  Widget _puntuacionZa2() {
    return AppTextField(
      controller: _zde0a2Controller,
      validator: validateResult,
      textInputType: TextInputType.number,
      inputText: "Puntuación z de 0 a 2 años",
      autoValidate: _autovalidate,
    );
  }

  Widget _puntuacionZ3a5() {
    return AppTextField(
      controller: _zde3a5Controller,
      validator: validateResult,
      textInputType: TextInputType.number,
      inputText: "Puntuación z de 3 a 5 años",
      autoValidate: _autovalidate,
    );
  }

  Widget _tratamietno() {
    return AppTextField(
      autoValidate: _autovalidate,
      maxLines: true,
      inputText: "Tratamiento",
    );
  }

  Widget _submitResult() {
    return AppButton(
      nombre: "Aceptar",
      color: Colors.blueAccent,
      onPressed: () async {
        if (_formkey.currentState.validate()) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => NutriAlert()),
              (Route<dynamic> route) => false);

          _pesoEdadController.text = "";
          _longitudEdadController.text = "";
          _zde0a2Controller.text = "";
          _zde3a5Controller.text = "";
        } else {
          setState(() => _autovalidate = true);
        }

        //_pesoEdadController.dispose();
        //_longitudEdadController.dispose();
        //_zde0a2Controller.dispose();
        //_zde3a5Controller.dispose();
        //Navigator.pop(context);
      },
    );
  }
}
