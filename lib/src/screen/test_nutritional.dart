import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:NutriAlert/src/widgets/app_button.dart';
import 'package:NutriAlert/src/widgets/app_flatButton.dart';
import 'package:NutriAlert/src/widgets/app_textField.dart';

class TestNutritional extends StatefulWidget {
  //nombre de la ruta
  static const String routName = "/test";
  @override
  _TestNutritionalState createState() => _TestNutritionalState();
}

class _TestNutritionalState extends State<TestNutritional> {
  //obtenemos la fecha del sistema
  var now = DateTime.now().toUtc().toLocal();
  //variable para el switch encendido del bluetooth
  bool state = false;
  //datos para la lista desplegable ** modificar depues
  var _list = ["Masculino", "Femenino"];
  String _selection = "Seleccione una opción";

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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _nombre(),
                                  SizedBox(height: 10.0),
                                  _edad(),
                                  SizedBox(height: 10.0),
                                  _pesoTexField(),
                                  SizedBox(height: 10.0),
                                  _alturaTextField(),
                                  SizedBox(height: 10.0),
                                  _fecha(),
                                  _evalar(),
                                ],
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
      inputText: "Nombre del niñ@",
    );
  }

  Widget _edad() {
    return AppTextField(
      inputText: "Edad en meses",
      textInputType: TextInputType.number,
    );
  }

  Widget _pesoTexField() {
    return AppTextField(
      inputText: "Peso(Kg)",
      textInputType: TextInputType.number,
    );
  }

  Widget _alturaTextField() {
    return AppTextField(
      inputText: "Longitud/Talla(Cm)",
      textInputType: TextInputType.number,
    );
  }

  Widget _fecha() {
    return AppTextField(
      inputText: formatDate(now, [d, '-', M, '-', yyyy]),
      textInputType: TextInputType.datetime,
    );
  }

  Widget _evalar() {
    return AppButton(
      nombre: "Evaluar",
      color: Colors.blueAccent,
      onPressed: () {
        Navigator.pushNamed(context, '/result');
      },
    );
  }
}
