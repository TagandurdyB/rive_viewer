import 'dart:io';
import 'dart:typed_data';
import 'package:rive/rive.dart';

class RiveLoader {
  static Future<Artboard?> loadFromFile(File file) async {
    try {
      final Uint8List bytes = await file.readAsBytes();
      final ByteData data = ByteData.sublistView(bytes);
      final RiveFile riveFile = RiveFile.import(data);
      return riveFile.mainArtboard;
    } catch (e) {
      print('Failed to load Rive file: $e');
      return null;
    }
  }
}
