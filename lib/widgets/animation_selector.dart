import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/rive_provider.dart';

class AnimationSelector extends StatelessWidget {
  const AnimationSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RiveProvider>();
    final machines = provider.currentFile?.animations ?? []; // State machines list

    if (machines.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(12.0),
        child: Text(
          "No State Machines found in this file.",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<String>(
        value: provider.activeMachine,
        decoration: InputDecoration(
          labelText: 'Select State Machine',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
        dropdownColor: Colors.white,
        items: machines
            .map(
              (name) => DropdownMenuItem(
                value: name,
                child: Text(
                  name,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          if (value != null) {
            provider.setStateMachine(value);
          }
        },
      ),
    );
  }
}
