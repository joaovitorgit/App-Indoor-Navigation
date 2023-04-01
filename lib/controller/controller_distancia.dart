



import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'dart:developer' as dev;
import 'package:flutter_tts/flutter_tts.dart';


// Esta classe define métodos relacionados à distância entre o dispositivo do usuário e o Beacon
class RequirementDistance extends GetxController {
   final FlutterTts flutterTts = FlutterTts(); 
  // "D7:05:E8:A5:81:6D",
  // 'E4:D9:1C:68:10:5F',
  // "EA:99:49:8F:A4:B7",
  // "F8:13:A7:AC:D2:18",
  // "F6:66:FC:FD:B0:AF",
  // 'EF:29:E0:C0:C7:FC',
  //  F2:55:56:32:1E:5A',
  // 'F1:D4:36:55:33:C2',
  // 'DD:59:6C:57:E9:0F',
  // 'D2:9A:07:1A:74:44',
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

  // Metodo para popular as listas individuais de beacons
  void adiciona(List<Beacon> beacons) {
    for(var i = 0; i< beacons.length;i++){

      if(beacons[i].macAddress == "D7:05:E8:A5:81:6D"){
        primeiro.add(beacons[i]);
      } else if(beacons[i].macAddress == "E4:D9:1C:68:10:5F"){
        segundo.add(beacons[i]);
      } else if(beacons[i].macAddress == "EA:99:49:8F:A4:B7"){
        terceiro.add(beacons[i]);
      } else if(beacons[i].macAddress == "F8:13:A7:AC:D2:18"){
        quarto.add(beacons[i]);
      } else if(beacons[i].macAddress == "F6:66:FC:FD:B0:AF"){
        quinto.add(beacons[i]);
      } else if(beacons[i].macAddress == "EF:29:E0:C0:C7:FC"){
        sexto.add(beacons[i]);
      } else if(beacons[i].macAddress == "F2:55:56:32:1E:5A"){
        setimo.add(beacons[i]);
      } else if(beacons[i].macAddress == "F1:D4:36:55:33:C2"){
        oitavo.add(beacons[i]);
      } else if(beacons[i].macAddress == "DD:59:6C:57:E9:0F"){
        nono.add(beacons[i]);
      } else if(beacons[i].macAddress == "D2:9A:07:1A:74:44"){
        decimo.add(beacons[i]);
      }
       else {
        dev.log("Não esta adicionando nada");
      }
    }

  }

