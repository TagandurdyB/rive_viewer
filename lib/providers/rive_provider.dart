import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:rive/rive.dart';
import '../core/rive_loader.dart';
import '../models/rive_file_model.dart';

class RiveProvider extends ChangeNotifier {
  RiveFileModel? _currentFile;
  RiveAnimationController? _controller;
  String? _activeAnimation;

  RiveFileModel? get currentFile => _currentFile;
  String? get activeAnimation => _activeAnimation;
  Artboard? get artboard => _currentFile?.artboard;

  Future<void> loadFile(File file) async {
    final artboard = await RiveLoader.loadFromFile(file);
    if (artboard == null) return;

    final animations = artboard.animations.map((a) => a.name).toList();

    _currentFile = RiveFileModel(
      name: file.path.split('/').last,
      artboard: artboard,
      animations: animations,
    );

    if (animations.isNotEmpty) {
      setAnimation(animations.first);
    }

    notifyListeners();
  }

  void setAnimation(String? name) {
    if (name == null || _currentFile == null) return;

    // Remove old controller if it exists
    if (_controller != null) {
      _currentFile!.artboard.removeController(_controller!);
    }

    // Create new controller and add to artboard
    final newController = SimpleAnimation(name);
    _currentFile!.artboard.addController(newController);

    _controller = newController;
    _activeAnimation = name;

    notifyListeners();
  }

  void clear() {
    if (_controller != null && _currentFile != null) {
      _currentFile!.artboard.removeController(_controller!);
    }

    _currentFile = null;
    _controller = null;
    _activeAnimation = null;

    notifyListeners();
  }
}
