import 'package:rive/rive.dart';

class RiveFileModel {
  final String name;
  final Artboard artboard;
  final List<String> animations;

  RiveFileModel({
    required this.name,
    required this.artboard,
    required this.animations,
  });
}
