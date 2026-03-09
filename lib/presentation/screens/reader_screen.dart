import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voicedocreader/presentation/state_provider.dart';

class ReaderScreen extends StatelessWidget {
  const ReaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppStateProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(appState.currentDocument?.name ?? 'Reader'),
      ),
      body: appState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        appState.extractedText,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.play_arrow, size: 40),
                        onPressed: () => appState.ttsManager.speak(appState.extractedText),
                      ),
                      IconButton(
                        icon: const Icon(Icons.pause, size: 40),
                        onPressed: () => appState.ttsManager.pause(),
                      ),
                      IconButton(
                        icon: const Icon(Icons.stop, size: 40),
                        onPressed: () => appState.ttsManager.stop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text('Speed: '),
                      Expanded(
                        child: Slider(
                          value: appState.speechRate,
                          min: 0.1,
                          max: 1.0,
                          onChanged: (value) => appState.setSpeechRate(value),
                        ),
                      ),
                      Text('${(appState.speechRate * 2).toStringAsFixed(1)}x'),
                    ],
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          appState.speechManager.startListening((command) {
            appState.handleVoiceCommand(command);
          });
        },
        child: const Icon(Icons.mic),
      ),
    );
  }
}
