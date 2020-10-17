import 'package:NutriAlert/src/mixins/validationChild_mixins.dart';
import 'package:NutriAlert/src/screen/test_screen/result_test.dart';
import 'package:NutriAlert/src/widgets/app_error_message.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:NutriAlert/src/widgets/app_button.dart';
import 'package:NutriAlert/src/widgets/app_flatButton.dart';
import 'package:NutriAlert/src/widgets/app_textField.dart';

class TestNutritional extends StatefulWidget {
  //parametros para iniciar el test
  final String id, nombre, edad, genero;
  TestNutritional({this.id, this.nombre, this.edad, this.genero});
  @override
  _TestNutritionalState createState() => _TestNutritionalState();
}

class _TestNutritionalState extends State<TestNutritional>
    with ValidationChildMixins {
  bool showSpinner = false;
  FocusNode _focusNode;
  //un global key permite referenciar a un formulario y desde él tener accesos al estado de un textFormfield
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  //tipo de teclado

  //seteamos el autovalidate
  bool _autovalidate = false;
  String _errorMessage = "";

  TextEditingController _edadController = TextEditingController();
  TextEditingController _pesoController = TextEditingController();
  TextEditingController _alturaController = TextEditingController();

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
    _edadController = TextEditingController();
    _pesoController = TextEditingController();
    _alturaController = TextEditingController();
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
                                    _nombre(),
                                    _edad(),
                                    SizedBox(height: 10.0),
                                    Text(
                                      "Edad actual del niño(a):",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(height: 3.0),
                                    _edadTexField(),
                                    _showErrorMessage(),
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
    return Text(
      widget.nombre,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }

  Widget _edad() {
    return Text(
      "Edad registrada: " + widget.edad + " Meses",
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _edadTexField() {
    return AppTextField(
      focusNode: _focusNode,
      controller: _edadController,
      autoValidate: _autovalidate,
      validator: validateAge,
      inputText: "Edad en Meses",
      textInputType: TextInputType.number,
    );
  }

  Widget _pesoTexField() {
    return AppTextField(
      controller: _pesoController,
      autoValidate: _autovalidate,
      validator: validateTest,
      inputText: "Peso(Kg)",
      textInputType: TextInputType.number,
    );
  }

  Widget _alturaTextField() {
    return AppTextField(
      controller: _alturaController,
      autoValidate: _autovalidate,
      validator: validateTest,
      inputText: "Longitud/Talla(Cm)",
      textInputType: TextInputType.number,
    );
  }

  Widget _fecha() {
    return Text(
      formatDate(now, [d, '-', M, '-', yyyy]),
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    );
  }

  Widget _evalar() {
    return AppButton(
      nombre: "Evaluar",
      color: Colors.blueAccent,
      onPressed: () {
        if (int.parse(_edadController.text) <= int.parse(widget.edad)) {
          _errorMessage = "La edad no puede ser menor o igual a la actual";
          setState(() {
            _showErrorMessage();
          });
        } else {  
          _errorMessage = "";        
          if (_formkey.currentState.validate()) {  
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ResultTest(
                          idChild: widget.id,
                          genero: widget.genero,
                          edad: _edadController.text,
                          peso: _pesoController.text,
                          altura: _alturaController.text,
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
