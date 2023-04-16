import 'dart:isolate';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:get/get.dart';
import 'dart:developer';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../controller/controller_bluetooth.dart';
import '../controller/controller_distancia.dart';
import '../controller/controller_nodes.dart';
import 'mobile.dart';
import 'package:directed_graph/directed_graph.dart';
import 'package:permission_handler/permission_handler.dart';

class TabScanning extends StatefulWidget {
  const TabScanning({Key key}) : super(key: key);
  @override
  _TabScanningState createState() => _TabScanningState();
}

class _TabScanningState extends State<TabScanning> {
  StreamSubscription<RangingResult> _resultadoScan;
  final _beaconPorRegiao = <Region, List<Beacon>>{};
  final _beacons = <Beacon>[];
  final controller = Get.find<RequirementStateController>();
  final controllerDistancia = Get.find<RequirementDistance>();
  final controllerNodes = Get.find<RequirementNode>();
  final FlutterTts flutterTts = FlutterTts();
  Map<String, num> map1;
  final teste = <Map<String, num>>[];
  String revisao = '';

  @override
  void initState() {
    super.initState();

    controller.iniciaStream.listen((flag) {
      if (flag == true) {
        iniciaScanBeacon();
      }
    });

    controller.pausaStream.listen((flag) {
      if (flag == true) {
        pausaScanBeacon();
      }
    });
  }

