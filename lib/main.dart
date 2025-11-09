import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/rive_provider.dart';
import 'screens/rive_viewer_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RiveProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rive Viewer',
        theme: ThemeData.dark(useMaterial3: true),
        home: const RiveViewerScreen(),
      ),
    );
  }
}