  Map<String, num>  momento(){

    num d1= 0;
    num d2= 0;
    num d3 = 0;
    num d4 = 0;
    num d5 = 0;
    num d6 = 0;
    num d7 = 0;
    num d8 = 0;
    num d9 = 0;
    num d10 = 0;

    for(var i = 0; i< primeiro.length;i++){
      d1 = d1 + primeiro[i].accuracy; 
      d1 /= primeiro.length;} 
    for(var i = 0; i< segundo.length;i++){
      d2 = d2 + segundo[i].accuracy; 
      d2 /= segundo.length;}
    for(var i = 0; i< terceiro.length;i++){
      d3 = d3 + terceiro[i].accuracy; 
      d3 /= terceiro.length;} 
    for(var i = 0; i< quarto.length;i++){
      d4 = d4 + quarto[i].accuracy; 
      d4 /= quarto.length;}
    for(var i = 0; i< quinto.length;i++){
      d5 = d5 + quinto[i].accuracy; 
      d5 /= quinto.length;}
    for(var i = 0; i< sexto.length;i++){
      d6 = d6 + sexto[i].accuracy; 
      d6 /= sexto.length;}
    for(var i = 0; i< setimo.length;i++){
      d7 = d7 + setimo[i].accuracy; 
      d7 /= setimo.length;}
    for(var i = 0; i< oitavo.length;i++){
      d8 = d8 + oitavo[i].accuracy; 
      d8 /= oitavo.length;}
    for(var i = 0; i< nono.length;i++){
      d9 = d9 + nono[i].accuracy; 
      d9 /= nono.length;}
    for(var i = 0; i< decimo.length;i++){
      d10 = d10 + decimo[i].accuracy; 
      d10 /= decimo.length;}

    if (primeiro.isEmpty)d1 = 100;
    if (segundo.isEmpty)d2 = 100;
    if (terceiro.isEmpty)d3 = 100;
    if (quarto.isEmpty)d4 = 100;
    if (quinto.isEmpty)d5 = 100;
    if (sexto.isEmpty)d6 = 100;
    if (setimo.isEmpty)d7 = 100;
    if (oitavo.isEmpty)d8 = 100;
    if (nono.isEmpty)d9 = 100;
    if (decimo.isEmpty)d10 = 100;

    // Uma lista com a distâncias aé cada Beacon no momento
    var momentum = [d1,d2,d3,d4,d5,d6,d7,d8,d9,d10];
    // Descubro a menor distância
    var dist = momentum.reduce((value, element) => value < element ? value : element);
    
    // Limpeza das listas individuais antes do próximo momento
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
      return { "D7:05:E8:A5:81:6D": dist};
    } else if (dist == d2) {
      return { "E4:D9:1C:68:10:5F": dist};
    } else if (dist == d3) {
      return { "EA:99:49:8F:A4:B7": dist};
    } else if (dist == d4) {
      return { "F8:13:A7:AC:D2:18": dist};
    } else if (dist == d5) {
      return { "F6:66:FC:FD:B0:AF": dist};
    } else if (dist == d6) {
      return { "EF:29:E0:C0:C7:FC": dist};
    } else if (dist == d7) {
      return { "F2:55:56:32:1E:5A": dist};
    } else if (dist == d8) {
      return { "F1:D4:36:55:33:C2": dist};
    } else if (dist == d9) {
      return { "DD:59:6C:57:E9:0F": dist}; 
    } else if (dist == d10) {
      return { "D2:9A:07:1A:74:44": dist};
    } else {
      return { "Nenhum": 100};
    }
  }

  // Referencia: https://www.flybuy.com/2018-11-19-fundamentals-of-beacon-ranging#:~:text=Mobile%20devices%20can%20estimate%20the,beacon's%20signal%20level%20as%20RSSI.
  // Retorna a distancia em metros com uso do RSSI e txPower
  double calculaDistancia(int rssi, int txPower) {
    if (rssi == 0) {
      // Retorna -1 caso a distancia nao possa ser calculada
      return -1.0;
    }
    double ratio = rssi * 1.0 / txPower;
    if (ratio < 1.0) {
      double distancia = (1.00) * pow(ratio, 10.00);
      return distancia;
    } else {
      double distancia = (0.89976) * pow(ratio, 7.7095) + 0.111;
      return distancia;
    }
  }

  // Retorna um valor após aplicar uma média móvel sobre um conjunto de 20 valores de accuracy
  double movingAverage(List<Beacon> distancia) {
    List resultado = [];
    double temp = 0;
    for (var i = 0; i < 17; i = i + 4) {
      temp += distancia[i].accuracy;
      temp += distancia[i + 1].accuracy;
      temp += distancia[i + 2].accuracy;
      temp += distancia[i + 3].accuracy;
      temp = temp / 4;
      resultado.add(temp);
      temp = 0;
    }
    double soma = 0;
    for (var i = 0; i < 5; i++) {
      soma += resultado[i];
    }
    return soma / 5;
  }

  // Retorna a media dos valores de accuracy lidos
  double mediaDistancia(List<Beacon> listaBeacons) {
    double media = 0;
    for (var i = 0; i < listaBeacons.length; i++) {
      media = media + listaBeacons[i].accuracy;
      dev.log("Valor sendo somado: " + listaBeacons[i].accuracy.toString());
    }
    media = media / listaBeacons.length;
    return media;
  }
}
