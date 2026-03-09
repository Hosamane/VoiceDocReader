import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:voicedocreader/domain/document_model.dart';
import 'package:voicedocreader/presentation/state_provider.dart';
import 'package:voicedocreader/presentation/screens/reader_screen.dart';
import 'dart:io';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppStateProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('VoiceDoc Reader')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.description, size: 100, color: Colors.deepPurple),
            const SizedBox(height: 20),
            const Text(
              'Upload → Search → Listen',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf', 'docx', 'txt'],
                );

                if (result != null) {
                  final file = result.files.single;
                  final document = DocumentModel(
                    name: file.name,
                    path: file.path!,
                    size: file.size,
                    lastModified: DateTime.now(),
                    type: _getType(file.extension!),
                  );
                  await appState.loadDocument(document);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ReaderScreen()),
                  );
                }
              },
              icon: const Icon(Icons.upload_file),
              label: const Text('Upload File'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Search functionality placeholder
              },
              icon: const Icon(Icons.search),
              label: const Text('Search Files'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
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

  DocumentType _getType(String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf': return DocumentType.pdf;
      case 'docx': return DocumentType.docx;
      case 'txt': return DocumentType.txt;
      default: return DocumentType.other;
    }
  }
}
