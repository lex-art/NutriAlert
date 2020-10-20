import 'dart:async';
import 'dart:typed_data';
import 'dart:convert' show utf8;
import 'package:flutter/foundation.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothStore extends ChangeNotifier {
  var _instance = FlutterBluetoothSerial.instance;
  var _dataBuffer = '';

  void Function(String) _onDataCallback = (String data) {};

  StreamSubscription<Uint8List> _dataSubscription;
  StreamSubscription<BluetoothDiscoveryResult> _scannedDevicesSubscription;
  BluetoothDiscoveryResult _connectedDevice;
  BluetoothConnection _connection;

  var name = "...";
  var address = "...";
  var pinNum = "1234";

  var isScanning = false;
  var _isConnecting = false;
  var _autoPair = false;

  var scannedDevices = List<BluetoothDiscoveryResult>();
  var state = BluetoothState.UNKNOWN;

  BluetoothStore() {
    initBluetooth();
  }

  bool get autoPair => _autoPair;
  bool get isConnecting => _isConnecting;
  bool get isConnected => _dataSubscription != null;

  set autoPair(bool value) {
    _autoPair = value;

    if (value) {
      _instance.setPairingRequestHandler((request) {
        if (request.pairingVariant == PairingVariant.Pin)
          return Future.value(pinNum);

        return Future.value("");
      });
    } else {
      _instance.setPairingRequestHandler(null);
    }

    notifyListeners();
  }

  void initBluetooth() async {
    // Get bluetooth initial state
    this.state = await _instance.state;
    this.address = await _instance.address;
    this.name = await _instance.name;

    notifyListeners();

    _instance.onStateChanged().listen((state) {
      this.state = state;

      _reset();
    });
  }

  Future<bool> pairWith(BluetoothDevice device) async {
    var pairedDevices = await _instance.getBondedDevices();

    if (pairedDevices.length < 7) {
      var result = await _instance.bondDeviceAtAddress(device.address);

      if (result) {
        var deviceIndex = scannedDevices.indexWhere((scannedDevice) {
          return scannedDevice.device.address == device.address;
        });

        scannedDevices[deviceIndex] = BluetoothDiscoveryResult(
          device: BluetoothDevice(
            name: device.name ?? '',
            address: device.address,
            type: device.type,
            bondState:
                result ? BluetoothBondState.bonded : BluetoothBondState.none,
          ),
          rssi: scannedDevices[deviceIndex].rssi,
        );

        notifyListeners();
      }

      return Future.value(result);
    }

    return Future.value(false);
  }

  // Notice the return value
  Future<bool> unpairFrom(BluetoothDevice device) async {
    var result = await _instance.removeDeviceBondWithAddress(device.address);

    if (result) {
      var deviceIndex = scannedDevices.indexWhere((scannedDevice) {
        return scannedDevice.device.address == device.address;
      });

      scannedDevices[deviceIndex] = BluetoothDiscoveryResult(
        device: BluetoothDevice(
          name: device.name ?? '',
          address: device.address,
          type: device.type,
          bondState:
              result ? BluetoothBondState.none : BluetoothBondState.bonded,
        ),
        rssi: scannedDevices[deviceIndex].rssi,
      );

      notifyListeners();
    }

    return Future.value(result);
  }

  Future<bool> enable() => _instance.requestEnable();
  Future<bool> disable() => _instance.requestDisable();
  Future<void> openSettings() => _instance.openSettings();

  Future<bool> connectTo(BluetoothDevice device) async {
    _isConnecting = true;
    if (isConnected) await _connection.close();
    notifyListeners();

    try {
      var connection = await BluetoothConnection.toAddress(device.address);

      _isConnecting = false;

      _connection = connection;
      _dataSubscription = connection.input.listen(_onDataReceived);
      _dataSubscription.onDone(_onDisconnect);

      var deviceIndex = scannedDevices.indexWhere((scannedDevice) {
        return scannedDevice.device.address == device.address;
      });

      _connectedDevice = scannedDevices[deviceIndex] = BluetoothDiscoveryResult(
        device: BluetoothDevice(
          name: device.name ?? '',
          address: device.address,
          bondState: device.bondState,
          type: device.type,
          isConnected: true,
        ),
        rssi: scannedDevices[deviceIndex].rssi,
      );

      notifyListeners();
      return Future.value(true);
    } catch (_) {
      _isConnecting = false;
      _dataSubscription = null;
      _connection = null;

      notifyListeners();
      return Future.value(false);
    }
  }

  Future<List<BluetoothDevice>> pairedDevices() async {
    var result = await _instance.getBondedDevices();
    return Future.value(result);
  }

  void disConnect() async {
    if (isConnected) {
      this.unpairFrom(_connectedDevice.device);
      _connection.dispose();
    }
  }

  void startScanning() {
    isScanning = true;
    scannedDevices.clear();
    notifyListeners();

    if (isConnected) scannedDevices.add(_connectedDevice);

    _scannedDevicesSubscription = _instance.startDiscovery().listen((device) {
      scannedDevices.add(device);
    });

    _scannedDevicesSubscription.onDone(() async {
      isScanning = false;
      notifyListeners();
    });
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    var backspacesCounter = 0;

    data.forEach((byte) {
      if (byte == 8 || byte == 127) backspacesCounter++;
    });
 var buffer = Uint8List(data.length - backspacesCounter);
    var bufferIndex = buffer.length;

    // Apply backspace control character
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

    var dataString = String.fromCharCodes(buffer);
    var index = buffer.indexOf(13);
    if (~index != 0) {
      // \r\n

      var data = backspacesCounter > 0
          ? _dataBuffer.substring(0, _dataBuffer.length - backspacesCounter)
          : _dataBuffer = _dataBuffer + dataString.substring(0, index);

      _onDataCallback(data);

      _dataBuffer = dataString.substring(index);
    } else {
      _dataBuffer = (backspacesCounter > 0
          ? _dataBuffer.substring(0, _dataBuffer.length - backspacesCounter)
          : _dataBuffer + dataString);
    }
  }

  void _onDisconnect() {
    // reset

    if (this.state == BluetoothState.STATE_ON) {
      var deviceIndex = scannedDevices.indexWhere((scannedDevice) {
        return scannedDevice.device.address == _connectedDevice.device.address;
      });

      scannedDevices[deviceIndex] = BluetoothDiscoveryResult(
        device: BluetoothDevice(
          name: _connectedDevice.device.name ?? '',
          address: _connectedDevice.device.address,
          type: _connectedDevice.device.type,
          bondState: _connectedDevice.device.bondState,
        ),
        rssi: _connectedDevice.rssi,
      );
    }

    _reset();
  }

  void _reset() {
    _dataBuffer = '';

    _isConnecting = false;

    _dataSubscription = null;
    _scannedDevicesSubscription = null;
    _connectedDevice = null;
    _connection = null;

    if (this.state != BluetoothState.STATE_ON) {
      scannedDevices.clear();
    }

    notifyListeners();
  }

  void onDataReceived(void Function(String) callback) {
    _onDataCallback = callback;
  }

  bool sendData(String data) {
    try {
      data = data.trim();
      if (data.length > 0 && isConnected) {
        _connection.output.add(utf8.encode(data + "\r\n"));
        return true;
      }
    } catch (e) {
      return false;
    }

    return false;
  }

  void dispose() {
    _instance.setPairingRequestHandler(null);
    if (isConnected) _dataSubscription.cancel();
    _scannedDevicesSubscription?.cancel();

    super.dispose();
  }
}
  