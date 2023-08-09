import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:get/get.dart';

class RequirementStateController extends GetxController {
  final bluetoothState = BluetoothState.stateOff.obs; 
  final _startScanning = false.obs; 
  final _pauseScanning = false.obs; 

  var authorizationStatus = AuthorizationStatus.notDetermined.obs;
  var locationService = false.obs;

  bool get authorizationStatusOk =>
      authorizationStatus.value == AuthorizationStatus.allowed ||
      authorizationStatus.value == AuthorizationStatus.always;
  bool get locationServiceEnabled => locationService.value;

  bool get bluetoothEnabled =>
      bluetoothState.value ==
      BluetoothState.stateOn;

  atualizaEstadoBluetooth(BluetoothState state) {
    bluetoothState.value = state;
  }

  iniciaEscaneamento() {
    _startScanning.value = true;
    _pauseScanning.value = false;
  }

  pausaEscaneamento() {
    _startScanning.value = false;
    _pauseScanning.value = true;
  }

  Stream<bool> get iniciaStream {
    return _startScanning.stream;
  }

  Stream<bool> get pausaStream {
    return _pauseScanning.stream;
  }

  updateAuthorizationStatus(AuthorizationStatus status) {
    authorizationStatus.value = status;
  }

  updateLocationService(bool flag) {
    locationService.value = flag;
  }
}
