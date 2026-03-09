import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voicedocreader/presentation/screens/home_screen.dart';
import 'package:voicedocreader/presentation/state_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppStateProvider(),
      child: const VoiceDocReaderApp(),
    ),
  );
}

class VoiceDocReaderApp extends StatelessWidget {
  const VoiceDocReaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VoiceDoc Reader',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
