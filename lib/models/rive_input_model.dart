import 'package:rive/rive.dart';

enum RiveInputType { boolean, trigger, number }

class RiveInputModel {
  final String name;
  final RiveInputType type;
  final SMIInput<dynamic> input;

  RiveInputModel({
    required this.name,
    required this.type,
    required this.input,
  });
}
