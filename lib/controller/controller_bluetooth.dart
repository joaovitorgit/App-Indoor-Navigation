import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:get/get.dart';

/// Controller for managing Bluetooth state and permissions.
class RequirementStateController extends GetxController {
  final Rx<BluetoothState> _bluetoothState = BluetoothState.stateOff.obs;
  final RxBool _startScanning = false.obs;
  final RxBool _pauseScanning = false.obs;
  final Rx<AuthorizationStatus> _authorizationStatus = AuthorizationStatus.notDetermined.obs;
  final RxBool _locationService = false.obs;

  /// Returns true if Bluetooth is enabled.
  bool get isBluetoothEnabled => _bluetoothState.value == BluetoothState.stateOn;

  /// Returns true if location service is enabled.
  bool get isLocationServiceEnabled => _locationService.value;

  /// Returns true if authorization status is allowed or always.
  bool get isAuthorizationStatusOk =>
      _authorizationStatus.value == AuthorizationStatus.allowed ||
      _authorizationStatus.value == AuthorizationStatus.always;

  /// Streams for scanning state changes.
  Stream<bool> get startScanningStream => _startScanning.stream;
  Stream<bool> get pauseScanningStream => _pauseScanning.stream;

  /// Getters for state (for compatibility with existing code)
  Rx<BluetoothState> get bluetoothState => _bluetoothState;
  Rx<AuthorizationStatus> get authorizationStatus => _authorizationStatus;
  RxBool get locationService => _locationService;

  /// Update Bluetooth state.
  void updateBluetoothState(BluetoothState state) {
    _bluetoothState.value = state;
  }

  /// Start scanning for beacons.
  void startScanning() {
    _startScanning.value = true;
    _pauseScanning.value = false;
  }

  /// Pause scanning for beacons.
  void pauseScanning() {
    _startScanning.value = false;
    _pauseScanning.value = true;
  }

  /// Update authorization status.
  void updateAuthorizationStatus(AuthorizationStatus status) {
    _authorizationStatus.value = status;
  }

  /// Update location service state.
  void updateLocationService(bool enabled) {
    _locationService.value = enabled;
  }
}
