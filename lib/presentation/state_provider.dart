import 'package:flutter/material.dart';
import 'package:voicedocreader/domain/document_model.dart';
import 'package:voicedocreader/data/file_parser.dart';
import 'package:voicedocreader/utils/tts_manager.dart';
import 'package:voicedocreader/utils/speech_manager.dart';

class AppStateProvider with ChangeNotifier {
  final TTSManager ttsManager = TTSManager();
  final SpeechManager speechManager = SpeechManager();
  
  DocumentModel? currentDocument;
  String extractedText = "";
  bool isLoading = false;
  double speechRate = 0.5;

  AppStateProvider() {
    ttsManager.init();
    speechManager.init();
  }

  Future<void> loadDocument(DocumentModel document) async {
    isLoading = true;
    notifyListeners();
    
    currentDocument = document;
    extractedText = await FileParser.extractText(document.path, document.type);
    
    isLoading = false;
    notifyListeners();
  }

  void setSpeechRate(double rate) {
    speechRate = rate;
    ttsManager.setRate(rate);
    notifyListeners();
  }

  void handleVoiceCommand(String command) {
    command = command.toLowerCase();
    if (command.contains("start reading")) {
      ttsManager.speak(extractedText);
    } else if (command.contains("stop reading")) {
      ttsManager.stop();
    } else if (command.contains("pause reading")) {
      ttsManager.pause();
    }
  }
}
