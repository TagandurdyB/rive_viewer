import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import '../providers/rive_provider.dart';
import '../widgets/rive_canvas.dart';
import '../widgets/animation_selector.dart';
import '../widgets/rive_input_controls.dart';

class RiveViewerScreen extends StatelessWidget {
  const RiveViewerScreen({super.key});

  Future<void> _pickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['riv'],
    );
    if (result != null && result.files.single.path != null) {
      await context.read<RiveProvider>().loadFile(
        File(result.files.single.path!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RiveProvider>();
    final hasFile = provider.currentFile != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(provider.currentFile?.name ?? "Rive Viewer"),
        actions: [
          IconButton(
            icon: const Icon(Icons.folder_open),
            tooltip: "Open .riv file",
            onPressed: () => _pickFile(context),
          ),
        ],
      ),
      body: !hasFile
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.movie_creation_outlined,
                      size: 80,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "No Rive file loaded",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Tap the folder icon above to open a .riv animation file.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              children: [
                // Rive canvas
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const RiveCanvas(),
                    ),
                  ),
                ),

                // State machine selector
                const AnimationSelector(),

                // Input controls
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    color: Colors.grey.shade100,
                    child: const RiveInputControls(),
                  ),
                ),
              ],
            ),
    );
  }
}
