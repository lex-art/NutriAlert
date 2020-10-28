import 'package:NutriAlert/src/algoritmos/boy/testNutritionalBoy.dart';
import 'package:NutriAlert/src/algoritmos/girl/testNutritionalGirl.dart';
import 'package:NutriAlert/src/algoritmos/interpretar_resul.dart';
import 'package:NutriAlert/src/algoritmos/proxima_cita.dart';
import 'package:NutriAlert/src/mixins/validationChild_mixins.dart';
import 'package:NutriAlert/src/screen/second_screen/storyChild_screen.dart';
import 'package:NutriAlert/src/service/child_Service.dart';
import 'package:NutriAlert/src/widgets/app_error_message.dart';
import 'package:NutriAlert/src/widgets/app_iconAlert.dart';
import 'package:NutriAlert/src/widgets/app_iconBoy.dart';
import 'package:NutriAlert/src/widgets/app_iconGirl.dart';
import 'package:flutter/material.dart';
import 'package:NutriAlert/src/widgets/app_button.dart';
import 'package:NutriAlert/src/widgets/app_textField.dart';

// ignore: must_be_immutable
class ResultTest extends StatefulWidget {
  final String idChild;
  final String edad;
  final String peso;
  final String altura;
  final String genero;
  String trata;

//---------------- Constructor de  este widget que son los datos del niño -----------------------------
  ResultTest({this.idChild, this.genero, this.edad, this.peso, this.altura});

  @override
  _ResultTestState createState() => _ResultTestState();
}

class _ResultTestState extends State<ResultTest> with ValidationChildMixins {
  bool _autovalidate = false;
  String _errorMessage = "";

  TextEditingController _pesoEdadController = TextEditingController();
  TextEditingController _longitudEdadController = TextEditingController();
  TextEditingController _zScoreController = TextEditingController();

  TextEditingController _trataController = TextEditingController();

  bool showSpinner = false;
  //un global key permite referenciar a un formulario y desde él tener accesos al estado de un textFormfield
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
    // Inicializando una clave global, ya que nos ayudaría a mostrar un SnackBar más tarde
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //longitud/estatura para la edad
  String lengthHeightForAge = "";
  //peso para la edad
  String weigthForAgeBirdTo5Year = "";
  //longitud/Estatura para el peso
  String zScore = "";
  int edad;
  int altura;
  double peso;
  int altura2;

