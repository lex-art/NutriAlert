import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:NutriAlert/src/algoritmos/proxima_cita.dart';
import 'package:NutriAlert/src/mixins/validationChild_mixins.dart';
import 'package:NutriAlert/src/screen/second_screen/result_test_release.dart';
import 'package:NutriAlert/src/widgets/app_error_message.dart';
import 'package:flutter/material.dart';
import 'package:NutriAlert/src/widgets/app_button.dart';
import 'package:NutriAlert/src/widgets/app_flatButton.dart';
import 'package:NutriAlert/src/widgets/app_textField.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class TestNutritionalRelease extends StatefulWidget {
  //nombre de la ruta
  static const String routName = "/test";
  @override
  _TestNutritionalStateRelease createState() => _TestNutritionalStateRelease();
}


class _TestNutritionalStateRelease extends State<TestNutritionalRelease>
    with ValidationChildMixins {
//--------------------------- codigo Bluetooth ----------------------------------
  //Inicializando el estado de la conexión Bluetooth para un disp. desconocido
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  // Inicializando una clave global, ya que nos ayudaría a mostrar un SnackBar más tarde
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //Obtener la instancia de Bluetooth
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  //Rastrea la conexión Bluetooth con el dispositivo remoto
  BluetoothConnection connection;

  int _deviceState;
  bool isConnecting = true;

  bool isDisconnecting = false;

  Map<String, Color> colors = {
    'onBorderColor': Colors.green,
    'offBorderColor': Colors.red,
    'neutralBorderColor': Colors.transparent,
    'onTextColor': Colors.green[700],
    'offTextColor': Colors.red[700],
    'neutralTextColor': Colors.blue,
  };

// Para rastrear si el dispositivo todavía está conectado a Bluetooth
  bool get isConnected => connection != null && connection.isConnected;

  //Defina algunas variables, que serán necesarias más adelante
  List<BluetoothDevice> _devicesList = [];
  BluetoothDevice _device;
  bool _connected = false;
  bool _isButtonUnavailable = false;

//------------------------------------------------------------------------------
  bool showSpinner = false;
  FocusNode _focusNode;
  //un global key permite referenciar a un formulario y desde él tener accesos al estado de un textFormfield
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  //tipo de teclado

  //seteamos el autovalidate
  bool _autovalidate = false;
  String _errorMessage = "";
  String _datoRecividoBlue = "";

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

  String _messageBuffer = '';
  bool state = false;
  @override
  void initState() {
    super.initState();

  _nombreController = TextEditingController();
  _edadController = TextEditingController();
  _pesoController = TextEditingController();
  _alturaController = TextEditingController();

//--------------------------- codigo Bluetooth ----------------------------------
    //Obtener el estado actual
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    _deviceState = 0; // neutral

    // Si el bluetooth del dispositivo no está habilitado,
    // luego solicita permiso para encender bluetooth
    // cuando se inicia la aplicación
    //enableBluetooth();

    // Listen for further state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
        if (_bluetoothState == BluetoothState.STATE_OFF) {
          _isButtonUnavailable = true;
        }
        getPairedDevices();
      });
    });
    //--------------------------------------------------------------------------------
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

  //--------------------------- codigo Bluetooth ----------------------------------
  // Solicitar permiso de Bluetooth del usuario
  Future<void> enableBluetooth() async {
    // Recuperando el estado actual de Bluetooth
    _bluetoothState = await FlutterBluetoothSerial.instance.state;

    // Si el bluetooth está apagado, enciéndalo primero
    //y luego recupere los dispositivos que están emparejados.
    if (_bluetoothState == BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
      await getPairedDevices();
      return true;
    } else {
      await getPairedDevices();
    }
    return false;
  }

  // Para recuperar y almacenar los dispositivos emparejados
  //  en una lista.
  Future<void> getPairedDevices() async {
    List<BluetoothDevice> devices = [];

    // Para obtener la lista de dispositivos emparejados
    try {
      devices = await _bluetooth.getBondedDevices();
    } on PlatformException {
      print("Error");
    }

    //Es un error llamar a [setState] a menos que [mounted] sea verdadero.
    if (!mounted) {
      return;
    }

    // Almacena la lista de [dispositivos] en [_devicesList] para acceder
    // la lista fuera de esta clase
    setState(() {
      _devicesList = devices;
    });
  }