  iniciaScanBeacon() async {
    var status = await Permission.bluetoothScan.status;
    if (status.isDenied) {
      log("PRIMEIRO");
      status = await Permission.bluetoothScan.request();
    }
    if (status.isGranted) {
      log("SEGUNDO");
      // Permission granted, start Bluetooth scan here
    } else {
      log("TERCEIRO");
      // Permission denied, handle it here
    }
    final FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage('pt-BR');
    await flutterTts.setSpeechRate(0.6);
    await flutterTts.setQueueMode(1);
    final node1 = RequirementNode();
    final node2 = RequirementNode();
    final node3 = RequirementNode();
    final node4 = RequirementNode();
    final node5 = RequirementNode();
    final node6 = RequirementNode();
    final node7 = RequirementNode();
    final node8 = RequirementNode();
    final node9 = RequirementNode();
    final node10 = RequirementNode();
    final node11 = RequirementNode();
    final node12 = RequirementNode();
    final node13 = RequirementNode();

    node1.defineValores(
        'nupXZG',
        'Porta de entrada do IMC',
        "D7:05:E8:A5:81:6D",
        "Após a porta de entrada, dê onze passos para a esquerda. Em seguida pegue a rampa a esquerda");

    node2.defineValores(
        'nu1T2P',
        "Rampa de acesso ao segundo andar do IMC ",
        'E4:D9:1C:68:10:5F',
        // 'D2:9A:07:1A:74:44',
        "Por favor, continue subindo a rampa pela esquerda");

    node3.defineValores('nu82HB', "Segundo andar do IMC", "EA:99:49:8F:A4:B7",
        "Por favor, siga o corredor à esquerda");

    node4.defineValores(
        'nuK46o',
        "Laboratório de pesquisa",
        "F8:13:A7:AC:D2:18",
        "Há uma esquina à frente. Siga pela direita e dê seis passos. Em seguida pegue o corredor a sua esquerda");

    node5.defineValores(
        'nuPWVm',
        "Próximo a sala de t.i",
        "F6:66:FC:FD:B0:AF",
        // "Siga pelo corredor a sua esquerda");
        "O corredor na sua esquerda é o mais longo do IMC. Por favor, siga por ele");

    node6.defineValores('nuTorE', "Corredor de estudos", 'EF:29:E0:C0:C7:FC',
        "Continue pelo corredor. Quando chegar a uma esquina, pegue a direita");

    node7.defineValores(
        'nuYbJJ',
        "Proximo a sala de PMAT",
        'F2:55:56:32:1E:5A',
        // "Siga pelo corredor à direita. Depois pegue o corredor a esquerda e siga por mais onze passos");
        "Siga para a direita na próxima esquina, depois de seis passos, siga pela esquerda. Oriente-se pela parede à direita e percorra o corredor até o final. Por favor, ignore o corredor que estará à sua direita");

    node8.defineValores(
        'nuaScN',
        "Proximo aos banheiros ",
        'F1:D4:36:55:33:C2',
        // "Pegue o corredor à esquerda, siga por mais onze passos e depois continue no corredor à direita por mais doze passos");
        "Pegue o corredor a sua esquerda. Siga por  8 passos e pegue a direita. Por favor, oriente-se pela parede à direita e percorra o corredor até o final");

    node9.defineValores(
        'nuudyl',
        "Corredor da secretaria",
        'DD:59:6C:57:E9:0F',
        // "Siga pelo corredor à direita");
        "Vire a esquina à direita e siga em frente. Oriente-se pela parede a esquerda e ignore o primeiro corredor que encontrar.");

    node10.defineValores(
        'nuwU1M',
        "Você está na secretaria",
        'D2:9A:07:1A:74:44',
        // 'E4:D9:1C:68:10:5F',
        "Parabéns, a secretaria é a primeira porta a sua direita.");

    // Equivalente ao Nó 8
    node11.defineValores(
        'nuaScN',
        "Você está próximo ao LDC1 e LDC2",
        "F1:D4:36:55:33:C2",
        "Em breve vocÊ encontrará uma esquina. Siga pelo corredor à direita");
    // Equivalente ao Nó 9
    node12.defineValores(
        'nuudyl',
        "Você está próximo aos corredor dos banheiros",
        "DD:59:6C:57:E9:0F",
        "Pegue o corredor à esquerda e siga por ele.");
    // Equivalente ao Nó 10
    node13.defineValores('nuwU1M', "Você está em frente aos banheiros",
        "D2:9A:07:1A:74:44", "Parabéns, os banheiros estão à sua direita");

    String destino = 'banheiro';
    // String destino = 'secretaria';

    List path = getPath(node1, node2, node3, node4, node5, node6, node7, node8,
        node9, node10, node11, node12, node13, destino);

    for (int i = 0; i < path.length; i++) {
      log(path[i].id);
    }
    await flutterBeacon.initializeScanning;
    // if (!controller.bluetoothEnabled) {
    //   return;
    // }
    if (!controller.authorizationStatusOk ||
        !controller.locationServiceEnabled ||
        !controller.bluetoothEnabled) {
      print(
          'RETURNED, authorizationStatusOk=${controller.authorizationStatusOk}, '
          'locationServiceEnabled=${controller.locationServiceEnabled}, '
          'bluetoothEnabled=${controller.bluetoothEnabled}');
      return;
    }
    final regions = <Region>[];
    regions.add(Region(identifier: 'com.beacon'));

    if (_resultadoScan != null) {
      if (_resultadoScan.isPaused) {
        _resultadoScan?.resume();
        return;
      }
    }

    var beaconAtual = 0;
    List closestBeacon;
    String id;
    num distanciaBeacon;
    var currentIndex = 0;

    _resultadoScan =
        flutterBeacon.ranging(regions).listen((RangingResult result) async {
      _beaconPorRegiao[result.region] = result.beacons;

      for (var list in _beaconPorRegiao.values) {
        _beacons.addAll(list);
      }
      writeLog(_beacons);
      if (_beacons.length >= 4) {
        // controllerDistancia.adiciona(_beacons);
        // closestBeacon = controllerDistancia.getClosest();
        final receivePort = ReceivePort();
        final isolate = await Isolate.spawn(
            controllerDistancia.adiciona, [receivePort.sendPort, _beacons]);
        receivePort.listen((message) {
          closestBeacon = message;
        });

        log("O MAIS PERTO É ESSE: " + closestBeacon.toString());
        id = closestBeacon[0];
        distanciaBeacon = closestBeacon[1];

        if (distanciaBeacon <= 2) {
          // revisao = revisao +"Chamou o comando neste frame. O beacon foi "+id+"com distancia: "+distanciaBeacon.toString()+"\n";
          // revisao = revisao + "-----------------------------------------------------------\n";
          if (id == path[currentIndex].getMac()) {
            path[currentIndex].getLocalizacao();
            path[currentIndex].getComandos();
            path[currentIndex].setVisited();
            currentIndex++;
          } else {
            var checkElement = path.indexWhere((element) => element.mac == id);

            if (checkElement == -1) {
              flutterTts.speak("Trajeto incorreto. Por favor, retorne!");
              await Future.delayed(const Duration(seconds: 5));
            } else if (checkElement > currentIndex) {
              currentIndex = checkElement;
              path[currentIndex].getLocalizacao();
              path[currentIndex].getComandos();
              path[currentIndex].setVisited();
              currentIndex++;
            }
            // If it belong to the path but we alread passed through dont to anything
          }
        }
        _beacons.clear();
      }
    });
  }

