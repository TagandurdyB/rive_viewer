import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import '../providers/rive_provider.dart';

class RiveCanvas extends StatelessWidget {
  const RiveCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RiveProvider>();
    final artboard = provider.artboard;

    if (artboard == null) {
      return const Center(
        child: Text(
          'No .riv file loaded',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          color: Colors.black12,
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: Rive(
                  artboard: artboard,
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
