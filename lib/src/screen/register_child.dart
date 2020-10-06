import 'package:NutriAlert/src/mixins/validationChild_mixins.dart';
import 'package:NutriAlert/src/service/child_Service.dart';
import 'package:NutriAlert/src/widgets/app_error_message.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:NutriAlert/src/widgets/app_button.dart';
import 'package:NutriAlert/src/widgets/app_textField.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegisterChildren extends StatefulWidget {
  //nombre de la ruta
  static const String routName = "/register";
  @override
  _RegisterChildrenState createState() => _RegisterChildrenState();
}

class _RegisterChildrenState extends State<RegisterChildren>
    with ValidationChildMixins {
       //seteamos el autovalidate
  bool _autovalidate = false;
  String _errorMessage = "";
  //obtenemos la fecha del sistema
  var now = DateTime.now().toUtc().toLocal();
  //------variables para las textxt field y botones
  bool showSpinner = false;
  FocusNode _focusNode;
  //un global key permite referenciar a un formulario y desde él tener accesos al estado de un textFormfield
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  //tipo de teclado
  TextInputType textInputType;
  //para manejar el estado de los text field y poder limpiar el texto
  TextEditingController _cuiController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _secondController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _birthController = TextEditingController();
  TextEditingController _nameMotherController = TextEditingController();
  TextEditingController _nameFatherController = TextEditingController();
  TextEditingController _numberPhoneController = TextEditingController();
  TextEditingController _numberHouseController = TextEditingController();
  TextEditingController _numberSectorController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
 

  //-------------- constructor de la app --------------
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    _cuiController = TextEditingController();
    _nameController = TextEditingController();
    _secondController = TextEditingController();
    _ageController = TextEditingController();
    _birthController = TextEditingController();
    _nameMotherController = TextEditingController();
    _numberPhoneController = TextEditingController();
    _numberHouseController = TextEditingController();
    _numberSectorController = TextEditingController();
    _addressController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _cuiController.dispose();
    _nameController.dispose();
    _secondController.dispose();
    _birthController.dispose();
    _nameMotherController.dispose();
    _numberPhoneController.dispose();
    _numberHouseController.dispose();
    _numberSectorController.dispose();
    _addressController.dispose();
  }

  //metodo para la barra de progreso
  void setSpinnerStatus(bool status) {
    //re-renderizar la app para que muestre el progres bar
    setState(() {
      showSpinner = status;
    });
  }

  //datos para la lista desplegable ** modificar depues
  var _genero = ["Masculino", "Femenino"];
  var _comunidad = ["Maya", "Mestizo", "Garífuna", "Xinca", "Otro"];
  String _selectGenero = "Seleccione una opción";
  String _selectComunidad = "Seleccione una opción";

  DateTime _dateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: AppBar(
            //pone de color blanco a todos los iconos del appBar
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              "Registrar niño",
              style: TextStyle(color: Colors.white),
            )),
        //SingleChildScrollView siver para un srcoll de la pahg cuando se llene
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 30, right: 30, top: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nuevo registro",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "${formatDate(now, [d, '-', M, '-', yyyy])}",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  ),
                  //------------------ Formulario para crear un nuevo registro de un niño --------------
                  Form(
                      key: _formkey,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              _cui(),
                              SizedBox(height: 15.0),
                              _name(),
                              SizedBox(height: 15.0),
                              _secondName(),
                              SizedBox(height: 15.0),
                              _age(),
                              SizedBox(height: 15.0),
                              RaisedButton.icon(
                                  onPressed: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: _dateTime == null
                                                ? DateTime.now()
                                                    .toUtc()
                                                    .toLocal()
                                                : _dateTime,
                                            firstDate: DateTime(2010),
                                            lastDate: DateTime(2050))
                                        .then((date) {
                                      setState(() {
                                        _dateTime = date;
                                      });
                                    });
                                  },
                                  icon: Icon(
                                    Icons.date_range,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    "Nacimiento",
                                    style: TextStyle(color: Colors.white),
                                  )),
                              SizedBox(height: 15.0),
                              Material(
                                color: Colors.white,
                                //elevation: 0,
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
                                        hint: Text(_selectGenero),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.0),
                              _nameMother(),
                              SizedBox(height: 15.0),
                              _nameFather(),
                              SizedBox(height: 15.0),
                              _numberHouse(),
                              SizedBox(height: 15.0),
                              _numberPhone(),
                              SizedBox(height: 15.0),
                              _numberSector(),
                              SizedBox(height: 15.0),
                              _address(),
                              SizedBox(height: 15.0),
                              Material(
                                color: Colors.white,
                                //elevation: 0,
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
                                        items: _comunidad.map((String a) {
                                          return DropdownMenuItem(
                                              value: a, child: Text(a));
                                        }).toList(),
                                        onChanged: (_value) => {
                                          setState(() {
                                            _selectComunidad = _value;
                                          }),
                                        },
                                        hint: Text(_selectComunidad),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              _showErrorMessage(),
                              _submitRegister()
                            ]),
                      ))
                ],
              )),
        ));
  }

  /// TextFiel para el formulario ára crear un nuevo niño
  Widget _cui() {
    return AppTextField(
      focusNode: _focusNode,
      controller: _cuiController,
      autoValidate: _autovalidate,
      validator: validateCui,
      inputText: "Ingrese CUI",
      textInputType: TextInputType.number, //tipo de teclado
      onSaved: (value) {},
    );
  }

  Widget _name() {
    return AppTextField(
      controller: _nameController,
      autoValidate: _autovalidate,
      validator: validateName,
      inputText: "Nombre del niñ@",
      onSaved: (value) {},
    );
  }

  Widget _secondName() {
    return AppTextField(
      controller: _secondController,
      autoValidate: _autovalidate,
      validator: validateApe,
      inputText: "Apellido del niñ@",
      onSaved: (value) {},
    );
  }

  Widget _age() {
    return AppTextField(
      controller: _ageController,
      autoValidate: _autovalidate,
      validator: validateAge,
      inputText: "Edad en Meses",
      onSaved: (value) {},
    );
  }



  Widget _nameMother() {
    return AppTextField(
      controller: _nameMotherController,
      validator: validateMother,
      autoValidate: _autovalidate,
      inputText: "Nombre de la madre o responsable",
      onSaved: (value) {},
    );
  }

  Widget _nameFather() {
    return AppTextField(
      controller: _nameFatherController,
      autoValidate: _autovalidate,
      inputText: "Nombre del padre",
      onSaved: (value) {},
    );
  }

  Widget _numberPhone() {
    return AppTextField(
      controller: _numberPhoneController,
      autoValidate: _autovalidate,
      inputText: "Numero de teléfono",
      textInputType: TextInputType.number,
      onSaved: (value) {},
    );
  }

  Widget _numberHouse() {
    return AppTextField(
      controller: _numberHouseController,
      autoValidate: _autovalidate,
      inputText: "Número de casa",
      textInputType: TextInputType.number,
      onSaved: (value) {},
    );
  }

  Widget _numberSector() {
    return AppTextField(
      controller: _numberSectorController,
      autoValidate: _autovalidate,
      inputText: "Numero de sector",
      onSaved: (value) {},
    );
  }

  Widget _address() {
    return AppTextField(
      controller: _addressController,
      autoValidate: _autovalidate,
      inputText: "Dirección",
      onSaved: (value) {},
    );
  }

  Widget _submitRegister() {
    return AppButton(
      color: Colors.blueAccent,
      nombre: "Crear Registro",
      onPressed: () async {

        if (_formkey.currentState.validate()) {
          //cuando se incia el procesos de auntenricacion llamamos al metodo que hara el progress bar
          //para inciarlo
          setSpinnerStatus(true);
          //aqui validamos  el usuario en firebase
          var child = await ChildService()
              .saveChild(collectionName: "niños", collectionValues: {
            "fechaRegistro": formatDate(now, [d, '-', m, '-', yyyy]),
            "cui": _cuiController.text,
            "nombres": _nameController.text,
            "apellidos": _secondController.text,
            "nacimiento": formatDate(_dateTime, [d, '-', M, '-', yyyy]),
            "genero": _selectGenero,
            "edad": _ageController.text,
            "madre": _nameMotherController.text,
            "padre": _nameFatherController.text,
            "noCasa": _numberHouseController.text,
            "noCel": _numberPhoneController.text,
            "noSector": _numberSectorController.text,
            "direccion": _addressController.text,
            "pueblo": _selectComunidad,
            "estado": "Sin Evaluar",
          });
          //si es distinto a nul entonces el usuario existe
          if (child.success) {
            //si el logueo es exitosos entra aqui
           Navigator.pushNamed(context, '/nutriAlert');
           
            FocusScope.of(context).requestFocus(_focusNode);

            _cuiController.text = "";
            _nameController.text = "";
            _secondController.text = "";
            _ageController.text = "";
            _birthController.text = "";
            _nameMotherController.text = "";
            _nameFatherController.text = "";
            _numberHouseController.text = "";
            _numberHouseController.text = "";
            _numberPhoneController.text = "";
            _numberSectorController.text = "";
            _addressController.text = "";
           
          
          } else {
            //si no es exitoso entra en esta parte, donde muestra el error en un widget
            setState(() {
              _errorMessage = child.errorMenssage;
            });
          }
          //cuando termine el proceso de auntenticaion se cierrar la barra de progreso
          setSpinnerStatus(false);
        } else {
          ///si cambia el error debemos de re-renderizar la pantalla, para quitar el autrovalidate
          ///en false para pasarlo a true
          setState(() =>  _autovalidate  = true);
        }
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