  List getPath(node1, node2, node3, node4, node5, node6, node7, node8, node9,
      node10, node11, node12, node13, destino) {
    int sum(int left, int right) => left + right;

    var grafo = WeightedDirectedGraph<RequirementNode, int>(
      {
        node1: {node2: 1},
        node2: {node1: 1, node3: 15},
        node3: {
          node2: 15,
          node4: 12,
          node11: 10
        }, // Bifurcação no topo da rampa
        node4: {node3: 12, node5: 11},
        node5: {node4: 11, node6: 17},
        node6: {node5: 17, node7: 11},
        node7: {node6: 11, node8: 11},
        node8: {node7: 11, node9: 9},
        node9: {node8: 9, node10: 22},
        node10: {node9: 22}, // Chegou na secretaria
        // Estes nós fazem uso dos mesmo beacons utilizados vértices 8,9 e 10.
        node11: {node3: 10, node12: 9},
        node12: {node11: 9, node13: 6},
        node13: {node12: 6},
      },
      summation: sum,
      zero: 0,
    );

    final rotaSecretaria = grafo.shortestPath(node1, node10);
    final rotaBanheiro = grafo.shortestPath(node1, node13);
    List path = [];
    switch (destino) {
      case 'banheiro':
        path = rotaBanheiro;
        break;
      case 'secretaria':
        path = rotaSecretaria;
        break;
      default:
        break;
    }

    return path;
  }

  void writeLog(List<Beacon> beacons) async {
    for (int i = 0; i < beacons.length; i++) {
      var id = beacons[i].macAddress.toString();

      revisao = revisao + '';
      if (id == "D7:05:E8:A5:81:6D") {
        revisao = revisao + 'A';
      } else if (id == "E4:D9:1C:68:10:5F") {
        // revisao = revisao + 'B';
        revisao = revisao + 'J';
      } else if (id == "EA:99:49:8F:A4:B7") {
        revisao = revisao + 'C';
      } else if (id == "F8:13:A7:AC:D2:18") {
        revisao = revisao + 'D';
      } else if (id == "F6:66:FC:FD:B0:AF") {
        revisao = revisao + 'E';
      } else if (id == "EF:29:E0:C0:C7:FC") {
        revisao = revisao + 'F';
      } else if (id == "F2:55:56:32:1E:5A") {
        revisao = revisao + 'G';
      } else if (id == "F1:D4:36:55:33:C2") {
        revisao = revisao + 'H';
      } else if (id == "DD:59:6C:57:E9:0F") {
        revisao = revisao + 'I';
      } else if (id == "D2:9A:07:1A:74:44") {
        revisao = revisao + 'J';
        revisao = revisao + 'B';
      }
      revisao = revisao + ';';
      revisao = revisao + beacons[i].accuracy.toString();
      revisao = revisao + ';';
      revisao = revisao + beacons[i].txPower.toString();
      revisao = revisao + ';';
      revisao = revisao + beacons[i].rssi.toString();
      revisao = revisao + ';';
      DateTime now = DateTime.now();
      revisao = revisao +
          '${now.hour}:${now.minute}:${now.second}:${now.millisecond}';
      revisao = revisao + ';';
      revisao = revisao + DateTime.now().millisecondsSinceEpoch.toString();
      revisao = revisao + ';\n';
    }
  }

  pausaScanBeacon() async {
    _resultadoScan?.pause();
    if (_beacons.isNotEmpty) {
      setState(() {
        _beacons.clear();
      });
    }
  }

  @override
  void dispose() {
    _resultadoScan?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              child: const Text('Exportar PDF'),
              onPressed: _createPDF,
            ),
          ])
        ],
      ),
    );
  }

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    PdfTextElement(
            text: revisao, font: PdfStandardFont(PdfFontFamily.timesRoman, 14))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                0, 0, page.getClientSize().width, page.getClientSize().height));

    List<int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, 'leiturasDoTeste.pdf');
  }
}

Future<Uint8List> _readImageData(String name) async {
  final data = await rootBundle.load('images/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}