  @override
  void initState() {
    super.initState();
    edad = int.parse(widget.edad);
    altura2 = int.parse(widget.altura);
    altura = int.parse(widget.altura);
    peso = double.parse(widget.peso);

//----------------------- verificamos que genero es para saber que tipo de evaluacion es el adecuado par ael niñ@ ---

    if (widget.genero == "Masculino") {
      lengthHeightForAge =
          TestNutritionalBoy().longitudEdadBirdTo2Year(edad, altura).toStringAsFixed(2);
      weigthForAgeBirdTo5Year =
          TestNutritionalBoy().pesoEdadBirdTo5Year(edad, peso).toStringAsFixed(2);
      //puntuacion z esta detecta si es menor a 2 años hace un examen diferente y si es de 2 a5 años, tambien hace otro examen
      zScore = TestNutritionalBoy().puntuacionZ(edad, altura2, peso).toStringAsFixed(2);
    }
    if (widget.genero == "Femenino") {
      lengthHeightForAge =
          TestNutritionalGirl().longitTallaParaEdadGirl(edad, altura).toStringAsFixed(2);
      weigthForAgeBirdTo5Year = TestNutritionalGirl().pesoEdad(edad, peso).toStringAsFixed(2);
      zScore = TestNutritionalGirl().puntuacionZ(edad, altura2, peso).toStringAsFixed(2);
    }

    if (zScore == "NaN" ||  weigthForAgeBirdTo5Year == "NaN"  || lengthHeightForAge == "Infinity") {
      _pesoEdadController =
          TextEditingController(text: "Error en los datos ingresados");
      _longitudEdadController =
          TextEditingController(text: "Error en los datos ingresados");
      _zScoreController =
          TextEditingController(text: "Error en los datos ingresados");
    } else {
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
                Resultados()
                    .longitudTallaEdad(double.parse(lengthHeightForAge)));
        _zScoreController = TextEditingController(
            text: "z = " +
                zScore +
                ", " +
                Resultados().pesoLongitudTallaZScore(double.parse(zScore)));
      });
    }
    _trataController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _pesoEdadController.dispose();
    _longitudEdadController.dispose();
    _trataController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int meses = int.parse(widget.edad);
    return Scaffold(
      key: _scaffoldKey,
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
                        _pesoParaEdad(),
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
                        SizedBox(height: 10.0),
                        Text(
                          "Basado en Estándares de crecimiento de la OMS 2006 ",
                          style: TextStyle(
                              fontSize: 8,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                        _submitResult(),
                         _showErrorMessage(),
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

  Widget _tratamietno() {
    return AppTextField(      
      autoValidate: _autovalidate,
      maxLines: true,
      inputText: "Tratamiento",
    );
  }

  Widget _submitResult() {
    return AppButton(
      nombre: "Guardar",
      color: Colors.blueAccent,
      onPressed: () async {
        if (_formkey.currentState.validate()) {
          String id = widget.idChild;
          if (zScore == "NaN") {
            show('No se puede guardar los datos');
          } else {
//---------------------- Guardamos el historial del niño ---------------------------------
            var saveStory = await ChildService().saveStorychild(
                collectionName: "niños/$id/historial",
                collectionValues: {
                  'edad': widget.edad,
                  'fecha': CalculateDate().fechaActual(),
                  'longitud': widget.altura,
                  'longTallaEdad': lengthHeightForAge,
                  'estadoLongTalla': Resultados()
                      .longitudTallaEdad(double.parse(lengthHeightForAge)),
                  'peso': widget.peso,
                  'pesoEdad': weigthForAgeBirdTo5Year,
                  'estadoPeso': Resultados()
                      .pesoEdad(double.parse(weigthForAgeBirdTo5Year)),
                  'proximaCita': CalculateDate().proximaCita(widget.edad),
                  'tratamiento': _trataController.text,
                  'z2ages': edad <= 24 ? zScore : "",
                  'z5ages': edad > 24 ? zScore : "",
                  'estadoZScore': Resultados()
                      .pesoLongitudTallaZScore(double.parse(zScore)),
                });

//----------------- ahora tenemos que actualizar el registro del niño --------------------
            if (saveStory.success) {
              var update = await ChildService().updateRecordChild(
                  collectionName: "niños",
                  id: id,
                  collectionValues: {
                    'edadMeses': widget.edad,
                    'estado': Resultados()
                        .pesoLongitudTallaZScore(double.parse(zScore)),
                    'proxCita': CalculateDate().proximaCita(widget.edad),
                  });
              if (update.success) {
                Navigator.of(context).push(MaterialPageRoute<Null>(
                    builder: (BuildContext context) => StoryChild(
                          id: id,
                          pantallaTest: true,
                        )));
                //Navigator.pushNamed(context, '/nutriAlert');
              }
            }
            _pesoEdadController.text = "";
            _longitudEdadController.text = "";
            _zScoreController.text = "";
            _trataController.text = "";
          }
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
   // Método para mostrar un Snackbar,
  // tomando el mensaje como texto
  //Metodo para motrar snackBar inferiror con mejsaje de texto
  Future show(
    String mensaje, {
    Duration duration: const Duration(seconds: 3),
  }) async {
    await new Future.delayed(new Duration(milliseconds: 100));
    _scaffoldKey.currentState.showSnackBar(
      new SnackBar(
        content: new Text(
          mensaje,
        ),
        duration: duration,
      ),
    );
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
