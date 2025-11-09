import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import '../core/rive_loader.dart';
import '../models/rive_file_model.dart';
import '../models/rive_input_model.dart';

class RiveProvider extends ChangeNotifier {
  RiveFileModel? _currentFile;
  StateMachineController? _controller;
  String? _activeMachine;
  List<RiveInputModel> _inputs = [];

  RiveFileModel? get currentFile => _currentFile;
  Artboard? get artboard => _currentFile?.artboard;
  List<RiveInputModel> get inputs => _inputs;
  String? get activeMachine => _activeMachine;

  Future<void> loadFile(File file) async {
    final artboard = await RiveLoader.loadFromFile(file);
    if (artboard == null) return;

    final machines = artboard.stateMachines.map((m) => m.name).toList();

    _currentFile = RiveFileModel(
      name: file.path.split('/').last,
      artboard: artboard,
      animations: machines,
    );

    if (machines.isNotEmpty) {
      setStateMachine(machines.first);
    } else {
      _inputs = [];
      notifyListeners();
    }
  }

  void setStateMachine(String? name) {
    if (name == null || _currentFile == null) return;

    final artboard = _currentFile!.artboard;
    if (_controller != null) artboard.removeController(_controller!);

    _controller = StateMachineController.fromArtboard(artboard, name);
    if (_controller == null) return;

    artboard.addController(_controller!);
    _activeMachine = name;

    _inputs = _controller!.inputs.map((i) {
      final type = i is SMIBool
          ? RiveInputType.boolean
          : i is SMITrigger
              ? RiveInputType.trigger
              : RiveInputType.number;
      return RiveInputModel(name: i.name, type: type, input: i);
    }).toList();

    notifyListeners();
  }

  void setBool(String name, bool value) {
    final input = _inputs.firstWhere((i) => i.name == name && i.type == RiveInputType.boolean, orElse: () => throw Exception("Bool not found"));
    (input.input as SMIBool).value = value;
    notifyListeners();
  }

  void fireTrigger(String name) {
    final input = _inputs.firstWhere((i) => i.name == name && i.type == RiveInputType.trigger, orElse: () => throw Exception("Trigger not found"));
    (input.input as SMITrigger).fire();
    notifyListeners();
  }

  void setNumber(String name, double value) {
    final input = _inputs.firstWhere((i) => i.name == name && i.type == RiveInputType.number, orElse: () => throw Exception("Number not found"));
    (input.input as SMINumber).value = value;
    notifyListeners();
  }
}
