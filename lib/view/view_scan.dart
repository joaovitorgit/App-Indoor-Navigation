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

class TabScanning extends StatefulWidget {
  const TabScanning({Key key}) : super(key: key);
  @override 
  _TabScanningState createState() =>_TabScanningState(); 
}

class _TabScanningState extends State<TabScanning> {
  StreamSubscription<RangingResult>_resultadoScan; 
  final _beaconPorRegiao = <Region,List<Beacon>>{}; 
  final _beacons = <Beacon>[]; 
  final controller = Get.find<RequirementStateController>(); 
  final controllerDistancia = Get.find<RequirementDistance>(); 
  final controllerNodes = Get.find<RequirementNode>();
  final FlutterTts flutterTts = FlutterTts(); 
  Map<String, num> map1 ;
  final teste = <Map<String, num>>[];
  String revisao ='';

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
  
   void retornaLista() {
    setState(() {
      revisao = revisao;
    });
    
  }

  iniciaScanBeacon() async {
    
    final FlutterTts flutterTts = FlutterTts(); 
    await flutterTts.setLanguage('pt-BR'); 
    await flutterTts.setSpeechRate(0.6); 
    await flutterTts.setQueueMode(1);
    final no1 = RequirementNode();
    final no2 = RequirementNode();
    final no3 = RequirementNode();
    final no4 = RequirementNode();
    final no5 = RequirementNode();
    final no6 = RequirementNode();
    final no7 = RequirementNode();
    final no8 = RequirementNode();
    final no9 = RequirementNode();
    final no10 = RequirementNode();
    final no11 = RequirementNode();
    final no12 = RequirementNode();
    final no13 = RequirementNode();

    no1.defineValores( // De onze passos para a esquerda e em seguida pegue a rampa a esquerda
        'nupXZG',
        'Porta de entrada do IMC',
        "D7:05:E8:A5:81:6D",
        "Após a porta de entrada, dê onze passos para a esquerda. Em seguida pegue a rampa a esquerda");
        // "Após a porta de entrada siga à esquerda. Depois pegue a rampa à esquerda");
    no2.defineValores( // Por favor, continua subindo a rampa
        'nu1T2P',
        "Rampa de acesso ao segundo andar do IMC ",
        'E4:D9:1C:68:10:5F',
        "Por favor, continue subindo a rampa pela esquerda");
        // "Você chegou na metade da rampa. Por favor, continue subindo a rampa para chegar ao seu destino");
    no3.defineValores(// De quatro passos para a direita. Em seguida, vire a sua esquerda e siga pelo corredor
        'nu82HB', 
        "Segundo andar do IMC", 
        "EA:99:49:8F:A4:B7",
        "Por favor, siga o corredor à esquerda");
        // "Siga quatro passos à direita. Em seguida, pegue o corredo à esquerda");
    // Nó C
    no4.defineValores(// De seis passos para a direita e em seguida pegue o corredor a sua esquerda
        'nuK46o', 
        "Laboratório de pesquisa", 
        "F8:13:A7:AC:D2:18",
        "Há uma esquina à frente. Siga pela direita e dê seis passos. Em seguida pegue o corredor a sua esquerda");
        // "Siga o corredor à direita, em seguida pegue o corredor à esquerda");
    // Nó D
    no5.defineValores(// percorra o corredor a sua esquerda
        'nuPWVm', 
        "Próximo a sala de t.i", 
        "F6:66:FC:FD:B0:AF",
        // "Siga pelo corredor a sua esquerda");
        "O corredor na sua esquerda é o mais longo do IMC. Por favor, siga por ele");
    // Nó E
    no6.defineValores(// siga por mais doze passos e em seguida pegue o corredor a direita
        'nuTorE',
        "Corredor de estudos",
        'EF:29:E0:C0:C7:FC',
        "Continue pelo corredor. Quando chegar a uma esquina, pegue a direita");
        // "Continue percorrendo o corredor. Em breve haverá uma esquina, por favor, siga à direita");
    // Nó F
    no7.defineValores(// de cinco passos para a direita depois pegue o corredor a esquerda e siga por mais onze passos
        'nuYbJJ', 
        "Proximo a sala de PMAT", 
        'F2:55:56:32:1E:5A',
        // "Siga pelo corredor à direita. Depois pegue o corredor a esquerda e siga por mais onze passos");
        "Siga para a direita na próxima esquina, depois de seis passos, siga pela esquerda. Oriente-se pela parede à direita e percorra o corredor até o final. Por favor, ignore o corredor que estará à sua direita");
    // Nó G
    no8.defineValores( // pegue o corredor a esquerda, siga por mais onze passos e depois siga o corredor a direita por mais doze passos
        'nuaScN', 
        "Proximo aos banheiros ", 
        'F1:D4:36:55:33:C2',
        // "Pegue o corredor à esquerda, siga por mais onze passos e depois continue no corredor à direita por mais doze passos");
        "Pegue o corredor a sua esquerda. Siga por  8 passos e pegue a direita. Por favor, oriente-se pela parede à direita e percorra o corredor até o final");
    // Nó H
    no9.defineValores(// siga o corredor a direita por trintra passos
        'nuudyl', 
        "Corredor da secretaria", 
        'DD:59:6C:57:E9:0F',
        // "Siga pelo corredor à direita");
        "Vire a esquina à direita e siga em frente. Oriente-se pela parede a esquerda e ignore o primeiro corredor que encontrar.");
    // Nó I
    no10.defineValores(
        'nuwU1M', 
        "Você está na secretaria", 
        'D2:9A:07:1A:74:44',
        "Parabéns, a secretaria é a primeira porta a sua direita.");
    // Para o teste do beacons referentes os nós 4, 9 e 10 serão reutilizados com as seguintes configurações
    // Equivalente ao Nó 8
    no11.defineValores(
        'nuaScN', 
        "Você está próximo ao LDC1 e LDC2", 
        "F1:D4:36:55:33:C2",
        "Em breve vocÊ encontrará uma esquina. Siga pelo corredor à direita");
    // Equivalente ao Nó 9
    no12.defineValores(
        'nuudyl', 
        "Você está próximo aos corredor dos banheiros", 
        "DD:59:6C:57:E9:0F",
        "Pegue o corredor à esquerda e siga por ele.");
    // Equivalente ao Nó 10
    no13.defineValores(
        'nuwU1M', 
        "Você está em frente aos banheiros", 
        "D2:9A:07:1A:74:44",
        "Parabéns, os banheiros estão à sua direita");

   int sum(int left, int right) => left + right;

   var grafo = WeightedDirectedGraph<RequirementNode, int>(
    {
      no1 : {no2 : 1},
      no2:  {no1: 1, no3: 15},
      no3 : {no2: 15, no4: 12, no11: 10}, // Bifurcação no topo da rampa
      no4 : {no3: 12, no5: 11},
      no5 : {no4: 11, no6: 17},
      no6 : {no5: 17, no7: 11},
      no7 : {no6: 11, no8: 11},
      no8 : {no7: 11, no9: 9},
      no9 : {no8: 9, no10: 22},
      no10 : {no9: 22}, // Chegou na secretaria
      // Estes nós fazem uso dos mesmo beacons utilizados vértices 8,9 e 10.
      no11: {no3: 10, no12: 9},
      no12: {no11: 9, no13: 6},
      no13: {no12: 6},
    },
    summation: sum,
    zero: 0,
  );

  final rotaSecretaria = grafo.shortestPath(no1, no10);
  final rotaBanheiro = grafo.shortestPath(no1, no13);
  
    var destino = "";

    destino = "opção 2";
  
    List caminho = []; 
    if (destino == "opção 1") {
      caminho = rotaSecretaria; 
    } else if (destino == "opção 2") {
      caminho = rotaBanheiro;
    }
    
    await flutterBeacon.initializeScanning; 
    if (!controller.bluetoothEnabled) {
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
   
  var beaconAtual = 0 ;
  // bool localizacaoAtual = true;
  // var primeiro =[];
      
    _resultadoScan = flutterBeacon.ranging(regions).listen((RangingResult result) {
      _beaconPorRegiao[result.region] = result.beacons; 
      
      for (var list in _beaconPorRegiao.values) {
        _beacons.addAll(list);
      }
      // Verifica se foram feitas 6 leituras de sinais emitidos pelo beacon
      if (_beacons.length >= 1) {

        for(int i=0;i<_beacons.length;i++){
            var id = _beacons[i].macAddress.toString();

            revisao = revisao + '';
            if (id == "D7:05:E8:A5:81:6D"){
               revisao = revisao + 'A';
            } else if (id == "E4:D9:1C:68:10:5F"){
              revisao = revisao + 'B';
            } else if (id == "EA:99:49:8F:A4:B7"){
              revisao = revisao + 'C';
            } else if (id == "F8:13:A7:AC:D2:18"){
              revisao = revisao + 'D';
            } else if (id == "F6:66:FC:FD:B0:AF"){
              revisao = revisao + 'E';
            } else if (id == "EF:29:E0:C0:C7:FC"){
              revisao = revisao + 'F';
            } else if (id == "F2:55:56:32:1E:5A"){
              revisao = revisao + 'G';
            } else if (id == "F1:D4:36:55:33:C2"){
              revisao = revisao + 'H';
            } else if (id == "DD:59:6C:57:E9:0F"){
              revisao = revisao + 'I';
            } else if (id == "D2:9A:07:1A:74:44"){
              revisao = revisao + 'J';
            } 
            revisao = revisao + ';';
            revisao = revisao + _beacons[i].accuracy.toString();
            revisao = revisao + ';';
            revisao = revisao + _beacons[i].txPower.toString();
            revisao = revisao + ';';
            revisao = revisao + _beacons[i].rssi.toString();
            revisao = revisao + ';';
            DateTime now = DateTime.now();
            revisao = revisao + '${now.hour}:${now.minute}:${now.second}:${now.millisecond}';
            revisao = revisao + ';';
            revisao = revisao + DateTime.now().millisecondsSinceEpoch.toString();
            revisao = revisao + ';\n';
        }

        // controllerDistancia.adiciona(_beacons);
       
        // Esse aqui vai ter que retornar o ID e a distancia
        // map1 = controllerDistancia.momento();
        // teste.add(map1);

        // String id = map1.keys.first;
        // num distanciaBeacon = map1.values.first;   

        String id = _beacons[0].macAddress.toString();
        num distanciaBeacon = _beacons[0].accuracy;

        // As orientações só serão dadas caso o usuário esteja próximo ao beacon(2 metros).
        if(distanciaBeacon <= 3){
          // Caso o beacon próximo ao usuário seja o correto 
          if (id == caminho[beaconAtual].getMac()) {
            caminho[beaconAtual].getLocalizacao();
            caminho[beaconAtual].getComandos();
            caminho[beaconAtual].setVisited();
            beaconAtual++;
         }else {  // Caso o beacon próximo não seja o correto.
            try{
              var index =  caminho.firstWhere((i) => i.getMac() == id); 
            if (index.getVisited()){
              if(index.getMac() == caminho[beaconAtual-1].getMac()){ 

              }else{ 
                flutterTts.speak("Trajeto incorreto. Por favor, retorne!");
                log("PRIMEIRO");
              }
            }
            }
            catch(e){
              log("TERCEIRO");
               flutterTts.speak("Trajeto incorreto. Por favor, retorne!");
                flutterTts.setSilence(600);

            }
         }
        }else{ 
        }
       
        _beacons.clear(); 
      }
    });
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
            ElevatedButton(
            child: const Text('Exportar PDF'),
             onPressed: _createPDF,
        ),
            ]
            
          )
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
        bounds: Rect.fromLTWH(0, 0, page.getClientSize().width,
            page.getClientSize().height));

    List<int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, 'leiturasDoTeste.pdf');
  }
 }

 Future<Uint8List> _readImageData(String name) async {
  final data = await rootBundle.load('images/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}