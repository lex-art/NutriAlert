import 'package:NutriAlert/src/algoritmos/proxima_cita.dart';
import 'package:NutriAlert/src/mixins/validationChild_mixins.dart';
import 'package:NutriAlert/src/screen/second_screen/result_test_release.dart';
import 'package:NutriAlert/src/widgets/app_error_message.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:NutriAlert/src/widgets/app_button.dart';
import 'package:NutriAlert/src/widgets/app_flatButton.dart';
import 'package:NutriAlert/src/widgets/app_textField.dart';

class TestNutritionalRelease extends StatefulWidget {
  //nombre de la ruta
  static const String routName = "/test";
  @override
  _TestNutritionalStateRelease createState() => _TestNutritionalStateRelease();
}

class _TestNutritionalStateRelease extends State<TestNutritionalRelease>
    with ValidationChildMixins {
  bool showSpinner = false;
  FocusNode _focusNode;
  //un global key permite referenciar a un formulario y desde él tener accesos al estado de un textFormfield
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  //tipo de teclado

  //seteamos el autovalidate
  bool _autovalidate = false;
  String _errorMessage = "";

  var _genero = ["Masculino", "Femenino"];
  String _selectGenero = "Seleccione una opción";

  TextEditingController _nombreController = TextEditingController();
  TextEditingController _edadController = TextEditingController();
  TextEditingController _pesoController = TextEditingController();
  TextEditingController _alturaController = TextEditingController();
  TextEditingController _fechaController = TextEditingController();

  //obtenemos la fecha del sistema
  var now = DateTime.now().toUtc().toLocal();
  //variable para el switch encendido del bluetooth
  bool state = false;
  //datos para la lista desplegable ** modificar depues
  var _list = ["Masculino", "Femenino"];
  String _selection = "Seleccione una opción";
  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController();
    _edadController = TextEditingController();
    _pesoController = TextEditingController();
    _alturaController = TextEditingController();
    _fechaController =
        TextEditingController(text: formatDate(now, [d, '-', M, '-', yyyy]));
  }

  @override
  void dispose() {
    super.dispose();
    _nombreController.dispose();
    _edadController.dispose();
    _pesoController.dispose();
    _alturaController.dispose();
    _fechaController.dispose();
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
            "Evaluar estado nutricional",
            style: TextStyle(color: Colors.white),
          )),

      ///----------------------  Inicia el cuerpo de esta pantalla  -------------------
      body: SingleChildScrollView(
        //para que permita hacer scroll cuando la pantalla se llene
        padding: EdgeInsets.only(right: 15.0, left: 15.0),
        child: Container(
          alignment: AlignmentDirectional.topEnd,
          child: Column(
            //la columna que va a encapsular todo
            mainAxisSize: MainAxisSize.max, //aprovecha todo el espacio
            children: <Widget>[
              //todos los widget de la pantalla
              Row(
                //------------------------------- Encender Bluetooth -------------------------------------
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Encender Bluetooth"),
                  Switch(
                      //boton de encendido o apagado del bluetooth
                      value: state,
                      activeColor: Theme.of(context).buttonColor,
                      onChanged: (bool s) {
                        setState(() {
                          state = s;
                        });
                      })
                ],
              ),
              SizedBox(height: 8.0),
              Stack(
//---------------------------------- despues de enceder bluetooth -------------------------------------
                children: <Widget>[
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
//--------------------------- Seleccionar y boton desplegable de dispositivos--------------------------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Seleccionar"),
                          //boton lista desplegable **hay que cambiarlo depues
                          DropdownButton(
                            //mapeamos la lista, para poder usarla
                            items: _list.map((String val) {
                              return DropdownMenuItem(
                                  value: val, child: Text(val));
                            }).toList(),
                            onChanged: (_value) {
                              setState(() {
                                _selection = _value;
                              });
                            },
                            hint: Text(_selection),
                          ),
                        ],
                      ),
//---------------------------------- Botones Conectar y Actualziar------------------------------------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [_conectar(), _atualizar()],
                      ),
                      Card(
                        color: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: <Widget>[
//---------------------------------------- Cotones de Peso y Altura ------------------------------------
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [_peso(), _altura()],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 20,
                                left: 20,
                              ),
                              child: Form(
                                key: _formkey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Nombre del niño(a):",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(height: 3.0),
                                    _nombre(),
                                    SizedBox(height: 10.0),
                                    Text(
                                      "Seleccione el género del niño(a):",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Material(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        height: 35,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            DropdownButton(
                                              items: _genero.map((String a) {
                                                return DropdownMenuItem(
                                                    value: a, child: Text(a));
                                              }).toList(),
                                              onChanged: (_value) => {
                                                setState(() {
                                                  _selectGenero = _value;
                                                }),
                                              },
                                              hint: Text(_selectGenero,
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    _showErrorMessage(),
                                    SizedBox(height: 10.0),
                                    Text(
                                      "Edad del niño(a) en meses:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(height: 3.0),
                                    _edad(),
                                    SizedBox(height: 10.0),
                                    Text(
                                      "Peso del niño(a) en kg:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(height: 3.0),
                                    _pesoTexField(),
                                    SizedBox(height: 10.0),
                                    Text(
                                      "Longitud/Talla del niño(a) en cm:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(height: 3.0),
                                    _alturaTextField(),
                                    SizedBox(height: 10.0),
                                    _fecha(),
                                    _evalar(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              //----------------------------- Texto de aviso ---------------------------------

              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Nota: No es necesario conectarse al dispositivo Bluetooth, "
                            "puede llenar los campos de manera manual, introduciendo "
                            "los valores usted mismo.",
                            style: TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.normal,
                              color: Colors.black38,
                            ),
                            textAlign: TextAlign.justify,
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  ///------------------------ widgets de botnotes conectar y actualizar ------------------------------------
  Widget _conectar() {
    return AppFlatButton(
      nombre: "Conectar",
      icon: Icon(
        Icons.bluetooth_searching,
        color: Colors.white,
      ),
      color: Colors.blue,
      onPressed: () {},
    );
  }

  Widget _atualizar() {
    return AppFlatButton(
      nombre: "Actualziar",
      icon: Icon(
        Icons.refresh,
        color: Colors.white,
      ),
      color: Colors.green,
      onPressed: () {},
    );
  }

//------------------------------ Botones de peso y altura -------------------------------
  Widget _peso() {
    return AppFlatButton(
      nombre: "Peso",
      icon: Icon(
        Icons.accessibility,
        color: Colors.white,
      ),
      color: Colors.orange,
      onPressed: () {},
    );
  }

  Widget _altura() {
    return AppFlatButton(
      nombre: "Altura",
      icon: Icon(
        Icons.straighten,
        color: Colors.white,
      ),
      color: Colors.orange,
      onPressed: () {},
    );
  }

//----------------------------- TextFiel para los datos del niño ---------------------
  Widget _nombre() {
    return AppTextField(
      focusNode: _focusNode,
      controller: _nombreController,
      autoValidate: _autovalidate,
      inputText: "Nombre del niñ@",
    );
  }

  Widget _edad() {
    return AppTextField(
      controller: _edadController,
      validator: validateAge,
      autoValidate: _autovalidate,
      inputText: "Edad en meses",
      textInputType: TextInputType.number,
    );
  }

  Widget _pesoTexField() {
    return AppTextField(
      controller: _pesoController,
      autoValidate: _autovalidate,
      validator: validateTest,
      inputText: "Peso(kg)",
      textInputType: TextInputType.number,
    );
  }

  Widget _alturaTextField() {
    return AppTextField(
      controller: _alturaController,
      autoValidate: _autovalidate,
      validator: validateTest,
      inputText: "Longitud/Talla(cm)",
      textInputType: TextInputType.number,
    );
  }

  Widget _fecha() {
    return Text(
      CalculateDate().fechaActual(),
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    );
  }

  Widget _evalar() {
    return AppButton(
      nombre: "Evaluar",
      color: Colors.blueAccent,
      onPressed: () {
        if (_selectGenero == "Seleccione una opción") {
          setState(() {
            _errorMessage = "Seleccione un género correcto";
            _showErrorMessage();
          });
        } else {
          if (_formkey.currentState.validate()) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ResultTestRelease(
                          edad: _edadController.text,
                          peso: _pesoController.text,
                          altura: _alturaController.text,
                          genero: _selectGenero,
                        )));
          } else {
            ///si cambia el error debemos de re-renderizar la pantalla, para quitar el autrovalidate
            ///en false para pasarlo a true
            setState(() => _autovalidate = true);
          }
        }

        //Navigator.pushNamed(context, '/result');
      },
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
