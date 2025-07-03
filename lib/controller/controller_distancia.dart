import 'dart:isolate';

import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'dart:developer' as dev;
import 'package:flutter_tts/flutter_tts.dart';

class RequirementDistance extends GetxController {
  final FlutterTts flutterTts = FlutterTts();
  List<Beacon> primeiro = [];
  List<Beacon> segundo = [];
  List<Beacon> terceiro = [];
  List<Beacon> quarto = [];
  List<Beacon> quinto = [];
  List<Beacon> sexto = [];
  List<Beacon> setimo = [];
  List<Beacon> oitavo = [];
  List<Beacon> nono = [];
  List<Beacon> decimo = [];

  List<Beacon> node1 = [];
  List<Beacon> node2 = [];
  List<Beacon> node3 = [];
  List<Beacon> node4 = [];
  List<Beacon> node5 = [];
  List<Beacon> node6 = [];
  List<Beacon> node7 = [];
  List<Beacon> node8 = [];
  List<Beacon> node9 = [];
  List<Beacon> node10 = [];
  List<Beacon> node11 = [];
  List<Beacon> node12 = [];
  List<Beacon> node13 = [];

  static const Map<String, String> beaconMacToNode = {
    'D7:05:E8:A5:81:6D': 'node1',
    'E4:D9:1C:68:10:5F': 'node2',
    'EA:99:49:8F:A4:B7': 'node3',
    'F8:13:A7:AC:D2:18': 'node4',
    'F6:66:FC:FD:B0:AF': 'node5',
    'EF:29:E0:C0:C7:FC': 'node6',
    'F2:55:56:32:1E:5A': 'node7',
    'F1:D4:36:55:33:C2': 'node8',
    'DD:59:6C:57:E9:0F': 'node9',
    'D2:9A:07:1A:74:44': 'node10',
  };

  List adiciona(List parametros) {
    SendPort sendPort = parametros[0];
    List<Beacon> beacons = parametros[1];
    for (var i = 0; i < beacons.length; i++) {
      final nodeKey = beaconMacToNode[beacons[i].macAddress];
      if (nodeKey != null) {
        final nodeList = _getNodeListByKey(nodeKey);
        if (nodeList.length < 4) {
          nodeList.add(beacons[i]);
        } else {
          nodeList.removeAt(0);
          nodeList.add(beacons[i]);
        }
      } else {
        print("Não esta adicionando nada");
      }
    }
    List closest = getClosest();
    sendPort.send(closest);
  }

  List<Beacon> _getNodeListByKey(String key) {
    switch (key) {
      case 'node1':
        return node1;
      case 'node2':
        return node2;
      case 'node3':
        return node3;
      case 'node4':
        return node4;
      case 'node5':
        return node5;
      case 'node6':
        return node6;
      case 'node7':
        return node7;
      case 'node8':
        return node8;
      case 'node9':
        return node9;
      case 'node10':
        return node10;
      default:
        throw Exception('Unknown node key: $key');
    }
  }

  List getClosest() {
    num d1 = calculateAverage(node1);
    num d2 = calculateAverage(node2);
    num d3 = calculateAverage(node3);
    num d4 = calculateAverage(node4);
    num d5 = calculateAverage(node5);
    num d6 = calculateAverage(node6);
    num d7 = calculateAverage(node7);
    num d8 = calculateAverage(node8);
    num d9 = calculateAverage(node9);
    num d10 = calculateAverage(node10);

    var momentum = [d1, d2, d3, d4, d5, d6, d7, d8, d9, d10];
    var dist =
        momentum.reduce((value, element) => value < element ? value : element);
    var smallestIndex = momentum.indexOf(dist);
    List closest;
    if (smallestIndex >= 0 && smallestIndex < beaconMacToNode.length) {
      final mac = beaconMacToNode.keys.elementAt(smallestIndex);
      closest = [mac, dist];
    } else {
      closest = ["nenhum", 100];
    }
    return closest;
  }

