import 'package:flutter/material.dart';
import 'package:NutriAlert/src/widgets/app_button.dart';
import 'package:NutriAlert/src/widgets/app_textField.dart';

class ResultTest extends StatefulWidget {
  //nombre de la ruta
  static const String routName = "/result";
  @override
  _ResultTestState createState() => _ResultTestState();
}

class _ResultTestState extends State<ResultTest> {
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
                            color: Colors.white, fontWeight: FontWeight.normal,fontSize: 12,),
                      ),
                      SizedBox(height: 5.0),
                      _pesoParaEdad(),
                      SizedBox(height: 10.0),
                      Text(
                        "Longitud/Talla para la edad (0 a 5 años)",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.normal,fontSize: 12,),
                      ),
                      SizedBox(height: 5.0),
                      _alturaParaEdad(),
                      SizedBox(height: 10.0),
                      Text(
                        "Pesos para la longitud (Puntuación Z)",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.normal,fontSize: 12,),
                      ),
                      SizedBox(height: 5.0),
                      _puntuacionZ(),
                      SizedBox(height: 10.0),
                      Text(
                        "Proxima cita",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.normal,fontSize: 12,),
                      ),
                      SizedBox(height: 5.0),
                      _cita(),
                      SizedBox(height: 5.0),
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
                            color: Colors.white, fontWeight: FontWeight.normal),
                      ),
                      SizedBox(height: 5.0),
                      Tratamiento(),
                      SizedBox(height: 15.0),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

//-------------------------- textField para los resultados -----------------------------------------
  Widget _pesoParaEdad() {
    return AppTextField(
      inputText: "Peso Para la edad",
    );
  }

  Widget _alturaParaEdad() {
    return AppTextField(
      inputText: "Altura para la edad",
    );
  }

  Widget _puntuacionZ() {
    return AppTextField(
      inputText: "Puntuación z",
    );
  }

  Widget _cita() {
    return AppTextField(
      inputText: "Próxima Cita",
    );
  }

  Widget _submitResult() {
    return AppButton(
      nombre: "Guardar",
      color: Colors.blueAccent,
      onPressed: () {
        Navigator.pushNamed(context, "/story");
      },
    );
  }
}

class Tratamiento extends StatelessWidget {
  const Tratamiento({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //autovalidate: autoValidate,
      //focusNode: focusNode, //posiciona el cursor
      //controller: controller, //limpiar el texto3
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        ///tamaño del textDield
        isDense: true,
        contentPadding: EdgeInsets.all(35),
        //color de relleno
        filled: true,
        fillColor: Colors.white,

        ///tamaño del textField
        hintText: "Descripción",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          borderSide:
              BorderSide(color: Theme.of(context).buttonColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 1)),
      ),
      onSaved: (value) {}, //guarda lo que se intruduce en el textfield
      textAlign: TextAlign.center,
    );
  }
}
