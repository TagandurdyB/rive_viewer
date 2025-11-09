import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/rive_provider.dart';
import '../widgets/rive_canvas.dart';
import '../widgets/animation_selector.dart';
import '../widgets/empty_state.dart';

class ViewerScreen extends StatelessWidget {
  const ViewerScreen({super.key});

  Future<void> _pickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['riv'],
    );

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      await context.read<RiveProvider>().loadFile(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RiveProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rive Viewer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.folder_open),
            onPressed: () => _pickFile(context),
          ),
          if (provider.currentFile != null)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => provider.clear(),
            ),
        ],
      ),
      body: provider.currentFile == null
          ? EmptyState(onPick: () => _pickFile(context))
          : Column(
              children: const [
                Expanded(child: RiveCanvas()),
                AnimationSelector(),
                SizedBox(height: 8),
              ],
            ),
    );
  }
}
