import 'package:NutriAlert/src/algoritmos/boy/testNutritionalBoy.dart';
import 'package:NutriAlert/src/algoritmos/girl/testNutritionalGirl.dart';
import 'package:NutriAlert/src/algoritmos/interpretar_resul.dart';
import 'package:NutriAlert/src/algoritmos/proxima_cita.dart';
import 'package:NutriAlert/src/mixins/validationChild_mixins.dart';
import 'package:NutriAlert/src/widgets/app_iconAlert.dart';
import 'package:NutriAlert/src/widgets/app_iconBoy.dart';
import 'package:NutriAlert/src/widgets/app_iconGirl.dart';
import 'package:flutter/material.dart';
import 'package:NutriAlert/src/widgets/app_button.dart';
import 'package:NutriAlert/src/widgets/app_textField.dart';

// ignore: must_be_immutable
class ResultTestRelease extends StatefulWidget {
  final String edad;
  final String peso;
  final String altura;
  final String genero;

  //nombre de la ruta
  static const String routName = "/result";

//---------------- Constructor de  este widget que son los datos del niño -----------------------------
  ResultTestRelease({this.edad, this.peso, this.altura, this.genero});

  @override
  _ResultTestStateRelease createState() => _ResultTestStateRelease();
}

class _ResultTestStateRelease extends State<ResultTestRelease>
    with ValidationChildMixins {
  bool _autovalidate = false;

  TextEditingController _pesoEdadController = TextEditingController();
  TextEditingController _longitudEdadController = TextEditingController();
  TextEditingController _zScoreController = TextEditingController();

  bool showSpinner = false;
  //un global key permite referenciar a un formulario y desde él tener accesos al estado de un textFormfield
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  //longitud/estatura para la edad
  String lengthHeightForAge = "";
  //peso para la edad
  String weigthForAgeBirdTo5Year = "";
  //longitud/Estatura para el peso
  String zScore = "";
  int edad;
  double altura;
  double peso;
  int altura2;

  @override
  void initState() {
    super.initState();
    edad = int.parse(widget.edad);
    altura2 = int.parse(widget.altura);
    altura = double.parse(widget.altura);
    peso = double.parse(widget.peso);

//----------------------- verificamos que genero es para saber que tipo de evaluacion es el adecuado par ael niñ@ ---
    if (widget.genero == "Masculino") {
      lengthHeightForAge =
          TestNutritionalBoy().longitudEdadBirdTo2Year(edad, altura);
      weigthForAgeBirdTo5Year =
          TestNutritionalBoy().pesoEdadBirdTo5Year(edad, peso);
      //puntuacion z esta detecta si es menor a 2 años hace un examen diferente y si es de 2 a5 años, tambien hace otro examen
      zScore = TestNutritionalBoy().puntuacionZ(edad, altura2, peso);
    }
    if (widget.genero == "Femenino") {
      lengthHeightForAge =
          TestNutritionalGirl().longitTallaParaEdadGirl(edad, altura);
      weigthForAgeBirdTo5Year = TestNutritionalGirl().pesoEdad(edad, peso);
      zScore = TestNutritionalGirl().puntuacionZ(edad, altura2, peso);
    }

    setState(() {
      //----------------------------- Imprimimos los resultados en pantalla ---------------------------------
      _pesoEdadController = TextEditingController(
          text: "z = " +
              weigthForAgeBirdTo5Year +
              ", " +
              Resultados().pesoEdad(double.parse(weigthForAgeBirdTo5Year)));
      _longitudEdadController = TextEditingController(
          text: "z = " +
              lengthHeightForAge +
              ", " +
              Resultados().longitudTallaEdad(double.parse(lengthHeightForAge)));
      _zScoreController = TextEditingController(
          text: "z = " +
              zScore +
              ", " +
              Resultados().pesoLongitudTallaZScore(double.parse(zScore)));
    });
  }

  @override
  Widget build(BuildContext context) {
    int meses = int.parse(widget.edad);
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
                  widget.genero == "Masculino" ? AppBoy() : AppGirl(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppIconAlert(),
                      Text(
                        " ${Resultados().pesoLongitudTallaZScore(double.parse(zScore))}",
                        style: TextStyle(
                            fontSize: 36,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
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
                        Column(
                          verticalDirection: VerticalDirection.down,
                          children: [
                            _pesoParaEdad(),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          meses < 24
                              ? "Longitud para la edad (Puntuación Z de 0 a 2 años)"
                              : "Talla para la edad (Puntuación Z de 2 a 5 años)",
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
                          meses < 24
                              ? "Peso para la longitud (Puntuación Z de 0 a 2 años)"
                              : "Peso para la talla (Puntuación Z de 2 a 5 años)",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        _puntuacionZ(),
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

                        
                        SizedBox(height: 5.0),
                        Text(
                          "Basado en Estándares de crecimiento de la OMS 2006 ",
                          style: TextStyle(
                              fontSize: 8,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                        _submitResult(),
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
      controller: _pesoEdadController,
      validator: validateResult,
      autoValidate: _autovalidate,
      inputText: "Peso para la edad",
      textInputType: TextInputType.number,
      onSaved: (value) {},
    );
  }

  Widget _alturaParaEdad() {
    return AppTextField(
      autoValidate: _autovalidate,
      validator: validateResult,
      controller: _longitudEdadController,
      textInputType: TextInputType.number,
      inputText: "Altura para la edad",
      onSaved: (value) {},
    );
  }

  Widget _puntuacionZ() {
    return AppTextField(
      controller: _zScoreController,
      validator: validateResult,
      textInputType: TextInputType.number,
      inputText: int.parse(widget.edad) < 24
          ? "Puntuación Z de 0 a 2 años"
          : "Puntuación Z de 2 a 5 años",
      autoValidate: _autovalidate,
      onSaved: (value) {},
    );
  }

  Widget _submitResult() {
    return AppButton(
      nombre: "Aceptar",
      color: Colors.blueAccent,
      onPressed: () {
        Navigator.pushNamed(context, '/nutriAlert');

        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => NutriAlert()),
        //     (Route<dynamic> route) => false);

        //_pesoEdadController.dispose();
        //_longitudEdadController.dispose();
        //_zde0a2Controller.dispose();
        //_zde3a5Controller.dispose();
        //Navigator.pop(context);
      },
    );
  }
}