  num calculateAverage(List<Beacon> values) {
    if (values.isEmpty) {
      return 100.0;
    }
    num sum = 0;
    for (var element in values) {
      sum += element.accuracy;
    }

    return sum / values.length;
  }

  Map<String, num> momento() {
    num d1 = 0;
    num d2 = 0;
    num d3 = 0;
    num d4 = 0;
    num d5 = 0;
    num d6 = 0;
    num d7 = 0;
    num d8 = 0;
    num d9 = 0;
    num d10 = 0;

    for (var i = 0; i < primeiro.length; i++) {
      d1 = d1 + primeiro[i].accuracy;
      d1 /= primeiro.length;
    }
    for (var i = 0; i < segundo.length; i++) {
      d2 = d2 + segundo[i].accuracy;
      d2 /= segundo.length;
    }
    for (var i = 0; i < terceiro.length; i++) {
      d3 = d3 + terceiro[i].accuracy;
      d3 /= terceiro.length;
    }
    for (var i = 0; i < quarto.length; i++) {
      d4 = d4 + quarto[i].accuracy;
      d4 /= quarto.length;
    }
    for (var i = 0; i < quinto.length; i++) {
      d5 = d5 + quinto[i].accuracy;
      d5 /= quinto.length;
    }
    for (var i = 0; i < sexto.length; i++) {
      d6 = d6 + sexto[i].accuracy;
      d6 /= sexto.length;
    }
    for (var i = 0; i < setimo.length; i++) {
      d7 = d7 + setimo[i].accuracy;
      d7 /= setimo.length;
    }
    for (var i = 0; i < oitavo.length; i++) {
      d8 = d8 + oitavo[i].accuracy;
      d8 /= oitavo.length;
    }
    for (var i = 0; i < nono.length; i++) {
      d9 = d9 + nono[i].accuracy;
      d9 /= nono.length;
    }
    for (var i = 0; i < decimo.length; i++) {
      d10 = d10 + decimo[i].accuracy;
      d10 /= decimo.length;
    }

    if (primeiro.isEmpty) d1 = 100;
    if (segundo.isEmpty) d2 = 100;
    if (terceiro.isEmpty) d3 = 100;
    if (quarto.isEmpty) d4 = 100;
    if (quinto.isEmpty) d5 = 100;
    if (sexto.isEmpty) d6 = 100;
    if (setimo.isEmpty) d7 = 100;
    if (oitavo.isEmpty) d8 = 100;
    if (nono.isEmpty) d9 = 100;
    if (decimo.isEmpty) d10 = 100;

    var momentum = [d1, d2, d3, d4, d5, d6, d7, d8, d9, d10];
    var dist =
        momentum.reduce((value, element) => value < element ? value : element);

    primeiro.clear();
    segundo.clear();
    terceiro.clear();
    quarto.clear();
    quinto.clear();
    sexto.clear();
    setimo.clear();
    oitavo.clear();
    nono.clear();
    decimo.clear();

    if (dist == d1) {
      return {"D7:05:E8:A5:81:6D": dist};
    } else if (dist == d2) {
      return {"E4:D9:1C:68:10:5F": dist};
    } else if (dist == d3) {
      return {"EA:99:49:8F:A4:B7": dist};
    } else if (dist == d4) {
      return {"F8:13:A7:AC:D2:18": dist};
    } else if (dist == d5) {
      return {"F6:66:FC:FD:B0:AF": dist};
    } else if (dist == d6) {
      return {"EF:29:E0:C0:C7:FC": dist};
    } else if (dist == d7) {
      return {"F2:55:56:32:1E:5A": dist};
    } else if (dist == d8) {
      return {"F1:D4:36:55:33:C2": dist};
    } else if (dist == d9) {
      return {"DD:59:6C:57:E9:0F": dist};
    } else if (dist == d10) {
      return {"D2:9A:07:1A:74:44": dist};
    } else {
      return {"Nenhum": 100};
    }
  }
}
