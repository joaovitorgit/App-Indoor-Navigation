import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter_tts/flutter_tts.dart';

class RequirementNode extends GetxController {
  final FlutterTts flutterTts = FlutterTts();
  bool visited = false;
  var id = ''; 
  var descricao = ''; 
  var mac = ''; 
  var comandos = ''; 

  defineValores(String id, String descricao, String mac, String comandos) {
    this.id = id;
    this.descricao = descricao;
    this.mac = mac;
    this.comandos = comandos;
  }

  getMac() {
    return mac;
  }

  getVisited() {
    return visited;
  }

  setVisited() {
    visited = true;
  }

  getLocalizacao() async {
    await flutterTts.speak(descricao);
  }

  getComandos() async {
    await flutterTts.speak(comandos);
  }
}