//-----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:
          _scaffoldKey, //Key es un identificador para Widgets, Elements y SemanticNodes. un widget solo sera utilizado para actualizar un elemento existente si su key es el mismo que el widget asociado actualmente con el elemento.
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
              Visibility(
                visible: _isButtonUnavailable &&
                    _bluetoothState == BluetoothState.STATE_ON,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.yellow,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
              //todos los widget de la pantalla
              Row(
                //------------------------------- Encender Bluetooth -------------------------------------
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text("Encender Bluetooth"),
                  Switch(
                    value: _bluetoothState.isEnabled,
                    onChanged: (bool value) {
                      future() async {
                        if (value) {
                          // Habilitar Bluetooth
                          await FlutterBluetoothSerial.instance.requestEnable();
                        } else {
                          // Desactivar Bluetooth
                          await FlutterBluetoothSerial.instance
                              .requestDisable();
                        }
                        // Para actualizar la lista de dispositivos
                        await getPairedDevices();
                        _isButtonUnavailable = false;

                        // Desconectarse de cualquier dispositivo antes
                        // apagar Bluetooth
                        if (_connected) {
                          _disconnect();
                        }
                      }

                      future().then((_) {
                        setState(() {});
                      });
                    },
                  )
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
                            items: _getDeviceItems(),
                            onChanged: (value) =>
                                setState(() => _device = value),
                            value: _devicesList.isNotEmpty ? _device : null,
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
                          ),
                          _configuracionBt()
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
      nombre: _connected ? 'Desconectar' : 'Conectar',
      icon: Icon(
        Icons.bluetooth_searching,
        color: Colors.white,
      ),
      color: Colors.blue,
      onPressed:
          _isButtonUnavailable ? null : _connected ? _disconnect : _connect,
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
      onPressed: () async {
        // Entonces, cuando se emparejan nuevos dispositivos
        // mientras la aplicación se está ejecutando, el usuario puede actualizar
        // la lista de dispositivos emparejados.
        await getPairedDevices().then((_) {
          show("Se actualizó la lista de dispositivos");
        });
      },
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
      onPressed: _connected ? _sendPesoToBluetooth : null,
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
      onPressed: _connected ? _sendAlturaBluetooth : null,
    );
  }

  Widget _configuracionBt() {
    return AppButton(
      nombre: "Conf. Bluetooth",
      color: Colors.deepOrangeAccent,
      onPressed: () {
        FlutterBluetoothSerial.instance.openSettings();
      },
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
      validator: validarAltura,
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

  void actualizarPeso(String peso) {
    setState(() {
      _pesoController.text = peso;
    });
  }

  void actualizarAltura(String altura) {
    setState(() {
      _alturaController.text = altura;
    });
  }

  //un widget para mostrar el error de firebase
  Widget _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return ErrorMessage(errorMessage: _errorMessage);
    } else {
      return Container(height: 0.0);
    }
  }

  // --------------------------------- codigo del bluetotooth --------------------------------

  // Cree la lista de dispositivos que se mostrarán en el menú desplegable
  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devicesList.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('Ninguno'),
      ));
    } else {
      _devicesList.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name),
          value: device,
        ));
      });
    }
    return items;
  }

  // Method to connect to bluetooth
  void _connect() async {
    setState(() {
      _isButtonUnavailable = true;
    });
    if (_device == null) {
      show('Ningún dispositivo seleccionado');
    } else {
      // Si se selecciona un dispositivo del
      // menú desplegable, luego úsalo aquí

      // Asegurándose de que el dispositivo no esté conectado
      if (!isConnected) {
        // Intentando conectarse al dispositivo usando
        // su dirección
        await BluetoothConnection.toAddress(_device.address)
            .then((_connection) {
          print('Conectado al dispositivo');
          connection = _connection;
          // Actualización de la conectividad del dispositivo
          // estado a [true]
          setState(() {
            _connected = true;
          });
          // Esto es para rastrear cuando el proceso de desconexión
          // está en progreso que usa la variable [isDisconnecting]
          // definido antes.
          // Siempre que hacemos una llamada de desconexión, esto [onDone]
          // se activa el método.
          connection.input.listen(_onDataReceived).onDone(() {
            if (isDisconnecting) {
              print('!Desconectando localmente!');
            } else {
              print('¡Desconectado de forma remota!');
            }
            if (this.mounted) {
              setState(() {});
            }
          });
        }).catchError((error) {
          print('No se puede conectar, se produjo una excepción');
          print(error);
        });
        show('Dispositivo conectado');

        setState(() => _isButtonUnavailable = false);
      }
    }
  }

//-------------------------- funcion para recibir datos ----------------------
  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Aplicar control de retroceso
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        _datoRecividoBlue = backspacesCounter > 0
            ? _messageBuffer.substring(
                0, _messageBuffer.length - backspacesCounter)
            : _messageBuffer + dataString.substring(0, index);

        /*
        messages.add(
          _Message(
            1,
            backspacesCounter > 0
                ? _messageBuffer.substring(
                    0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );*/
        print(_datoRecividoBlue);
        _messageBuffer = dataString.substring(index);
        if (_datoRecividoBlue.contains('k')) {
          actualizarPeso(
              _datoRecividoBlue.replaceFirst("\n", "").replaceAll("k", ""));
        } else {
          actualizarAltura(_datoRecividoBlue.replaceFirst("\n", ""));
        }

        print(_datoRecividoBlue);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

  //Método para desconectar bluetooth
  void _disconnect() async {
    setState(() {
      _isButtonUnavailable = true;
      _deviceState = 0;
    });
    // Cerrar la conexión Bluetooth
    await connection.close();
    show('Dispositivo desconectado');
    // Actualiza la variable [_connected]
    if (!connection.isConnected) {
      setState(() {
        _connected = false;
        _isButtonUnavailable = false;
      });
    }
  }

  // Método para enviar mensaje,
  // para encender el dispositivo Bluetooth
  void _sendPesoToBluetooth() async {
    connection.output.add(utf8.encode("0"));
    await connection.output.allSent;
    show('Obteniendo Peso...');
    setState(() {
      // print("$pesos ---------------");
      _deviceState = 1; // device on
    });
    // ignore: unnecessary_statements
  }

  // Método para enviar mensaje,
  // para apagar el dispositivo Bluetooth
  void _sendAlturaBluetooth() async {
    connection.output.add(utf8.encode('1'));
    await connection.output.allSent;

    show('Obteniendo altura...');
    setState(() {
      _deviceState = 1;
    });
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
}

// ---------------------------------  terminadel bluetotooth --------------------------------
