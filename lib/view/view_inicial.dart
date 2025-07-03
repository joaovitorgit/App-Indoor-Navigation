// -------------------------------------importacoes-------------------------------------
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:get/get.dart';
import 'package:myflutterapp/view/view_scan.dart';
import 'dart:developer';
import 'package:permission_handler/permission_handler.dart';
import '../controller/controller_bluetooth.dart';

/// Home page for the indoor navigation app.
class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final controller = Get.find<RequirementStateController>();
  StreamSubscription<BluetoothState> _streamBluetooth;
  int currentIndex = 0;
  String retorno = ' ';

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _waitForBluetoothState();
  }

  /// Listen for Bluetooth state changes and update controller.
  void _waitForBluetoothState() async {
    _streamBluetooth = flutterBeacon
        .bluetoothStateChanged()
        .listen((BluetoothState state) async {
      controller.updateBluetoothState(state);
      await _checkAppParameters();
    });
  }

  /// Check and update app parameters (Bluetooth, location, permissions).
  Future<void> _checkAppParameters() async {
    final bluetoothState = await flutterBeacon.bluetoothState;
    controller.updateBluetoothState(bluetoothState);
    _streamBluetooth.printInfo();

    final authorizationStatus = await flutterBeacon.authorizationStatus;
    controller.updateAuthorizationStatus(authorizationStatus);

    final locationServiceEnabled =
        await flutterBeacon.checkLocationServicesIfEnabled;
    controller.updateLocationService(locationServiceEnabled);
   
    if (controller.isBluetoothEnabled &&
        controller.isAuthorizationStatusOk &&
        controller.isLocationServiceEnabled) {
      if (currentIndex == 0) {
        controller.startScanning();
      } else {
        controller.pauseScanning();
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (_streamBluetooth != null) {
        if (_streamBluetooth.isPaused) {
          _streamBluetooth?.resume();
        }
      }
      await _checkAppParameters();
    } else if (state == AppLifecycleState.paused) {
      _streamBluetooth?.pause();
    }
  }

  @override
  void dispose() {
    _streamBluetooth?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: IndexedStack(
        index: currentIndex,
        children: const [
          TabScanning(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  /// Build the app bar with status icons.
  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Projeto'),
      centerTitle: false,
      actions: <Widget>[
        _buildLocationServiceIcon(),
        _buildAuthorizationIcon(),
        _buildBluetoothIcon(),
      ],
    );
  }

  Widget _buildLocationServiceIcon() {
    return Obx(() {
      return IconButton(
        tooltip: controller.isLocationServiceEnabled
            ? 'Location Service ON'
            : 'Location Service OFF',
        icon: Icon(
          controller.isLocationServiceEnabled
              ? Icons.location_on
              : Icons.location_off,
        ),
        color: controller.isLocationServiceEnabled ? Colors.blue : Colors.red,
        onPressed: controller.isLocationServiceEnabled
            ? null
            : _handleOpenLocationSettings,
      );
    });
  }

  Widget _buildAuthorizationIcon() {
    return Obx(() {
      if (!controller.isAuthorizationStatusOk) {
        return IconButton(
          tooltip: 'Not Authorized',
          icon: Icon(Icons.portable_wifi_off),
          color: Colors.red,
          onPressed: () async {
            await flutterBeacon.requestAuthorization;
          },
        );
      }
      return IconButton(
        tooltip: 'Authorized',
        icon: Icon(Icons.wifi_tethering),
        color: Colors.blue,
        onPressed: () async {
          await flutterBeacon.requestAuthorization;
        },
      );
    });
  }

  Widget _buildBluetoothIcon() {
    return Obx(() {
      final state = controller.bluetoothState.value;
      if (state == BluetoothState.stateOn) {
        return IconButton(
          tooltip: 'Bluetooth ligado',
          icon: const Icon(Icons.bluetooth_connected),
          onPressed: () {},
          color: Colors.lightBlueAccent,
        );
      }
      if (state == BluetoothState.stateOff) {
        return IconButton(
          tooltip: 'Bluetooth desligado',
          icon: const Icon(Icons.bluetooth),
          onPressed: _handleOpenBluetooth,
          color: Colors.red,
        );
      }
      return IconButton(
        icon: const Icon(Icons.bluetooth_disabled),
        tooltip: 'Bluetooth não disponível',
        onPressed: () {},
        color: Colors.grey,
      );
    });
  }

  /// Build the bottom navigation bar.
  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
        if (currentIndex == 0) {
          controller.startScanning();
        } else {
          controller.pauseScanning();
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Escanear',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pause),
          label: 'Pausar',
        ),
      ],
    );
  }

  /// Open location settings on the device.
  void _handleOpenLocationSettings() async {
    if (Platform.isAndroid) {
      await flutterBeacon.openLocationSettings;
    } else if (Platform.isIOS) {
      await Permission.location.request();
    }
  }

  /// Open Bluetooth settings on the device.
  void _handleOpenBluetooth() async {
    if (Platform.isAndroid) {
      await flutterBeacon.openBluetoothSettings;
    }
  }
}
