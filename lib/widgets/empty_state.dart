import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final VoidCallback onPick;

  const EmptyState({super.key, required this.onPick});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.folder_open, size: 100, color: Colors.grey),
          const SizedBox(height: 12),
          const Text('Tap below to open a .riv file'),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: onPick,
            icon: const Icon(Icons.add),
            label: const Text('Open File'),
          ),
        ],
      ),
    );
  }
}
