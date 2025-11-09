import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/rive_provider.dart';

class AnimationSelector extends StatelessWidget {
  const AnimationSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RiveProvider>();
    final animations = provider.currentFile?.animations ?? [];

    if (animations.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<String>(
        value: provider.activeAnimation,
        decoration: const InputDecoration(
          labelText: 'Select Animation',
          border: OutlineInputBorder(),
        ),
        items: animations
            .map((name) => DropdownMenuItem(
                  value: name,
                  child: Text(name),
                ))
            .toList(),
        onChanged: (value) => provider.setAnimation(value),
      ),
    );
  }
}
