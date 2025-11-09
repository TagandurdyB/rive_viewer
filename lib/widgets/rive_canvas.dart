import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import '../providers/rive_provider.dart';

class RiveCanvas extends StatelessWidget {
  const RiveCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RiveProvider>();

    if (provider.artboard == null) {
      return const Center(
        child: Text('No .riv file loaded'),
      );
    }

    return Center(
      child: AspectRatio(
        aspectRatio: 1,
        child: Rive(artboard: provider.artboard!),
      ),
    );
  }
}
