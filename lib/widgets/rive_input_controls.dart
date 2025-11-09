import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import '../models/rive_input_model.dart';
import '../providers/rive_provider.dart';

class RiveInputControls extends StatelessWidget {
  const RiveInputControls({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RiveProvider>();
    final inputs = provider.inputs;

    if (inputs.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("No inputs available for this State Machine."),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: inputs.length,
      itemBuilder: (context, i) {
        final input = inputs[i];
        switch (input.type) {
          case RiveInputType.boolean:
            return SwitchListTile(
              title: Text(input.name),
              value: (input.input as SMIBool).value,
              onChanged: (v) => provider.setBool(input.name, v),
            );
          case RiveInputType.trigger:
            return ListTile(
              title: Text("${input.name} (Trigger)"),
              trailing: ElevatedButton(
                onPressed: () => provider.fireTrigger(input.name),
                child: const Text("Fire"),
              ),
            );
          case RiveInputType.number:
            return ListTile(
              title: Text(input.name),
              subtitle: Slider(
                min: 0,
                max: 100,
                divisions: 100,
                value: (input.input as SMINumber).value,
                onChanged: (v) => provider.setNumber(input.name, v),
              ),
            );
        }
      },
    );
  }
}
