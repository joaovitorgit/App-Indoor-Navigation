import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// Controller for managing a navigation node and its properties.
class RequirementNode extends GetxController {
  final FlutterTts flutterTts = FlutterTts();
  bool _visited = false;
  String _id = '';
  String _description = '';
  String _mac = '';
  String _commands = '';

  /// Set node values.
  void setValues(String id, String description, String mac, String commands) {
    _id = id;
    _description = description;
    _mac = mac;
    _commands = commands;
  }

  String get mac => _mac;
  bool get visited => _visited;
  String get id => _id;
  String get description => _description;
  String get commands => _commands;

  void markVisited() {
    _visited = true;
  }

  /// Speak the node's description using TTS.
  Future<void> speakDescription() async {
    await flutterTts.speak(_description);
  }

  /// Speak the node's commands using TTS.
  Future<void> speakCommands() async {
    await flutterTts.speak(_commands);
  }
}
